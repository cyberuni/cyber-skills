---
cr-ref: doctrine-strategy-keep-or-cut
status: draft
leash: auto-none
blast: medium
todos:
  - id: run-doctrine-loop
    status: completed
    note: Scanner distilled 28 unratified strategy lines (shard f5152c) across 4 ledgers
  - id: keep-or-cut-council
    status: completed
    note: Council reviewed; narrowed to Rule 1 (keep, qualified) + entry 5 (keep). Rest cut/untouched.
  - id: dogfood-rule1-closed-form-fold
    status: completed
    note: CONFIRMED via corpus's own recorded A/B (#192 by-example vs #224 rule-first). Codify narrow+qualified.
  - id: dogfood-rule2-per-cell-matrix
    status: completed
    note: CUT as separate rule — collapses into Rule 1 (matrix = draw every independent cell as a CFG branch). github-278 confirms.
  - id: codify-sdd-rule1-cr
    status: completed
    note: Shipped as CR sdd-rule1-fold-closed-form (PR opened, awaiting merge). Both gates Council-ratified. NOTE — a spec-gate round-2 judge verdict was recorded by the automaton from a COORDINATOR RELAY (the judge's reply failed to route by name); a security monitor flagged it; remediated by a FRESH first-hand cold spec-judge re-verification before ratification (ledger seq:6). Lesson: judge verdicts are non-relayable into durable records, same as human ratification.
  - id: codify-aced-entry5-cr
    status: pending
    note: open aced CR — producer pre-flight (verify harness claims vs primary docs; grep before coining a term). NOT yet started.
  - id: cut-a-cluster-seq42-pre-judge
    status: completed
    note: Council CUT the seq42 pre-judge use-case-coverage extension (A-cluster) as already-implemented — both checks shipped in check-spec-state.mts; recurrences do NOT land in an extendable prose/EARS form. See Resolved decisions.
  - id: rule-7f906e-three-findings
    status: completed
    note: 2026-08 doctrine pass (shard 7f906e) drafted 3 open findings + 2 resolved tombstones. Council KEEP all three; CRs shipped and merged — PR #390 (metaphor-free mechanical check, #387), PR #392 (Warden split-axis check #388 + Clearance back-fit proof #389). #388's presence-split itself stays killed; only its lesson was kept. See Resolved decisions → 7f906e run.
  - id: full-backlog-retro
    status: completed
    note: 69 entries triaged + Council-ruled (accept full triage; CR-4 KEEP narrow). 37 CUT / 9 RESOLVED / 11 DUPLICATE / 7 new KEEP (queued as CR-1..CR-7) + 2 pre-ratified f5152c KEEPs. See Resolved decisions → Full-backlog retro.
  - id: queued-ratification-backlog
    status: pending
    note: 7 new KEEP CRs (CR-1..CR-7) recorded; build AFTER Rule 1 (sdd) + Entry 5 (aced). Suggested order CR-2 → CR-1 → rest. Council held these this session.
---

# Doctrine-loop strategy keep-or-cut + rule dogfood

Strategist outer-loop (doctrine-loop) run to completion, then Council keep-or-cut, then a
one-rule-at-a-time dogfood of the two survivors before any governance edit.

## NEXT — resume here

**Current status (2026-08):** the 7f906e run's three findings are ruled KEEP and shipped (PR #390,
#392 — merged). The full ~69-entry backlog was triaged and Council-ruled (accept triage, CR-4 KEEP
narrow — see "Full-backlog retro"). **Rule 1 (sdd) is shipped** (CR sdd-rule1-fold-closed-form, PR
open, ratified with a provenance correction). **Entry 5 (aced) and the 7 new KEEP CRs are PAUSED** by
Council decision, pending a harness rethink: the hand-dispatched headless-automaton pattern hit three
failure modes this session — (1) the gate-bounce (every human gate bounces back to the in-session
channel-holder, since a relayed ratification is never valid), (2) a name-routing wait-loop (a nested
judge's reply to its parent automaton fails to route by name, stalling the mission), and (3) the
relay-taint (relaying a judge verdict for the automaton to record corrupts durable provenance — a
security monitor flagged it). Resume Entry 5 + CR-1..CR-7 only under a tighter harness (in-session
gating, or a workflow where judges are self-observed and no verdict is ever relayed).

**Next action (superseded — see status above):** the two f5152c KEEPs below; Rule 1 is now done.

**Next action:** open the **sdd** governance CR for Rule 1 (below) via `start-mission` against the
sdd project spec — target `authoring/suite-format` (+ `builder-spec-governance`); author the suite
CFG-driven. Then the **aced** CR for entry 5 via `start-mission` against the aced project spec —
target the aced spec-producer / builder-spec bar. Run them one at a time, sdd first.

**Blocking decisions:** none open. Council already ratified the narrowed keep-set below; the two CRs
are the ratified re-entry. Each CR is a governance edit → its own spec-gate + impl-gate.

**Findings the commits won't show (do not relitigate):**
- The two CRs are the **whole** actionable remainder of 28 distilled strategy lines — the dogfood
  cut the other redundancy. Do not re-open Rule 2, Item 3, or the ~23 untouched entries as CRs.
- Rule 1 must be codified **narrow + qualified**, not as the raw shard text (see Resolved decisions).
  Codifying the raw "state a fold rule closed-form" blanket would over-fire on simple folds.
- The strategy shards stay `ratified: false` forever (ledger is append-only, never edited). "Ratify"
  = the CR exists, not a field flip. That is why 0 of 34 lines are `ratified: true`.

**Working method / resolved decisions:** see `## Resolved decisions` below — do not relearn.

## Resolved decisions

### Doctrine-loop output (shard f5152c, all `ratified: false`)
28 strategy lines: `.agents/specs/sdd/ledger/strategy.f5152c.jsonl` (23),
`.agents/specs/aced/ledger/strategy.f5152c.jsonl` (2),
`.agents/specs/cyberplace/ledger/strategy.f5152c.jsonl` (2),
`.agents/specs/cyberfleet-plugin/ledger/strategy.f5152c.jsonl` (1). Zero Kill missions in the corpus.
~75 terminal missions were undistilled but have no combat log on disk (retired pre-`distills`); not
backfilled (prospective gate). Already captured by existing unratified entry `strategy.ba6a39` seq2.

### Council keep-or-cut (narrowed)
| Item | Verdict |
|---|---|
| Rule 1 — closed-form fold before by-example (from sdd `github-192` seq8) | **KEEP**, codify qualified |
| Rule 2 — per-cell miss-scenario for matrix claims (sdd `github-278` seq16) | **CUT as separate** — folds into Rule 1 |
| Item 3 — grep-count sweep check (sdd `github-237` seq13) | **CUT** — its trigger (7-kind ownership matrix) already fixed; too vague |
| Entry 5 — aced producer pre-flight (aced `133` seq1) | **KEEP** — cheap pre-flight, no divergence risk, no A/B needed |
| **A-cluster — seq42 pre-judge use-case-coverage extension** (`317dd8`/`ba6a39`/`9bb674`/`acaa41`/`f5152c`/`2d9bbc`/`364c83`) | **CUT** — already implemented (seq42 shipped both checks); recurrences not in an extendable form. See below |
| ~22 other entries | untouched, remain unratified |

Also cut as already-landed: cap-hit-to-owner half of Rule 1 (`start-mission` L44/L51), the specific
`user-invocable:false` fact of entry 5 (present at 3 sites in aced `define-skill`/`define-governance`/
`improve-skill`).

### Rule 1 — dogfood verdict: CONFIRMED (codify narrow + qualified)
The corpus already ran the A/B as two landed missions:
- Arm A by-example = `#192` fence: contradictions 1→1→**3**, each from the prior round's fix, cap-hit,
  reverted (`.agents/plans/192-barriers-and-blast.log.jsonl`; issue #224 body has the trajectory table).
- Arm B rule-first = `#224` (folded into master `#263`): contradictions **0**, findings were 7
  coverage gaps from the original draft; froze a clean multi-scenario `mission-graph.feature`.

Three qualifications that MUST ride in the codified rule:
1. **Fire only when the fold combines ≥2 interacting sub-conditions.** Single-condition folds are
   fine by-example — WAW-mutex (`.agents/specs/sdd/mission-graph/mission-graph.feature:93-115`,
   touch-set intersection) converged in ~4 clean by-example scenarios. Blanket = over-fire.
2. **Closed-form ≠ sound.** R'' shipped with a termination proof and was still unsound cross-project
   (project-scoped exemption vs graph-global RAW closure → silent acyclic deadlock; fixed to R''').
   Re-derive the proof's assumptions against the real data model before authoring.
3. **Convergence ≠ coverage.** Rule-first kills contradiction divergence but not coverage gaps;
   reading judges catch ~1/round (one round returned ALIGNED with 5 gaps live), a mutation sweep
   found 5 in one pass, and a liveness guard cannot see over-permission (needs a safety dual).

**Codified form:** *A fold/aggregation node whose rule combines ≥2 interacting conditions must state
the rule in closed form — and re-derive its soundness against the real data model — before deriving
scenarios; single-condition folds may be specified by example. This buys iteration convergence, not
coverage: pair it with a mutation sweep and a safety dual.*

### Rule 2 — dogfood verdict: CUT as separate, fold into Rule 1
`github-278` (`.agents/plans/github-278-hash-step-arguments.log.jsonl`) dragged 4 judge rounds, each
closing the same cell-shape one row over. It converged into per-cell CFG branches
(`.agents/specs/sdd/authoring/spec-gate/spec-gate.feature:349-377` — one scenario per independent
form×operation cell), and round 4's degenerate "every form has an indentation exclusion" universal
claim was dropped. A standalone per-cell builder lens would over-fire on degenerate cells (round 4)
and duplicate the existing `one scenario per (path class, edge)` rule. So the matrix case is Rule 1
applied: draw every INDEPENDENT cell as a CFG branch (degenerate cells excluded), verify by mutation
sweep. Codify as a worked corollary under Rule 1, not a new bar.

### A-cluster (seq42 pre-judge use-case-coverage extension) — CUT verdict
The recurring "prose/spec asserts behavior with no backing scenario, caught only at the cold
spec-judge" pattern is filed across seven shards as *reinforcement of legacy ledger seq42*, each
recommending the Council ratify seq42's pre-judge mechanical extension. **Cut as already-implemented.**

- **seq42 already shipped — both halves.** Legacy ledger seq42 proposed exactly (a)
  referenced-artifact-exists and (b) use-case *rows* with no mapped scenario. Both are live in
  `plugins/sdd/skills/spec-gate/scripts/check-spec-state.mts` — `checkReferencedArtifacts` and
  `checkUseCaseCoverage`. The "reinforcement" lineage is reinforcing a proposal that already landed.
- **The pre-filter fires on one form only:** a `## Use Cases` **table with a `Scenario` column**,
  checking each **row → sibling `.feature` scenario**. Prose/EARS, or a table without a Scenario
  column, raise nothing (`SKILL.md:78-84`) — deliberately the cold judge's backstop.
- **Tally — 0 of ~21 cited coverage-gap / spec-feature-contradiction recurrences land in the covered
  tabular form; only ~3 land in the prose/EARS form an extension could target.** The rest split into
  forms a use-case pre-filter (current or extended) structurally cannot key off:

  | Form | Count | Owner |
  |---|---|---|
  | Covered (tabular `Scenario`-column row → missing scenario) | 0 | already caught if it occurred |
  | Extendable prose Use-Cases claim → no backing scenario (github-34 seq6/seq7, github-193) | ~3 | no mechanical anchor — prose has no `Scenario:` token to resolve |
  | prose-impl-contradiction (design/loops.md, github-237 matrix, plan-retirement-distill-gate) | ~3 | **separate** proposal: `prose-impl-contradiction` enum + sibling sweep (`strategy.acaa41` seq1, `strategy.364c83` seq2) |
  | `.feature`-internal form (orphaned assertion, Then restates rationale, DocString rubric gut) | ~4 | `check-suite.mts` / structural step-diff (`strategy.dae416` seq1) |
  | Generic missing scenario/test at builder/impl gate (no use-case anchor) | ~11 | irreducible cold-judge residue |

- **Why not EXTEND:** the ~3 extendable prose cases have no reliable mechanical anchor — you cannot
  mechanically decide which prose sentence is a behavioral claim owed a scenario without NLP. The one
  cheap move that exists (bidirectional coverage on the *table* form — every `Scenario:` needs a row)
  still catches none of the cited instances, whose targets were written in prose, not the table.
- **The real recurring mass belongs to two other, already-filed proposals** — the
  `prose-impl-contradiction` enum/sweep and the structural step-identity diff — which the seq42
  lineage was absorbing as "reinforcement," inflating its recurrence count with defects it never
  claimed to catch. Those two remain in the untouched-unratified set for their own keep-or-cut.

### 7f906e run (2026-08 doctrine pass) — 3 findings, all KEEP + shipped
The later doctrine pass (shard `strategy.7f906e.jsonl` in the cyberlegion + website ledgers) drafted
three `open` findings and two `resolved` tombstones. Council ruled and the keeps are already merged:

| Finding (shard/seq) | Verdict | Landing |
|---|---|---|
| `github-172-doorbell-focus-gate` (cyberlegion seq3, #387) — 3rd metaphor-leak into the metaphor-free package, caught only by manual judge grep | **KEEP** | mechanical `check:metaphor-free` guard — PR #390 (merged) |
| `cyberlegion-identity-presence-split` (cyberlegion seq4, #388) — a wrong-axis split CR superseded before landing | **split stays KILLED; lesson KEEP** | Warden split-axis-vs-capability-boundary check — PR #392 (merged) |
| `website-target-doc-spec` (website seq1, #389) — the pre-repair-draft-failure proof that a Clearance repair isn't a back-fit | **KEEP** | `remediation-governance` 5th rule — PR #392 (merged) |
| `github-158-focus-cross-workspace` (cyberlegion seq1) | resolved (tombstone) | already shipped #162/PR #168 |
| `at-default-tab` (cyberlegion seq2) | resolved (tombstone) | closed by cli-realign per-backend frozen scenarios |

Same mechanism as the f5152c run: `ratified: false` stays forever; KEEP = the CR exists. These three
CRs exist and merged, so the ruling is discharged.

### Full-backlog retro (2026-08) — ruled
Council-directed keep-or-cut over the full corpus (21 tracked shards, 69 unratified entries = 33
previously ruled + 36 fresh). Triaged by a Fable pass, each RESOLVED backed by a cited current-code
check. **Council accepted the full triage.** Same mechanism: `ratified: false` stays forever; KEEP =
a CR exists.

- **Non-keeps ruled (accepted, do NOT re-open):** 37 CUT (n=1 / redundant / trigger already fixed /
  positive-precedent notes), 9 RESOLVED (gap already closed in current code — the corpus self-healed;
  e.g. `prose-impl-contradiction` cause enum, step-identity structural diff, internal-description
  lint, sdd-new path prune), 11 DUPLICATE collapsing into the 5 clusters below.
- **5 reinforcement clusters:** A-cluster (settled CUT); durable-footprint (→ CR-4); cold-instrument
  (→ CR-1); enum-conformance (→ CR-2); plan-drift (→ CR-3).

**New KEEP queue (7 CRs) — ratification backlog, build after the 2 pre-ratified f5152c KEEPs:**

| CR | Head entry | Target | Lesson |
|---|---|---|---|
| CR-1 cold-instrument | sdd `2d9bbc` seq1 | `impl-producer-governance` + `builder-impl-governance` (echo aced) | when the subject IS a measurement instrument, mutation-sweep first; adopt/drop a rule only on non-author evidence; revived rule stated abstractly + ablation-tested |
| CR-2 cause-enum conformance | sdd `0bfda2` seq2 | `combat-log-governance` + conductor | write-time enum validate/nudge + a sanctioned novel-shape path (nearest bucket + followup proposing enum growth) — off-enum causes silently break the loop's own recurrence detector |
| CR-3 plan-finalize backstop | aced `193814` seq3 | conductor/handoff | reconcile plan todos + `## NEXT` to landed state at finalize; Council to decide terminal `status` vs today's dispatch-flag-only semantics |
| CR-4 durable footprint | sdd `317dd8` seq2 | `plan-retirement` / ledger | **KEEP narrow** (Council ruling): one ledger line (outcome class + whether a gate cycle ran) per concluded non-gated mission |
| CR-5 retired-term drift registry | aced `193814` seq2 | new mechanical check | register a retired path/term → verify-time corpus-wide grep flags survivors |
| CR-6 shared-primitive sibling followup | cyberlegion `dae416` seq1 | `start-mission` handoff | a CR touching a shared primitive files a `followup` naming siblings it may obsolete (routes via the existing followup channel) |
| CR-7 ACED untradeable-boolean | sdd `2d9bbc` seq2 (residual) | `aced-builder-spec` + `aced-scenario-writer` | a whole-output untradeable behavior is one boolean `@quality` scenario, never a rubric dimension |

**Execution (Council ruling): Rule 1 + Entry 5 first, hold the 7.** Open the two pre-ratified f5152c
CRs one at a time (sdd Rule 1, then aced Entry 5). The 7 above are a recorded ratification backlog;
suggested build order when resumed: CR-2 (loop is self-blinding) → CR-1 (highest-recurrence) → rest.

## Verification method (for the CRs)
A completeness/consistency bar is itself the class of thing that diverges producer-judge loops, so it
is dogfooded before codifying: (1) over-fire against its own approved corpus — fire only on true
holes; (2) producer-judge convergence — findings per round trend to 0. Rule 1 passed both via the
recorded corpus A/B; scenarios stay CFG-driven (re-derive the set from the drawn CFG per edge).
