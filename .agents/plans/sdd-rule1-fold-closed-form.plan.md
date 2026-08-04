---
cr-ref: sdd-rule1-fold-closed-form
status: draft
leash: auto-spec
blast: low
todos:
  - id: intake
    status: completed
    note: CR opened against sdd project spec; leash derived (auto-spec, ledger seq:1); plan scaffolded. Headless — stop at both gates for Council.
  - id: confirm-placement
    status: completed
    note: CONFIRMED — substance in authoring/suite-format (builder-spec delegates the CFG/coverage bar to it); scenarios on the owning behavioral node spec-producer.feature (miss-test precedent); no spec-gate.feature scenario owed. suite-format is a reference node (no .feature of its own).
  - id: author-spec
    status: completed
    note: codified Rule 1 narrow+qualified (3 qualifications + matrix corollary) into suite-format/README.md + spec-producer/README.md Phase-2 bullet (order-first) + 6 CFG-driven scenarios in spec-producer.feature (additive, self-clears).
  - id: spec-gate
    status: completed
    note: two cold sdd-spec-judge rounds — R1 architect blocker (bullet placement) remediated, R2 ALIGNED true all lenses. Self-asserted by:agent (ledger seq:2). STOP for Council.
  - id: deliver
    status: in_progress
    note: sync shipped skills — suite-format-governance (fold subsection in CFG area), spec-producer-governance (fold instruction BEFORE scenario authoring per architect finding), builder-spec-governance (pointer). pnpm verify.
  - id: impl-gate
    status: pending
    note: dispatch cold sdd-impl-judge SYNCHRONOUSLY; self-assert by:agent; STOP for Council.
  - id: handoff
    status: pending
    note: followup line(s) (unconditional — incl. the WAW-mutex 'roughly four' count nit); relay verdict packets up.
---

# Codify SDD Rule 1 — closed-form fold before by-example

Ratified doctrine keep from the keep-or-cut retro (parent plan
`doctrine-strategy-keep-or-cut.plan.md`, todo `codify-sdd-rule1-cr`). Dogfood CONFIRMED via the
corpus's own recorded A/B (#192 by-example fence diverged/reverted vs #224 rule-first converged).
Do NOT re-litigate or re-dogfood — codify narrow + qualified.

## NEXT — resume here

Spec gate is JUDGE-PASSED (by:agent, ledger seq:2) and STOPPED for Council. Remaining: deliver the
shipped-skill impl edits (fold instruction BEFORE scenario authoring), `pnpm verify`, run the cold
impl-judge synchronously, self-assert the impl gate by:agent (ledger seq), write followup lines, and
STOP. The Council owes both human ratifications (spec + impl) and the merge — never relayed, never
self-asserted.

## The codified rule (narrow + qualified)

Core: *A fold/aggregation node whose rule combines ≥2 interacting conditions must state the rule in
closed form — and re-derive its soundness against the real data model — before deriving scenarios;
single-condition folds may be specified by example. This buys iteration convergence, not coverage:
pair it with a mutation sweep and a safety dual.*

Three qualifications that MUST ride in the codified rule:
1. Fire only when the fold combines ≥2 interacting sub-conditions; single-condition folds are fine
   by-example (over-firing is the failure mode).
2. Closed-form ≠ sound — re-derive the proof's assumptions against the real data model before
   authoring (the R''→R''' cross-project unsoundness precedent).
3. Convergence ≠ coverage — pair with a mutation sweep and a safety dual (a liveness guard cannot
   see over-permission).

Matrix corollary (Rule 2 folded in, NOT a separate bar): a matrix/per-cell claim is Rule 1 applied
— draw every INDEPENDENT cell as a CFG branch (degenerate cells excluded), verify by mutation sweep.

## Leash derivation (recorded to ledger shard seq:1)

- floor: none — additive to an already-`implemented` root; self-clears; no narrowing, no
  compatibility break, no conflict.
- blast: low — strengthens one authoring bar (prose + the Builder actor governance); removes no
  behavior; root stays `implemented`.
- novelty: low — ratified keep, dogfood confirmed, precedent-following (scanner-distilled-detection).
- confidence: high — narrow+qualified spec already written by Council; clear intent.
- Headless: self-assert BOTH gates by:agent, STOP for Council ratification. Never write status,
  never a by:<name> human ratification.
