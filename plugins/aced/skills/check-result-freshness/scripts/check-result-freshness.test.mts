// Verification for check-result-freshness — constructs a temp fixture (repo root with a subject
// SKILL.md + spec node + results directory) per scenario and asserts the engine's report against
// it. Run by the impl-judge; plain `node --test` strips the types (node >= 22.6
// --experimental-strip-types, node >= 24 natively).

import assert from 'node:assert/strict'
import { mkdirSync, mkdtempSync, rmSync, utimesSync, writeFileSync } from 'node:fs'
import { tmpdir } from 'node:os'
import { join } from 'node:path'
import { test } from 'node:test'
import {
	check,
	checkStaleness,
	checkTrust,
	extractSubject,
	featurePathFor,
	findLatestResult,
	main,
	resolveSubjectFiles,
	slugify,
} from './check-result-freshness.mts'

function tmp(): string {
	return mkdtempSync(join(tmpdir(), 'check-result-freshness-'))
}

function write(root: string, rel: string, content: string): string {
	const full = join(root, rel)
	mkdirSync(join(full, '..'), { recursive: true })
	writeFileSync(full, content)
	return full
}

function touch(path: string, date: Date): void {
	utimesSync(path, date, date)
}

const NOW = Date.now()
const OLD = new Date(NOW - 60 * 60 * 1000) // an hour ago
const NEW = new Date(NOW + 60 * 60 * 1000) // an hour from now

function baseFixture(root: string) {
	write(root, 'plugins/aced/skills/manage/SKILL.md', '# manage\nDoes manage things.\n')
	write(
		root,
		'.agents/specs/aced/manage/eval.md',
		'---\nsubject: plugins/aced/skills/manage/SKILL.md\neval:\n  layers:\n    - behavior\n---\n\nEval binding.\n',
	)
	write(root, '.agents/specs/aced/manage/manage.feature', 'Feature: manage\n  Scenario: x\n')
}

function writeResult(root: string, dir: string, file: string, data: Record<string, unknown>): string {
	return write(root, join('.agents/aced/results', dir, file), JSON.stringify(data, null, 2))
}

function cleanup(dir: string): void {
	rmSync(dir, { recursive: true, force: true })
}

// ── extractSubject / featurePathFor ──

test('extractSubject reads the subject: frontmatter scalar', () => {
	assert.equal(
		extractSubject('---\nsubject: plugins/aced/skills/manage/SKILL.md\n---\n'),
		'plugins/aced/skills/manage/SKILL.md',
	)
})

test('extractSubject returns undefined when the key is absent', () => {
	assert.equal(extractSubject('---\neval:\n  layers: []\n---\n'), undefined)
})

test('featurePathFor names the feature after the node directory', () => {
	assert.equal(featurePathFor('/repo/.agents/specs/aced/manage'), '/repo/.agents/specs/aced/manage/manage.feature')
})

// ── slugify ──

test('slugify strips the SKILL.md suffix and turns separators into dashes', () => {
	assert.equal(slugify('plugins/aced/skills/manage/SKILL.md'), 'plugins-aced-skills-manage')
})

// ── resolveSubjectFiles ──

test('Scenario: subject files include assets, references, and the referenced-but-elsewhere path, but not scripts', () => {
	const root = tmp()
	try {
		write(root, 'plugins/aced/skills/x/SKILL.md', 'See assets/template.md and references/notes.md.\n')
		write(root, 'plugins/aced/skills/x/assets/template.md', 'template\n')
		write(root, 'plugins/aced/skills/x/references/notes.md', 'notes\n')
		write(root, 'plugins/aced/skills/x/scripts/run.mts', 'export {}\n')
		write(root, '.agents/specs/aced/x/eval.md', '---\nsubject: plugins/aced/skills/x/SKILL.md\n---\n')

		const { files } = resolveSubjectFiles(root, 'plugins/aced/skills/x/SKILL.md', join(root, '.agents/specs/aced/x'))
		const rels = files.map((f) => f.slice(root.length + 1))

		assert.ok(rels.includes('plugins/aced/skills/x/SKILL.md'))
		assert.ok(rels.includes('plugins/aced/skills/x/assets/template.md'))
		assert.ok(rels.includes('plugins/aced/skills/x/references/notes.md'))
		assert.ok(!rels.some((r) => r.includes('scripts/')), 'scripts/ must not be included')
	} finally {
		cleanup(root)
	}
})

test('Scenario: the node feature is included when it exists', () => {
	const root = tmp()
	try {
		baseFixture(root)
		const { files } = resolveSubjectFiles(
			root,
			'plugins/aced/skills/manage/SKILL.md',
			join(root, '.agents/specs/aced/manage'),
		)
		assert.ok(files.some((f) => f.endsWith('manage.feature')))
	} finally {
		cleanup(root)
	}
})

// ── findLatestResult ──

test('Scenario: no results directory reports none', () => {
	const root = tmp()
	try {
		const r = findLatestResult(root, 'plugins/aced/skills/manage/SKILL.md')
		assert.equal(r.status, 'none')
	} finally {
		cleanup(root)
	}
})

test('Scenario: the slug directory is used when it exists, picking the lexically-latest file', () => {
	const root = tmp()
	try {
		writeResult(root, 'plugins-aced-skills-manage', '2024-01-01T00-00-00.json', {
			timestamp: '2024-01-01T00:00:00Z',
			target: 'plugins/aced/skills/manage/SKILL.md',
			scenarios: [],
		})
		writeResult(root, 'plugins-aced-skills-manage', '2024-06-01T00-00-00.json', {
			timestamp: '2024-06-01T00:00:00Z',
			target: 'plugins/aced/skills/manage/SKILL.md',
			scenarios: [],
		})
		const r = findLatestResult(root, 'plugins/aced/skills/manage/SKILL.md')
		assert.ok(r.status === 'found')
		if (r.status === 'found') {
			assert.equal(r.strategy, 'slug-directory')
			assert.ok(r.file.endsWith('2024-06-01T00-00-00.json'))
		}
	} finally {
		cleanup(root)
	}
})

test('Scenario: a mismatched slug directory falls back to scanning target fields', () => {
	const root = tmp()
	try {
		writeResult(root, 'some-other-name', '2024-01-01T00-00-00.json', {
			timestamp: '2024-01-01T00:00:00Z',
			target: 'plugins/aced/skills/manage/SKILL.md',
			scenarios: [],
		})
		const r = findLatestResult(root, 'plugins/aced/skills/manage/SKILL.md')
		assert.ok(r.status === 'found')
		if (r.status === 'found') assert.equal(r.strategy, 'target-scan')
	} finally {
		cleanup(root)
	}
})

test('Scenario: malformed JSON in the slug directory is reported, not thrown', () => {
	const root = tmp()
	try {
		writeResult(root, 'plugins-aced-skills-manage', '2024-01-01T00-00-00.json', { not: 'json' })
		const dir = join(root, '.agents/aced/results/plugins-aced-skills-manage')
		writeFileSync(join(dir, '2024-01-01T00-00-00.json'), '{ this is not valid json')
		const r = findLatestResult(root, 'plugins/aced/skills/manage/SKILL.md')
		assert.equal(r.status, 'malformed')
		assert.equal(r.malformed.length, 1)
	} finally {
		cleanup(root)
	}
})

// ── checkStaleness ──

test('Scenario: a subject file edited after the run is stale', () => {
	const root = tmp()
	try {
		const subject = write(root, 'x/SKILL.md', 'x\n')
		touch(subject, NEW)
		const s = checkStaleness([subject], OLD.getTime())
		assert.equal(s.stale, true)
		assert.deepEqual(s.newer, [subject])
	} finally {
		cleanup(root)
	}
})

test('Scenario: a subject unchanged since the run is not stale', () => {
	const root = tmp()
	try {
		const subject = write(root, 'x/SKILL.md', 'x\n')
		touch(subject, OLD)
		const s = checkStaleness([subject], NEW.getTime())
		assert.equal(s.stale, false)
	} finally {
		cleanup(root)
	}
})

// ── checkTrust ──

test('Scenario: a failing scenario is reported as fail', () => {
	const t = checkTrust({ scenarios: [{ name: 'a case', pass: false }] })
	assert.equal(t.fail.length, 1)
	assert.match(t.fail[0]!, /a case/)
})

test('Scenario: implementation_pass false is reported as fail', () => {
	const t = checkTrust({ implementation_pass: false, scenarios: [] })
	assert.equal(t.fail.length, 1)
})

test('Scenario: a scenario flagged untrusted is a warning, not a failure', () => {
	const t = checkTrust({ scenarios: [{ name: 'a case', pass: true, untrusted: true }] })
	assert.equal(t.fail.length, 0)
	assert.equal(t.warn.length, 1)
	assert.match(t.warn[0]!, /untrusted/)
})

test('Scenario: a passing scenario whose explanation hedges is flagged by the text heuristic', () => {
	const t = checkTrust({
		scenarios: [
			{
				name: 'no command ran',
				pass: true,
				what_failed: 'Cannot verify the command did not run from a narrated transcript.',
			},
		],
	})
	assert.equal(t.fail.length, 0)
	assert.equal(t.warn.length, 1)
	assert.match(t.warn[0]!, /no command ran/)
})

test('Scenario: a clean passing scenario raises no warning', () => {
	const t = checkTrust({ scenarios: [{ name: 'clean', pass: true, what_worked: 'Did the thing correctly.' }] })
	assert.equal(t.fail.length, 0)
	assert.equal(t.warn.length, 0)
})

test('Scenario: top-level suite_defects and untrusted_passes are surfaced as warnings', () => {
	const t = checkTrust({
		scenarios: [],
		suite_defects: ['ambiguous step in scenario Y'],
		untrusted_passes: ['scenario Z'],
	})
	assert.equal(t.warn.length, 2)
})

// ── check() end to end ──

test('Scenario: a fresh, clean result reports ok and exit 0', () => {
	const root = tmp()
	try {
		baseFixture(root)
		writeResult(root, 'plugins-aced-skills-manage', '2099-01-01T00-00-00.json', {
			timestamp: new Date(NOW + 10 * 24 * 60 * 60 * 1000).toISOString(),
			target: 'plugins/aced/skills/manage/SKILL.md',
			pass_rate: 1,
			scenarios: [{ name: 'a', pass: true }],
		})
		const report = check(root, join(root, '.agents/specs/aced/manage'))
		assert.equal(report.status, 'ok')
		assert.equal(report.exitCode, 0)
	} finally {
		cleanup(root)
	}
})

test('Scenario: a result older than an edited subject file is stale and exit 1', () => {
	const root = tmp()
	try {
		baseFixture(root)
		writeResult(root, 'plugins-aced-skills-manage', '2020-01-01T00-00-00.json', {
			timestamp: '2020-01-01T00:00:00Z',
			target: 'plugins/aced/skills/manage/SKILL.md',
			scenarios: [{ name: 'a', pass: true }],
		})
		const report = check(root, join(root, '.agents/specs/aced/manage'))
		assert.equal(report.status, 'stale')
		assert.equal(report.exitCode, 1)
		assert.match(report.messages[0]!, /STALE/)
	} finally {
		cleanup(root)
	}
})

test('Scenario: a result with a failing scenario is fail and exit 1 even if fresh', () => {
	const root = tmp()
	try {
		baseFixture(root)
		writeResult(root, 'plugins-aced-skills-manage', '2099-01-01T00-00-00.json', {
			timestamp: new Date(NOW + 10 * 24 * 60 * 60 * 1000).toISOString(),
			target: 'plugins/aced/skills/manage/SKILL.md',
			scenarios: [{ name: 'a', pass: false }],
		})
		const report = check(root, join(root, '.agents/specs/aced/manage'))
		assert.equal(report.status, 'fail')
		assert.equal(report.exitCode, 1)
	} finally {
		cleanup(root)
	}
})

test('Scenario: a fresh result with only an untrusted pass is warn and exit 0', () => {
	const root = tmp()
	try {
		baseFixture(root)
		writeResult(root, 'plugins-aced-skills-manage', '2099-01-01T00-00-00.json', {
			timestamp: new Date(NOW + 10 * 24 * 60 * 60 * 1000).toISOString(),
			target: 'plugins/aced/skills/manage/SKILL.md',
			scenarios: [{ name: 'a', pass: true, untrusted: true }],
		})
		const report = check(root, join(root, '.agents/specs/aced/manage'))
		assert.equal(report.status, 'warn')
		assert.equal(report.exitCode, 0)
	} finally {
		cleanup(root)
	}
})

test('Scenario: no result for the target reports none and exit 1', () => {
	const root = tmp()
	try {
		baseFixture(root)
		const report = check(root, join(root, '.agents/specs/aced/manage'))
		assert.equal(report.status, 'none')
		assert.equal(report.exitCode, 1)
	} finally {
		cleanup(root)
	}
})

test('Scenario: a missing eval.md is a hard error, not a crash', () => {
	const root = tmp()
	try {
		mkdirSync(join(root, '.agents/specs/aced/nope'), { recursive: true })
		const report = check(root, join(root, '.agents/specs/aced/nope'))
		assert.equal(report.status, 'error')
		assert.equal(report.exitCode, 1)
	} finally {
		cleanup(root)
	}
})

test('Scenario: eval.md with no subject: is a hard error, not a crash', () => {
	const root = tmp()
	try {
		write(root, '.agents/specs/aced/nope/eval.md', '---\neval:\n  layers: []\n---\n')
		const report = check(root, join(root, '.agents/specs/aced/nope'))
		assert.equal(report.status, 'error')
	} finally {
		cleanup(root)
	}
})

test('Scenario: a subject that no longer exists on disk is a hard error', () => {
	const root = tmp()
	try {
		write(root, '.agents/specs/aced/gone/eval.md', '---\nsubject: plugins/aced/skills/gone/SKILL.md\n---\n')
		const report = check(root, join(root, '.agents/specs/aced/gone'))
		assert.equal(report.status, 'error')
		assert.match(report.messages[0]!, /does not exist/)
	} finally {
		cleanup(root)
	}
})

// ── CLI ──

test('CLI: main returns 2 and writes usage when --node is missing', () => {
	assert.equal(main([]), 2)
})

test('CLI: main returns the check exit code for a valid --node', () => {
	const root = tmp()
	try {
		baseFixture(root)
		writeResult(root, 'plugins-aced-skills-manage', '2099-01-01T00-00-00.json', {
			timestamp: new Date(NOW + 10 * 24 * 60 * 60 * 1000).toISOString(),
			target: 'plugins/aced/skills/manage/SKILL.md',
			scenarios: [{ name: 'a', pass: true }],
		})
		assert.equal(main(['--node', '.agents/specs/aced/manage', '--root', root]), 0)
	} finally {
		cleanup(root)
	}
})
