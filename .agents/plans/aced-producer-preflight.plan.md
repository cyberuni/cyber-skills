---
cr-ref: aced-producer-preflight
project: aced
project-path: plugins/aced
status: in-progress
source: doctrine retro (doctrine-strategy-keep-or-cut.plan.md), Entry 5 — pre-ratified f5152c KEEP
ledger-shard: .agents/specs/aced/ledger/aced-producer-preflight.f68585.jsonl
todos:
  - id: intake
    content: "open CR against aced spec; scaffold plan + leash"
    status: complete
  - id: explore
    content: "resolve-governances; place criteria in aced-builder-spec bar + additive scenarios in scenario-writer; grill w/ cold spec-judge to ALIGNED"
    status: in-progress
  - id: spec-gate
    content: "spec-judge ALIGNED; freeze additive scenarios; self-assert approve by:agent to shard; STOP (no by:name, no status)"
    status: pending
  - id: deliver
    content: "author bar SKILL.md criteria + scenario-writer agent instructions to pass frozen suite; pnpm verify; rebase onto main"
    status: pending
  - id: impl-gate
    content: "cold impl-judge synchronous; every frozen scenario verified; self-assert approve by:agent to shard; STOP"
    status: pending
  - id: handoff
    content: "record followups to shard; report verdict packet up relay; NO PR/merge/ratify"
    status: pending
---

# CR: ACED producer pre-flight discipline (Entry 5)

Codify the **general** produce-time pre-flight the ACED spec-producer runs before freezing:
1. **Verify any asserted harness/tool behavior against the harness's own primary docs** — never from memory.
2. **Grep the corpus for a term before coining a new category name** — avoid collision + the costly multi-round rename.

Source: `.agents/specs/aced/ledger/strategy.f5152c.jsonl` seq1 (distills `133-guard-internal-descriptions`,
which reopened its own frozen suite 3x). Council-ratified KEEP (retro plan L94); cheap pre-flight, no A/B.

## Scope EXCLUSION (already landed — do NOT re-codify)
The specific facts that `user-invocable:false`/`metadata.internal` do not suppress auto-invocation, and the
"Partial Skill" naming, are documented at 3 aced sites (`define-skill`/`define-governance`/`improve-skill`).
Codify the GENERAL discipline only, never those specific facts (retro plan L98-100).

## Target & placement (confirmed in explore)
- **Bar** `plugins/aced/skills/aced-builder-spec/SKILL.md` — add the two produce-time criteria (the shared
  contract both faces load: producer self-aligns, judge grades backward).
- **Producer** `.agents/specs/aced/sdd-roles/scenario-writer/` — additive gradeable scenarios (producer runs
  the pre-flight) + Use Cases / CFG / Scenario-map rows in README.md. Additive → self-clearing, root stays
  `implemented`.
- Impl-side (deliver): the shipped `aced-builder-spec` bar + `aced-scenario-writer` agent instructions.

## Harness discipline (this run)
Headless automaton. Every judge SYNCHRONOUS + self-observed; NO relayed verdict recorded; sub-agents return
verdict as FINAL message (no SendMessage-by-name). Self-assert gates by:agent to the ledger shard; STOP at
each gate — the in-session channel-holder ratifies (by:name) + merges. Never write root `status` or
`approval` frontmatter; never open a PR.

## NEXT
Explore: run resolve-governances over the project registry; draft the two bar criteria + the additive
scenario-writer scenarios; dispatch the cold `aced-spec-validator` spec-judge synchronously; iterate to
ALIGNED (cap 3), then spec gate.
