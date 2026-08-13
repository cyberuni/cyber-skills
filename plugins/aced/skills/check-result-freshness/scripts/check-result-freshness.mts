#!/usr/bin/env node
// check-result-freshness — the guard engine that decides whether an ACED result is still safe to
// present as current and passing. Loaded by `run` and `improve`, and runnable standalone.
//
// This exists because a green ACED result is easy to over-claim. Two failure modes were hit
// repeatedly in real use, both while a result was still the newest file in `results/`:
//
//   1. STALENESS — the subject (a SKILL.md/subagent/command/AGENTS.md section and the asset or
//      reference files it loads) got edited after the run. The result now describes a subject that
//      no longer exists on disk, but nothing checks that, so it keeps reading as current.
//   2. OVER-CLAIMED PASSES — a run can report a high pass rate where some of those passes rest on
//      assertions the judge cannot actually settle (e.g. "this command did NOT run") because
//      aced-case-judge only ever scores a *narrated* transcript from a context that executes
//      nothing. A transcript cannot establish absence.
//
// `plugins/aced/skills/run/SKILL.md` documents the result JSON shape (timestamp, target, pass_rate,
// scenarios[]) but treats it as an example, not a closed schema — real results may carry more
// fields. This engine reads only the documented fields as required and treats everything else
// (including the trust-signal fields below) as optional, so it degrades gracefully against older or
// leaner results instead of rejecting them outright.
//
// ACED's judge protocol (plugins/aced/agents/aced-case-judge.md) does not yet emit a structured
// "this pass is unprovable" flag — an unreadable transcript is a hard BLOCKER (score nothing), not a
// soft flag on a pass. Until it does, this engine ALSO reads two optional structured conventions
// (should a future judge start emitting them) and, as the honest fallback available today, scans
// each passing scenario's own `what_worked`/`what_failed` prose for language the judge itself would
// use to hedge an assertion it could not settle. The optional structured fields:
//   - top-level `suite_defects: (string | { scenario?: string; note?: string })[]`
//   - per-scenario `untrusted: boolean` or `trust: "untrusted" | "unprovable"`
//   - top-level `untrusted_passes: (string | { scenario?: string; note?: string })[]`
// None of these are part of run/SKILL.md's documented shape today — treat their presence here as
// this engine's own optional extension point, not an existing ACED convention.
//
// Resolving "the subject's dependent files" is inherently approximate for a config that is prose,
// not code. Rather than silently checking less than it claims, this engine states exactly what it
// checked: the subject file itself, every file under sibling `assets/` and `references/`
// directories (the two conventional skill subdirs a subject "loads"), any `assets/...` or
// `references/...` path referenced in the subject's own text, and the node's frozen `.feature`.
// `scripts/` is deliberately excluded — those are invoked by the agent, not loaded into its context,
// so a script edit changing runtime behavior is a real risk this engine does not claim to cover.
//
// Exit 0 = safe to present as current and passing (a warnings-only result still exits 0, since the
// staleness/failure question is what gates presentability; warnings must still be surfaced, never
// summarised away). Exit 1 = do not present this result as current or passing.
//
// Pure functions are exported for node:test; running the file directly drives the CLI. No deps
// beyond node:fs, node:path, node:url (the repo's node-≥23.6 / no-deps convention).

import { existsSync, readdirSync, readFileSync, realpathSync, statSync } from 'node:fs'
import { basename, dirname, join, relative } from 'node:path'
import { pathToFileURL } from 'node:url'

// ── eval.md / subject resolution ──

// Extract the `subject:` scalar from an eval.md's frontmatter block. Returns undefined when the
// frontmatter or the key is absent — never throws.
export function extractSubject(evalMdText: string): string | undefined {
	const fm = /^---\r?\n([\s\S]*?)\r?\n---/.exec(evalMdText)?.[1] ?? ''
	const m = /^subject:\s*(.+)$/m.exec(fm)
	return m?.[1]?.trim().replace(/^["']|["']$/g, '')
}

// The frozen `.feature` colocated with `nodeDir`'s eval.md, named after the node directory itself
// (the convention every eval-run node in this repo follows: `<node>/eval.md` + `<node>/<node>.feature`).
export function featurePathFor(nodeDir: string): string {
	return join(nodeDir, `${basename(nodeDir)}.feature`)
}

const ASSET_REF_RE = /(?:assets|references)\/[\w.-]+(?:\/[\w.-]+)*/g

function listFilesRecursive(dir: string): string[] {
	if (!existsSync(dir)) return []
	const out: string[] = []
	for (const entry of readdirSync(dir, { withFileTypes: true })) {
		const full = join(dir, entry.name)
		if (entry.isDirectory()) out.push(...listFilesRecursive(full))
		else if (entry.isFile()) out.push(full)
	}
	return out
}

export interface SubjectFiles {
	// Absolute paths of every file this engine checked for staleness.
	files: string[]
	// Repo-relative path of the subject itself, unresolved further — reported so a caller can see
	// exactly what was treated as "the subject".
	subjectAbs: string
}

// Resolve the subject's dependent files: the subject itself, every file under sibling `assets/` and
// `references/` directories, any `assets/...`/`references/...` path referenced in the subject's own
// text, and the node's `.feature` (when it exists). `root` is the repo root; `subjectRel` is the
// repo-relative `subject:` value from eval.md; `nodeDir` is the eval.md's own directory.
export function resolveSubjectFiles(root: string, subjectRel: string, nodeDir: string): SubjectFiles {
	const subjectAbs = join(root, subjectRel)
	const subjectDir = dirname(subjectAbs)
	const files = new Set<string>()

	if (existsSync(subjectAbs) && statSync(subjectAbs).isFile()) files.add(subjectAbs)

	for (const sub of ['assets', 'references']) {
		for (const f of listFilesRecursive(join(subjectDir, sub))) files.add(f)
	}

	if (existsSync(subjectAbs)) {
		const text = readFileSync(subjectAbs, 'utf8')
		for (const m of text.matchAll(ASSET_REF_RE)) {
			const candidate = join(subjectDir, m[0])
			if (existsSync(candidate) && statSync(candidate).isFile()) files.add(candidate)
		}
	}

	const feature = featurePathFor(nodeDir)
	if (existsSync(feature) && statSync(feature).isFile()) files.add(feature)

	return { files: [...files], subjectAbs }
}

// ── locating the latest result ──

// Best-effort slug of a repo-relative subject path, matching the convention run/SKILL.md describes
// ("a filesystem-safe slug of the target agent-configuration path"). `run` is agent-authored prose,
// not code, so this is a guess, not a contract — findLatestResult() verifies it against each
// candidate result's own recorded `target` field rather than trusting the directory name alone.
export function slugify(subjectRel: string): string {
	return subjectRel
		.replace(/^\.\//, '')
		.replace(/\/SKILL\.md$/i, '')
		.replace(/\.md$/i, '')
		.replace(/[\\/]/g, '-')
		.replace(/[^a-zA-Z0-9._-]/g, '-')
		.toLowerCase()
}

interface ReadJsonResult {
	ok: boolean
	data?: unknown
	error?: string
}

function readJsonSafe(file: string): ReadJsonResult {
	try {
		return { ok: true, data: JSON.parse(readFileSync(file, 'utf8')) }
	} catch (e) {
		return { ok: false, error: e instanceof Error ? e.message : String(e) }
	}
}

function jsonFilesIn(dir: string): string[] {
	if (!existsSync(dir)) return []
	return readdirSync(dir)
		.filter((f) => f.endsWith('.json'))
		.sort()
		.map((f) => join(dir, f))
}

function timestampOf(file: string, data: Record<string, unknown>): number {
	const ts = typeof data.timestamp === 'string' ? Date.parse(data.timestamp) : Number.NaN
	if (!Number.isNaN(ts)) return ts
	return statSync(file).mtimeMs
}

export type FindResultOutcome =
	| {
			status: 'found'
			file: string
			data: Record<string, unknown>
			strategy: 'slug-directory' | 'target-scan'
			malformed: string[]
	  }
	| { status: 'none'; reason: string; malformed: string[] }
	| { status: 'malformed'; malformed: string[] }

// Locate the newest result recorded for `subjectRel`. Tries the guessed slug directory first
// (fast path); when that directory is absent, falls back to scanning every result file under
// `.agents/aced/results/` and matching by its own recorded `target` field, which is authoritative
// regardless of how the containing directory happened to be named.
export function findLatestResult(root: string, subjectRel: string): FindResultOutcome {
	const resultsRoot = join(root, '.agents', 'aced', 'results')
	const malformed: string[] = []

	if (!existsSync(resultsRoot))
		return { status: 'none', reason: `no results directory at ${relative(root, resultsRoot)}`, malformed }

	const primaryDir = join(resultsRoot, slugify(subjectRel))
	if (existsSync(primaryDir)) {
		const files = jsonFilesIn(primaryDir)
		for (let i = files.length - 1; i >= 0; i--) {
			const r = readJsonSafe(files[i]!)
			if (r.ok)
				return {
					status: 'found',
					file: files[i]!,
					data: r.data as Record<string, unknown>,
					strategy: 'slug-directory',
					malformed,
				}
			malformed.push(files[i]!)
		}
		if (files.length > 0) return { status: 'malformed', malformed }
	}

	const candidates: { file: string; data: Record<string, unknown> }[] = []
	for (const dirEntry of readdirSync(resultsRoot, { withFileTypes: true })) {
		if (!dirEntry.isDirectory()) continue
		for (const file of jsonFilesIn(join(resultsRoot, dirEntry.name))) {
			const r = readJsonSafe(file)
			if (!r.ok) {
				malformed.push(file)
				continue
			}
			const data = r.data as Record<string, unknown>
			const target = typeof data.target === 'string' ? data.target.replace(/^\.\//, '').trim() : undefined
			if (target === subjectRel.replace(/^\.\//, '').trim()) candidates.push({ file, data })
		}
	}

	if (candidates.length === 0)
		return { status: 'none', reason: `no result recorded with target "${subjectRel}"`, malformed }

	candidates.sort((a, b) => timestampOf(a.file, a.data) - timestampOf(b.file, b.data))
	const best = candidates.at(-1)!
	return { status: 'found', file: best.file, data: best.data, strategy: 'target-scan', malformed }
}

// ── staleness ──

export interface StalenessCheck {
	stale: boolean
	newer: string[]
}

// A subject file is stale relative to a result when its mtime is newer than the result's recorded
// timestamp — the result describes the subject as it was, not as it now is.
export function checkStaleness(subjectFiles: string[], resultTimestamp: number): StalenessCheck {
	const newer = subjectFiles.filter((f) => existsSync(f) && statSync(f).mtimeMs > resultTimestamp)
	return { stale: newer.length > 0, newer }
}

// ── trust ──

const DOUBT_PATTERNS = [
	/cannot (?:be )?verif/i,
	/cannot confirm/i,
	/cannot (?:be )?settle/i,
	/cannot establish/i,
	/cannot prove/i,
	/no way to (?:confirm|verify|know)/i,
	/unable to (?:verify|confirm)/i,
	/not (?:actually )?verifiable/i,
	/narrated (?:transcript|only)/i,
	/assum(?:e|ed|ing) (?:it|the|that)/i,
]

export interface TrustCheck {
	fail: string[]
	warn: string[]
}

function asNoteList(v: unknown, fallback: string): string[] {
	if (!Array.isArray(v)) return []
	return v.map((item) => {
		if (typeof item === 'string') return item
		if (item && typeof item === 'object') {
			const o = item as Record<string, unknown>
			const label = typeof o.scenario === 'string' ? o.scenario : fallback
			const note = typeof o.note === 'string' ? o.note : ''
			return note ? `${label}: ${note}` : label
		}
		return fallback
	})
}

// Inspect a result's recorded scenarios for failures and for passes that must not be counted as
// clean evidence: failing scenarios, an explicit implementation_pass: false, scenarios the judge (or
// a future structured convention) flagged untrusted/unprovable, recorded suite defects, and — since
// no structured flag exists yet — passing scenarios whose own WHAT WORKED/WHAT FAILED prose hedges
// in language a judge uses when it could not settle an assertion.
export function checkTrust(data: Record<string, unknown>): TrustCheck {
	const fail: string[] = []
	const warn: string[] = []

	if (data.implementation_pass === false) fail.push('result records implementation_pass: false')

	const scenarios = Array.isArray(data.scenarios) ? (data.scenarios as Record<string, unknown>[]) : []
	for (const s of scenarios) {
		const name = typeof s.name === 'string' ? s.name : '<unnamed scenario>'
		if (s.pass === false) fail.push(`scenario failed: ${name}`)

		const untrustedFlag = s.untrusted === true || s.trust === 'untrusted' || s.trust === 'unprovable'
		if (untrustedFlag) warn.push(`scenario flagged untrusted: ${name}`)

		if (s.pass === true) {
			const prose = `${typeof s.what_worked === 'string' ? s.what_worked : ''} ${typeof s.what_failed === 'string' ? s.what_failed : ''}`
			for (const pattern of DOUBT_PATTERNS) {
				const m = pattern.exec(prose)
				if (m) {
					warn.push(
						`scenario "${name}" passed but its own explanation hedges (heuristic match, not a structured field): "${m[0]}"`,
					)
					break
				}
			}
		}
	}

	warn.push(...asNoteList(data.untrusted_passes, '<unnamed pass>').map((n) => `untrusted pass recorded: ${n}`))
	warn.push(...asNoteList(data.suite_defects, '<unnamed defect>').map((n) => `suite defect recorded: ${n}`))

	return { fail, warn }
}

// ── the whole check ──

export type CheckStatus = 'ok' | 'warn' | 'stale' | 'fail' | 'none' | 'error'

export interface CheckReport {
	status: CheckStatus
	exitCode: 0 | 1
	messages: string[]
	notes: string[]
	checkedFiles?: string[]
	resultFile?: string
}

export function check(root: string, nodeDir: string): CheckReport {
	const evalMdPath = join(nodeDir, 'eval.md')
	if (!existsSync(evalMdPath)) {
		return { status: 'error', exitCode: 1, messages: [`no eval.md at ${relative(root, evalMdPath)}`], notes: [] }
	}

	const evalMdText = readFileSync(evalMdPath, 'utf8')
	const subjectRel = extractSubject(evalMdText)
	if (!subjectRel) {
		return {
			status: 'error',
			exitCode: 1,
			messages: [`${relative(root, evalMdPath)} has no subject: in its frontmatter`],
			notes: [],
		}
	}

	const { files: subjectFiles, subjectAbs } = resolveSubjectFiles(root, subjectRel, nodeDir)
	if (!existsSync(subjectAbs)) {
		return { status: 'error', exitCode: 1, messages: [`subject does not exist: ${subjectRel}`], notes: [] }
	}

	const found = findLatestResult(root, subjectRel)
	const checkedFiles = subjectFiles.map((f) => relative(root, f))

	if (found.status === 'malformed') {
		return {
			status: 'error',
			exitCode: 1,
			messages: [
				`every result file matched by directory is malformed JSON: ${found.malformed.map((f) => relative(root, f)).join(', ')}`,
			],
			notes: [],
			checkedFiles,
		}
	}
	if (found.status === 'none') {
		const notes =
			found.malformed.length > 0 ? [`skipped ${found.malformed.length} malformed result file(s) while scanning`] : []
		return {
			status: 'none',
			exitCode: 1,
			messages: [found.reason, 'run `run` before presenting anything as current.'],
			notes,
			checkedFiles,
		}
	}

	const notes: string[] = []
	if (found.malformed.length > 0)
		notes.push(`skipped ${found.malformed.length} malformed result file(s) while scanning`)
	if (found.strategy === 'target-scan')
		notes.push("matched by scanning each result's recorded target field — the guessed slug directory did not exist")

	const resultTimestamp = timestampOf(found.file, found.data)
	const staleness = checkStaleness(subjectFiles, resultTimestamp)
	const trust = checkTrust(found.data)

	const messages: string[] = []
	if (staleness.stale) {
		messages.push(
			`STALE — ${staleness.newer.length} subject file(s) changed after this result ran: ${staleness.newer.map((f) => relative(root, f)).join(', ')}`,
		)
	}
	messages.push(...trust.fail)

	const resultFile = relative(root, found.file)

	if (messages.length > 0) {
		return {
			status: staleness.stale ? 'stale' : 'fail',
			exitCode: 1,
			messages,
			notes: [...notes, ...trust.warn],
			checkedFiles,
			resultFile,
		}
	}
	if (trust.warn.length > 0) {
		return { status: 'warn', exitCode: 0, messages: trust.warn, notes, checkedFiles, resultFile }
	}
	return {
		status: 'ok',
		exitCode: 0,
		messages: [`${resultFile} is current and its recorded passes are unqualified`],
		notes,
		checkedFiles,
		resultFile,
	}
}

// ── CLI ──

function flag(argv: string[], name: string): string | undefined {
	const i = argv.indexOf(name)
	return i === -1 ? undefined : argv[i + 1]
}

function formatReport(report: CheckReport): string {
	const lines = [`check-result-freshness: ${report.status.toUpperCase()}`]
	if (report.resultFile) lines.push(`  result: ${report.resultFile}`)
	for (const m of report.messages) lines.push(`  ${report.status === 'ok' ? '·' : '✗'}  ${m}`)
	for (const n of report.notes) lines.push(`  ·  ${n}`)
	return lines.join('\n')
}

export function main(argv: string[]): number {
	const root = flag(argv, '--root') ?? '.'
	const node = flag(argv, '--node')
	const format = flag(argv, '--format') ?? 'text'

	if (!node) {
		process.stderr.write(
			'usage: check-result-freshness --node <path-to-spec-node-dir> [--root .] [--format text|json]\n',
		)
		return 2
	}

	const report = check(root, join(root, node))

	if (format === 'json') {
		process.stdout.write(`${JSON.stringify(report, null, 2)}\n`)
	} else {
		process.stdout.write(`${formatReport(report)}\n`)
	}
	return report.exitCode
}

if (process.argv[1] && import.meta.url === pathToFileURL(realpathSync(process.argv[1])).href) {
	process.exit(main(process.argv.slice(2)))
}
