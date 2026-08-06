---
cr-ref: cold-instrument-doctrine
status: in_progress
target: .agents/specs/sdd (project spec) — additive to implemented root
todos:
  - content: "Intake: leash, locate node, classify revise"
    status: completed
  - content: "Explore r1+r2: authored on impl-producer; 2 spec-judge rounds NOT-ALIGNED; escalated placement fork"
    status: completed
  - content: "Council ruled Option A: relocate rules 2+3 to owning nodes, keep one CR, scope expansion authorized"
    status: completed
  - content: "Re-plan: rule1→impl-producer; rules2+3→doctrine/scanner (canonical) + spec-producer authoring face; revert round-1 regression"
    status: completed
  - content: "Spec gate: cold spec-judge rounds 3-5, round 5 ALIGNED; approval.spec by:agent in ledger shard"
    status: completed
  - content: "Deliver: doctrine into 7 impl artifacts (impl-producer/builder-impl, doctrine-loop/sdd-scanner, spec-producer/builder-spec govs + aced echo); pnpm verify 35/35"
    status: completed
  - content: "Impl gate: cold impl-judge IMPLEMENTATION_PASS on all 13 new scenarios; approval.impl by:agent"
    status: completed
  - content: "Handoff: followup recorded; committed deliver; STOPPED for channel-holder ratify+merge (no by:name, no status, no PR)"
    status: in_progress
---

# CR: cold-instrument doctrine (ratified KEEP, CR-1)

Codify the op6 (master #263) strongest meta-lesson as durable SDD governance. Three rules, all
impl-producer / builder-impl verification doctrine. Source: `.agents/specs/sdd/ledger/strategy.2d9bbc.jsonl`
seq1 (op6-m3), seq3 (op6-m5), seq4 item 2 (github-224), seq6 (milestone retro). Council ruled KEEP.

## The three rules (closed form in spec.md)
1. **Mutation-sweep-first for instrument subjects.** subject is a measurement/verification instrument
   (fixture | mutation set | ablation generator | falsifier | judge | check) ⟹ mutation sweep is the
   DEFAULT verification method, reading supplementary. Non-instrument subject ⟹ verify-as-high unchanged.
2. **Non-author evidence for rule-level decisions.** measurement M grounds a rule-level decision
   (adopt | drop | threshold-set) ⟹ M produced-by-non-proposer ∨ reviewed-by-non-proposer ∨
   ablated-against-fresh-adversarial-case. Proposer's own generator/harness alone ⟹ inadmissible.
3. **Revived/new rules stated abstractly + ablation-tested.** new/revived doctrine rule ⟹ stated
   abstractly with NO worked example (reusing a probe's apparatus = absorption; the probe then grades
   nothing) ∧ ablation-tested before landing (Δ=0 ⟹ dead weight, not landed).

## SCOPE EXCLUSION
Do NOT bundle the case-judge liveness concern (seq1 item 3 — impl-judge invoking aced-case-judge is
circular). Distinct backlog liveness item.

## Placement (provisional → finalized at handoff)
- Gradeable scenarios: `mission/impl-producer/impl-producer.feature` new stage (additive, self-clears).
- Prose: `mission/impl-producer/README.md`; `plugins/sdd/skills/impl-producer-governance/SKILL.md`;
  `plugins/sdd/skills/builder-impl-governance/SKILL.md`; echo `plugins/aced/skills/aced-builder-impl/SKILL.md`.
- ACED recuses on SDD self-spec (boolean) → chain re-resolves to SDD defaults; scenarios boolean, judged
  by static inspection.

## Constraints
- Rebase onto main first (done at intake). Run `pnpm verify` before impl gate.
- Honor Rule 1 (authoring/suite-format): closed-form any ≥2-condition rule before scenarios; CFG-driven.
- Additive to implemented root → self-clears; gate verdicts by:agent in ledger shard; STOP each gate.

## NEXT
COMPLETE through the impl gate and STOPPED for the channel-holder (headless: no by:name ratification,
no root `status` advance, no PR, no merge — those are the channel-holder's). Both gates self-asserted
`by: agent` in the ledger shard; the CR is committed on branch `worktree-agent-a652f00297e6ea455`.

Channel-holder to do: review the deliver commit, ratify (write the `by:<name>` gate verdicts if desired
— note root `status` stays `implemented`, this is additive/self-clearing), and merge. The additive
scenarios self-cleared, so no root status transition is owed.

Final placement (Council Option A, one CR):
- Rule 1 (mutation-sweep-first for an instrument subject) → `mission/impl-producer` (+ builder-impl bar,
  builder ref-node cross-ref, ACED echo).
- Rule 2 (non-author evidence for a rule-level decision, kept GENERAL) → `doctrine/scanner` (canonical
  3-disjunct standard) + `authoring/spec-producer` (authoring-face binary gate that references it).
- Rule 3 (revived rule abstract + ablation-tested before landing) → `doctrine/scanner`.

Records: leash + both `gate` (by:agent) lines + the backlog `followup` in
`.agents/specs/sdd/ledger/cold-instrument-doctrine.7b2e4f.jsonl`; corrections + the earlier halt in
`.agents/plans/cold-instrument-doctrine.log.jsonl`. Out-of-scope backlog follow-up: the case-judge
protocol liveness concern (also in strategy.2d9bbc seq1) — NOT filed (no forge grant headless); the
durable records stand and a later drain re-derives it.
