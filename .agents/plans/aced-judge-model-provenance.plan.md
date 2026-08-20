---
name: aced-judge-model-provenance
cr: local-aced-judge-model-provenance
status: active
node: eval-run/run
touch-set: aced/eval-run/run, aced/eval-run/compare
blast: medium
todos:
  - content: "Intake: CR opened, plan scaffolded, leash recorded"
    status: completed
  - content: "Validate premise: confirmed, with two corrections — compare cannot reach a cross-model state; report is the real reader"
    status: completed
  - content: "Explore: additive scenarios in run.feature + compare.feature (record only; report band cut by owner scope call)"
    status: completed
  - content: "Spec gate — 3 rounds all ALIGNED false; owner cut the failing band; self-asserted within leash, both suites frozen"
    status: completed
  - content: "Deliver: run + compare SKILL.md, scoring_model in the results JSON shape"
    status: completed
  - content: "Impl gate — IMPLEMENTATION_PASS true, 9/9; its content gap fixed; root pnpm verify 29/29"
    status: completed
  - content: "Handoff — PR #497 opened; no changeset (private pkg); 2 followups in the ledger, unfiled"
    status: completed
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

## Spec gate — three rounds, held at the cap

| Round | Verdict | What it found |
|---|---|---|
| 1 | ALIGNED false | a non-discriminating `compare` scenario (retracted); the declared-vs-actual branch unbound — the one branch the field exists for; an over-promising use-case row; `unknown` with no antecedent; three map rows citing edges the CFG lacked |
| 2 | ALIGNED false | **two findings against the CFG round 1's own fix touched** — a phantom `classify` edge, a `carry` node whose branches reconverged — plus a self-contradiction on the no-declaration cell and an absence-defined `Given`. Root cause: the model was drawn as a fold without its rule ever stated in closed form |
| 3 | ALIGNED false | a mermaid node-id collision the round-2 redraw introduced (`named` used twice ⇒ a fabricated edge and a cycle); the comparability rule applied to non-pairs; `unknown == unknown` read as "same model"; `compare` prose promising a state its graph did not carry |

Round 2 was treated as a **regression** (findings against artifacts the prior round changed) and
answered with a re-plan rather than a third patch: the rule is now stated in closed form ahead of
each graph — `run` records the model it can name and `unknown` exactly when it cannot; `report`
calls a trend comparable iff both records name a **known** model and the same one.

All four round-3 findings were fixed but unjudged (the owner capped judging at 3 rounds). The owner
then **cut cross-model comparison from this phase entirely** — `report/` is reverted to the CR base,
and with it go the two findings that were never resolved (the comparability rule's domain gating and
the unknown-vs-unknown crosswalk, both of which existed only inside that band).

**What remains is recording only:** `run` writes the scoring model per record, `compare` writes it on
a persisted comparison. Nothing reads it — the same deliberate consumer cut this node already made
for the evaluated set. Nine scenarios across two suites; every mechanical check green.

## NEXT

**Both gates passed; landing is the only step left.** The spec gate was self-asserted within leash
after the owner cut the failing band; the impl gate returned `IMPLEMENTATION_PASS: true` over all 9
frozen scenarios, and its one content gap (the `unknown` bullet had restored the fold as a
conjunction) is fixed.

Landed as **PR #497** (`feat/aced-judge-model-provenance` → `main`). No source issue, so the PR body
carries no closing reference. Two follow-ups are recorded in the ledger shard and **not** filed as
issues; filing needs permission.
