---
cr-ref: 62-spec-reference-resolution
project-spec: .agents/specs/sdd
status: active
todos:
  - content: Place + classify the node under project-spec/; declare spec-type and concept
    status: pending
  - content: Settle the extraction rule — which strings are references, and the escape hatch
    status: pending
  - content: Author README.md + check-spec-references.feature (boolean scenarios)
    status: pending
  - content: Spec gate — cold spec-judge, freeze, ledger gate line
    status: pending
  - content: Build the engine + tests; wire it into check-project-specs' ENGINES
    status: pending
  - content: Fix the survivors the first run finds in this repo's own corpus
    status: pending
  - content: Impl gate — cold impl-judge, verification per frozen scenario
    status: pending
  - content: Handoff — changeset, PR, comment the landing PR on the source issue
    status: pending
---

# CR: check that every relative reference in a spec node resolves

Add `check-spec-references` beside the other project-spec engines: walk every `.md` under a
project spec, extract each explicitly-relative reference, resolve it against the file's own
directory, and fail on any that does not exist.

Source: `repobuddy/buddy-agent-harness#62`. A **different forge repo** from this one, so the PR
carries **no closing reference** — handoff comments the landing PR on the issue instead.

## Why

In the source repo every `../../../src/...` and `../../../skills/init/...` reference in the spec
corpus was off by one directory level and resolved to nothing. Not a typo — a **consistent
off-by-one** where each reference read as plausible: right filename, right-looking depth, wrong
level. Review by eye is what let them land; only resolving them catches it.

## Scope

- New unit: `.agents/specs/sdd/project-spec/check-spec-references/` + the skill
  `plugins/sdd/skills/check-spec-references/`.
- Wired into `check-project-specs`' `ENGINES` (the per-project entry point), `--spec-dir <d> --check`.

## Settled before drafting (spike, throwaway)

A prototype run over both corpora settled the extraction rule and turned up live survivors.

- **Only explicitly-relative references** (`./` or `../` prefixed) are extracted. A bare path in
  inline code is **not** a reference to resolve: the corpus is full of `cli/`, `skills/doctor/`,
  `.claude/skills`, `~/.codex/config.toml`, `.agents/skills/**/SKILL.md` — illustrative or
  repo-root-relative prose. Treating them as references would reject most of them. This is what
  makes the source issue's repo-root-relative trap
  (`.research/agentic-configuration-standards/`) pass **by construction**, not by exception.
- **Two forms**: markdown link targets `](./x)` / `](../x)`, and inline-code spans
  `` `../../../../src/foo.ts` ``.
- **Directories count** — a reference resolving to a directory passes, trailing slash and all.
- **The escape hatch is earned, not guessed.** One class of false positive is real and recurs
  across both corpora: prose that *quotes a path relative to something other than the file* —
  the text inside a bridge file, a symlink target relative to `.cursor/`. Both read exactly like a
  genuine anchor, so no structural narrowing separates them. An inline marker suppresses the line.

### Survivors the spike found (this repo, 12)

`cyberfleet-plugin/{README,spec}.md`, `sdd/corpus/discovery/README.md`,
`sdd/intake/{manage-ignore,plan-discovery,resolve-tracking}/README.md`,
`sdd/mission/{handoff,manage-scenario-bridge,resolution,verify-scenarios}/README.md`,
`sdd/plugin/README.md` — all the same off-by-one class. They land in this CR; the guard's first
run catching what it was built for is the precedent `check-retired-terms` set.

## NEXT — resume here

Start at todo 1. Nothing is drafted yet.
