---
name: cr3-plan-finalize-backstop
cr: local-cr3-plan-finalize-backstop
status: active
node: mission/conductor
touch-set: sdd/mission/conductor
blast: medium
leash: auto-none
todos:
  - id: intake
    content: "Intake: CR opened from doctrine backlog CR-3, plan scaffolded, leash recorded"
    status: completed
  - id: validate-premise
    content: "Validate CR-3's premise against current code + the scanner-stale-plan-status precedent"
    status: completed
  - id: place-node
    content: "Placement: conductor, not handoff — sibling of the correction-line finalize backstop"
    status: completed
  - id: draft-spec
    content: "Explore: additive reconcile-at-finalize band in conductor README + conductor.feature"
    status: completed
  - id: surface-council-question
    content: "Surface the terminal-status-vs-dispatch-flag decision as an open marker in the spec"
    status: completed
  - id: spec-gate
    content: "Spec gate — cold spec-judge; emit verdict packet; STOP (gated CR, no self-ratification)"
    status: in_progress
---

# cr3-plan-finalize-backstop — handoff reconciles the plan brief to landed state

## Request

Doctrine ratification backlog **CR-3** (source: aced `strategy.193814` seq3). At mission
finalize, the conductor reconciles the plan brief's `todos` and its `## NEXT` section to the
landed state, instead of leaving them to be caught incidentally at a later retro. Target node:
`mission/handoff` (the conductor enacts it).

**Council carries one unresolved question** (do not resolve unilaterally): whether a **terminal
`status` value** joins today's dispatch-flag-only semantics. Present both options with a
recommendation; the Council rules.

## Findings — premise validated, and sharper than the ledger entry claimed

1. **The recurrence is real and larger than 3.** Ledger seq3 cited 3 briefs. A corpus sweep of
   all 42 briefs under `.agents/plans/` finds the same drift at both halves of the field:
   - **todos left `pending` on a landed mission** — `388-389-verification-doctrine` (0/8 done,
     merged as PR #392), `aced-producer-preflight` (0/6, shipped), `192-barriers-and-blast`
     (0/5, long merged), `222-ambiguous-oracle` (0/7), `238-blast-one-area-contract` (0/6).
   - **plan-level `status` written off-enum** — the declared enum is `active | approved`
     (`design/provenance-model.md`), yet the corpus carries `implemented` ×6, `draft` ×6,
     `in-progress` ×6, `done` ×2, `completed`, `awaiting-clearance`, `deprecated`. **`approved`
     appears zero times** — the one non-default value the dispatch loop actually selects on.

2. **The todos half is not cosmetic — it jams shipped machinery.** The prior CR
   `scanner-stale-plan-status` froze a Scanner backstop that derives the retirement clearance
   set from `todos-all-done ∧ source-closed`, and **refuses to autofix on disagreement**. A
   landed mission whose handoff left todos `pending` presents exactly that disagreement, so the
   Scanner flags a finding and the brief **never becomes retirement-clearable**. Handoff's
   omission is what starves the downstream sweep, not merely untidy bookkeeping.

3. **The `status` half has a directly-on-point owner precedent.** `scanner-stale-plan-status`
   put the identical question to the owner and the owner **picked Option C** — drop the `status`
   write entirely, derive terminal-ness instead — after finding that (a) no consumer reads the
   field for lifecycle, (b) neither distill nor retirement gates on it, and (c) `implemented` /
   `done` are off-enum against `provenance-model.md`'s explicit *"three distinct `status` fields,
   three scopes — do not conflate"* rule. That precedent was ruled for the **Scanner**
   realization; CR-3 poses it again for the **conductor/handoff** realization, so it is
   persuasive, not binding — hence the Council gate.

## Placement — conductor, not handoff

The CR row named "conductor / handoff" ambiguously. Resolved to **`mission/conductor`**: the
correction-line finalize backstop this CR is explicitly the sibling of already lives there
(`conductor.feature`, README "Correction-line durability"); the plan brief is the conductor's own
execution-state artifact (it fills `todos` during explore, per `design/provenance-model.md`); and
`mission/handoff`'s declared Non-goals already exclude writing frontmatter and retiring the plan.

## The open Council question

See `### Open decision — a terminal plan-level status` in
`.agents/specs/sdd/mission/conductor/README.md`, carrying the `<!-- open: -->` marker. Options
A (widen the enum; the conductor writes a terminal value) vs B (dispatch-flag-only unchanged;
reconcile `todos` + `## NEXT` only, terminal-ness stays derived). Recommendation: **B**.

The marker is deliberate and load-bearing: an open marker blocks advance to `approved`
(`lifecycle-governance`), which is what makes this gate un-self-assertable and forces the ruling.

## NEXT — resume here

**At the spec gate, awaiting Council ratification.** The 8-scenario additive band and the README
section are drafted and cold-judged; `pnpm verify` green; suite diff is 8 added / 0 modified /
0 removed, so freeze self-clears and no Clearance is owed. **Do not self-ratify.** The Council
rules the terminal-`status` question; a follow-on round then adds the one scenario the ruling
determines and re-runs the gate.
