---
cr-ref: 380
project: aced
node: .agents/specs/aced/config-authoring/improve-skill
status: in-progress
todos:
  - content: "Intake: locate aced spec, scaffold plan, branch sdd/380-partial-skill-classifier"
    status: completed
  - content: "Settle taxonomy with owner; ratify re-open across three suites"
    status: completed
  - content: "Doctrine: skill-design governance, ADR-0031, supersede ADR-0013, prose mirrors"
    status: completed
  - content: "Deliver: re-key validate.mts to the marker; retire Q17/Q18; update tests"
    status: pending
  - content: "Deliver: migrate 56 SKILL.md + 6 agent definitions to the marker description"
    status: pending
  - content: "Explore: rewrite frozen scenarios in the three affected .feature suites"
    status: pending
  - content: "Spec gate: cold spec-judge, re-freeze, ledger gate line, status write"
    status: pending
  - content: "Impl gate: cold impl-judge over frozen suites; pnpm verify from worktree root"
    status: pending
  - content: "Handoff: PR referencing #380, combat log, follow-up drain"
    status: pending
---

# CR 380 — skill selection must be independent of visibility

Source: GitHub issue #380 (cyberuni/cyberplace). Branch `sdd/380-partial-skill-classifier`, pushed.

## Change request

The `improve-skill` validate engine treats top-level `user-invocable: false` as the classifier for a
by-name skill, then forces the description to shed trigger language. That makes a
**hidden-but-situational** skill inexpressible — setting the flag breaks the trigger it depends on.

## Settled doctrine (ADR-0031, landed)

- `user-invocable` is a **visibility** flag only. It never signals how a skill is selected.
- A **name-only** skill declares itself with `description` set to exactly `"By name only"`.
- The minimal description **is** the enforcement, not a label for it — the description is the only
  surface the model matches against, so anything added is another handle for a spurious match.
- **"Partial"** (cannot run alone) is demoted to README prose. No check polices it: a self-contained
  engine and a fragment are selected identically and carry identical descriptions.

## Grounding (validated against current code — do not re-derive)

- `plugins/aced/skills/improve-skill/scripts/validate.mts` — `parseFrontmatter` sets `internal: true`
  from `^user-invocable:\s*false` (~L337); `const isPartialSkill = fmInternal` (~L491).
- `isPartialSkill` gates **five** checks: Q1 (trigger language, public-only), Q2 (word-count floor,
  public-only), Q17 (operational-detail markers), Q3 (prefix required), Q18 (trigger language).
- Target shape: classify on `description === "By name only"`; Q3 → warn on text beyond the marker;
  Q17 and Q18 retire as subsumed; Q1/Q2 skip name-only skills; `user-invocable` becomes inert.

## Corpus (measured, 124 SKILL.md)

- 52 carry `user-invocable: false` + a `Partial Skill:` prefix; 4 carry ADR-0013's older
  `Internal skill:` prefix; 16 are `examples/acme-ui*` fixtures; 0 carry a prefix without the flag.
- **0** skills are `user-invocable: false` *with* trigger language — the #380 shape does not occur in
  this repo, so its regression fixture must be constructed rather than found.
- Migration set: ~56 `SKILL.md` + 6 agent definitions → `description: "By name only"`.

## Ratified clearance

Recorded at `.agents/specs/aced/ledger/380-a7c3f1.jsonl` (`kind: clearance`, granted by unional).
Covers rewriting frozen scenarios asserting the old classifier or prefix in **three** suites:
`improve-skill.feature`, `define-skill.feature`, `define-governance.feature`.

**Scope note:** `define-governance.feature`'s scenario asserting a governance sets
`user-invocable: false` **survives unchanged** — visibility is still correct for a governance bar.
Additive scenarios covering the hidden-but-situational case self-clear.

## Landed so far

- `ac24e0be` — concepts/skills.md absorbs the axes + name-only rule; corpus survey in
  `.research/skill-kind-axes/conclusion.md`.
- `3c758995` — skill-design governance, ADR-0031, ADR-0013 superseded-in-part, ADR index (0030 was
  also missing), AGENTS.md, website governance + aced/define-governance, sidebar grouping.

## NEXT

Step 4: re-key `validate.mts` and its `validate.test.mts`. Then the 62-file migration, then the three
frozen suites, then spec gate → impl gate → PR referencing #380.
