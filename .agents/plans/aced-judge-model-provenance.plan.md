---
name: aced-judge-model-provenance
cr: local-aced-judge-model-provenance
status: active
node: eval-run/run
touch-set: aced/eval-run/run, aced/eval-run/compare, aced/eval-run/report
blast: medium
todos:
  - content: "Intake: CR opened, plan scaffolded, leash recorded"
    status: pending
  - content: "Validate premise: nothing records the scoring model today; eval.md hash does not cover it"
    status: pending
  - content: "Explore: additive scenarios in run.feature (record) + compare.feature/report.feature (flag)"
    status: pending
  - content: "Spec gate — cold aced-spec-validator, max 3 rounds; freeze; gate line"
    status: pending
  - content: "Deliver: run/compare/report SKILL.md + READMEs; results JSON shape"
    status: pending
  - content: "Impl gate — cold aced-impl-judge, max 3 rounds; pnpm verify green"
    status: pending
  - content: "Handoff — branch + PR, changeset, followups recorded"
    status: pending
---

# aced-judge-model-provenance — record which model scored an ACED run

## Request

`run` records **which model scored the run** (the case-judge's model) in the persisted results
record, beside the existing `evaluated` set. `compare` and `report` **flag** rather than silently
diff / roll up results scored under different models.

**Motivation.** ACED scores a **blind simulation of behavior**, not the subject's prose — the
case-judge dispatches a context that sees the subject plus a mechanically extracted situation brief
and never the `Then` or the rubric. So a capable model can pass a scenario the configuration does
not actually prescribe, and the pass gets credited to prose that is doing no work. Nothing in the
record says which model produced the transcript, so a result stays comparable-looking across a model
change, and `check-freshness` cannot see it: the evaluated set hashes `eval.md` (which declares
`eval.judge.model`) but nothing observes what actually ran.

**Future direction, explicitly not in this CR:** per-model compatibility ratings — which model works
best for which skill. It constrains only the record's shape: results must be **groupable by model**.

**Stated limit.** The model value is **self-report**, the same trust boundary the evaluated set
already carries (`run` is prose, not a script). A silent version bump under a stable alias stays
invisible either way.

## Constraints

- Owner cap: **3 judge rounds** at each gate.
- Additive only — no frozen scenario narrowed or rewritten.

## NEXT

Validate the premise against the current run/compare/report specs and skills, then draft the
additive scenarios.
