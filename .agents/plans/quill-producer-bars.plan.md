---
cr-ref: quill-producer-bars
project: quill
project-path: plugins/quill
status: in-progress
todos:
  - content: "Fix the SDD plugin-contract role-loads table — the upstream cause, and the only item that changes what other plugins inherit"
    status: completed
  - content: "Extend the three agent definitions' load lists, and add the output fields five frozen scenarios already require"
    status: completed
  - content: "Add the spend-every-row-by-ID rule to the spec bar's completeness element"
    status: completed
  - content: "Add the one-namespace-per-node identifier rule"
    status: completed
  - content: "Join the doc-type table to the north-star element"
    status: completed
  - content: "Add the intra-node reconciliation duty after an edit"
    status: completed
  - content: "Reconcile the stale readme against the two-instrument model"
    status: completed
  - content: "Correct the three artifacts that claim spec-judge: null means no judge agent — refuted by evidence"
    status: completed
  - content: "Give the calibration table a state for an entry that ran and never fired"
    status: completed
---

# CR quill-producer-bars — what dogfooding Quill revealed about Quill

**Re-briefed after the session that produced it.** The original brief was written from
`quill-docs-section`'s findings. Two subsequent missions — `website-target-doc-spec` and
`quill-writing-quality` — changed what several items *are*, not just how urgent they are. Read this
version; the differences are marked **CHANGED** and they are not cosmetic.

**Provenance.** Every item was found by a producer or a cold judge running Quill's own chain. Items
marked **measured** carry a recurrence count.

## The three things that changed

### 1. Item 1's root cause is upstream, in SDD — **CHANGED, and it splits**

The original brief filed "all three Quill agents replace the SDD producer's governance load list
instead of extending it" as a **Quill** defect, on the strength of the sibling plugin having the
correct shape. That was the wrong conclusion from the right evidence.

`sdd:plugin-contract-governance` **contradicts itself**:

- `SKILL.md:47–49` — *"a producer self-aligns to exactly the bars its judge grades. The lens sets are
  spec gate `{oracle, builder, architect}`…"*
- `SKILL.md:53` — `| spec-producer | spec-format, suite-format, ownership, the resolved oracle-spec +
  builder-spec bars |`

The decisive evidence is the row **two lines below**, which the original brief never examined:
`SKILL.md:56` gives impl-producer `ownership, the resolved builder-impl + architect-impl bars` —
correctly carrying its architect bar against its own `{builder, architect}` set. **The spec-producer
row is the lone outlier against its own stated lens set.** A dropped cell, not a deliberate
narrowing.

So the defect splits, and the two halves have different owners:

| Agent | Under-loads | Owner |
|---|---|---|
| `quill-spec-writer` | the oracle and architect **spec** bars | **`plugins/sdd/`** — it was built to the broken row |
| `quill-judge` | `gate-validation`, `builder-impl`, `architect-impl` | **Quill** — the table and preamble agree here, so nothing excuses it |
| `quill-doc-writer` | names the impl builder bar and ownership only | **Quill** |

**Fix the table first.** A plugin author reading that row today builds exactly the list Quill ships.
Fixing Quill without fixing the table means the next plugin repeats it, and this CR's whole
justification is that the omission degrades every spec the producer authors.

The measured cost stands unchanged and is still the strongest evidence in this brief: six of six cold
spec-judges blocked at governance pre-flight, and when the six nodes were re-authored with the
missing bars loaded, **six of six carried a real defect only those bars caught** — a double-barreled
north star in 6 of 6, a page documenting only the plugin half of a union bar, two uncovered
control-flow edges, a dead branch, a lone negative, and link scenarios asserting a sibling's prose
rather than its ownership.

### 2. Item 1 now has a frozen contract to implement against — **CHANGED**

The original brief called item 1 "a three-line change across `plugins/quill/agents/*.md`". It is no
longer a prose edit. `quill-writing-quality` authored and froze four behavioral node suites (94
scenarios) that **specify the correct behavior**:

- `sdd-roles/spec-writer/` (29) — the CFG **enters at the governance pre-flight**, with one row for
  the registry binding `builder-spec` only (the packet must name the SDD-default oracle and architect
  bars it fell back to) and one for all three slots bound. Two downstream rows make the omission cost
  something a declaration alone cannot: a scope finding only the oracle bar reaches, and a deferral
  only the architect bar reaches.
- `sdd-roles/judge/` (40) — asserts the declared set contains **every** SDD default the matcher
  resolves plus the Quill bar.
- `sdd-roles/doc-writer/` (14) — `E1` asserts the union by name.

**So this item is now an impl-gate task against a frozen contract, not an authoring task.**

**Corrected:** an earlier draft of this brief warned that the impl gate could not run until
`quill-judge` was fixed, because this CR modifies it. That is wrong. These nodes specify
**agent-configuration** artifacts, so the squad is **ACED** and the impl-judge is `aced-impl-judge`.
`quill-judge` grades documentation, never its own definition — there is no self-grading and no
sequencing constraint from it.

### 3. Five frozen scenarios require output fields that do not exist — **NEW**

The suites specify a declaration the shipped agents cannot produce.

**Corrected — this is not spec-ahead at all.** A cold judge ruled it legitimate spec-ahead under
`sdd:suite-format-governance`'s *"when an act matters but records nothing, add the record"*, and that
ruling was sound but understated the case. `sdd:spec-producer-governance` **already makes
`governances_loaded` a required structured-output field, "listed even when empty"** — its stated
reason being that the spec-judge otherwise cannot tell a skipped pre-flight from a correctly run one.
The contract always demanded the field. These agents simply never carried it, which makes this a
plain conformance gap rather than a contract running ahead of its subject.

It is work this CR owns:

| Agent | Owes |
|---|---|
| `quill-spec-writer` | a `GOVERNANCES_LOADED` output field, **and** a recusal `STATUS` value plus a recusal step — its enum is `complete \| needs-input \| blocked`, and its `## Steps` has no recusal step at all |
| `quill-doc-writer` | a `GOVERNANCES_APPLIED` output field |
| `quill-judge` | the equivalent |

The ACED siblings already carry the field. Without it, a skipped governance pre-flight is
indistinguishable from a correctly-run one — which is exactly the failure `quill-docs-section` hit,
where the conductor composed the relay from the agent definition because the producer had nothing to
declare.

## Items carried forward unchanged

### 4. The spec bar's completeness element does not require spending each row — **measured**

`quill-builder-spec` requires a completeness check but never says the argument must **account for
each row by ID**. Three instances across two nodes, and the **dominant regression class of the whole
mission** — each surfaced only after a *different* fix moved what the summary referenced.

**Fix:** the completeness argument must spend every coverage row by ID; a row it does not spend is a
row nothing depends on and should be cut. One producer independently invented this exact rule and
wrote it into its own spec.

### 5. No identifier-namespace rule — **measured, and now worse than filed**

Two nodes shipped ID collisions during `quill-docs-section`. The formation Warden then swept the
corpus and found **five exact collisions in two further nodes** — `motive-model/glossary/` has four
(CFG `A1 A2 T1 T2` identical to use-case ids `A1 A2 T1 T2` in the same file) and
`motive-model/overview/` has one. It also found **no corpus-wide convention exists**: 14 authored
nodes use ~14 schemes, and the entry-node id alone takes 7 forms.

**Fix:** a node's identifiers share one namespace. `spec-writer`'s `UC` prefix is the only
structurally collision-proof scheme in the corpus and is the natural candidate to standardize on.

### 6. The doc-type table is not joined to the north-star element

A reference page's north star is a **retrieval** claim and a tutorial's is a **capability** claim, and
they grade differently — so a spec can declare `reference` and write an explanation's north star with
nothing catching it. Producers made this join themselves on every node that declared `reference`.

### 7. No intra-node reconciliation duty after an edit — **measured**

Four of four remediated nodes regressed in one round, every finding *introduced* by the remediation.

**CHANGED — the rule needs a second half.** `website-target-doc-spec` ran the reconciliation sweep
and it worked: a cold judge checked every referencing passage and found **no staleness**. It still
introduced a defect in each of two consecutive rounds, both the same shape — **a `Then` that
mistranscribes the clause it freezes**. The producer verified *references* and never verified
*transcription*. What closed it was a full transcription audit: every `Then` quoted beside its source
clause and classified same / narrower / wider / different.

**Fix:** after changing a claim, reconcile every passage that references it — **and** for every `Then`
written or touched, quote the source clause it freezes and confirm it asserts that proposition. Where
a `Then`'s only home is a CFG node label, say so: one defect existed precisely because a label was a
claim's sole home and nothing cross-checked it.

**Caveat, unchanged:** a sweep is not self-certifying. It reduces rounds; it does not replace the cold
judge.

### 8. The plugin readme predates the current model — **verified still true**

`plugins/quill/readme.md:17` still leads the integrity row with *"No claim landed twice"* — the
recurrence rule the doc-eval model **retracts on measured grounds**. It classes all listed
inter-passage defects as inspection where the model's own correction makes three of them judged,
documents no judged tier, and mentions `governances` **nowhere** (grep: zero hits), so a reader cannot
learn the two bars are bound at all.

### 9. `spec-judge: null` — **CHANGED: settled by evidence, and Quill is the wrong side**

The original brief said "one of the two is wrong" and left it open. It is no longer open.

`plugins/quill/readme.md:36` claims `spec-judge: null` *"degenerates to static doc criteria run by
`spec-gate` itself, no judge agent"*, and `sdd-roles/doc-spec-bar/README.md:25` says the same.
**Across this session the SDD default cold judge was spawned unconditionally every time** — five
rounds on the Target node, two on quill's own nodes. The SDD plugin contract is right; Quill's prose
is wrong, in at least three artifacts.

**Fix:** correct all three to say an unfilled slot resolves to the SDD default judge.

### 10. Smaller, recorded

- The glossary hard-codes the catalog entry count (`glossary.md:20`, *"nine named prose defects"*),
  coupling the ubiquitous language to a number the catalog will move.
- The doc-eval model's instrument table undercounts the judged tier's scope.
- **The calibration table has no state for an entry that ran and never fired — now demonstrated, not
  predicted.** Calibration run 1 produced exactly this: four of nine entries fired on neither
  document, and three group-C cells were `uncitable` against an unspecified document. The table admits
  only `advisory` and `calibrated`, so both had to be recorded in the *Corpus run* column as prose.
- `init-quill`'s reject-a-missing-`governances`-block rule has no reachable trigger. **CHANGED:** the
  registry spec-producer declined to spec it for that reason and recorded why. The useful repair is
  to make it reachable — have step 3 validate the **found** entry, so a hand-edited or partially
  migrated registry gets repaired. Note the identical unreachable edge is **frozen into the ACED
  sibling suite** (`registry.feature:75`) in a project at `status: implemented`, so an impl gate
  passed against a scenario no implementation can lose. That is its own question.
- The spec bar flags no **coverage row no entry point reaches**, though it carries the symmetric rule
  for audiences and for coverage-vs-scenarios.

## Out of scope — routed elsewhere, do not absorb

- **`doc-spec-bar`'s grading face has no home** (formation Warden, escalated as a Conflict). Quill
  declares `spec-judge` unbound, so `spec-gate` enforces its criteria statically and **no node owns
  that behavior** — all 23 covered criteria are covered only as producer obligations. That is a
  *missing node*, not a bar edit, and it is a separate CR.
- **The defect catalog is largely unfrozen.** 5 of 18 sub-criteria covered; `contradict`, `orphan`,
  `presuppos`, `certif` appear in **zero** `.feature` files corpus-wide; three of nine entries have no
  scenario contact at all, including **B3 contradiction**, which the calibration table calls the best
  discrimination of the nine. Eight of nine near-misses are unfrozen. Separate CR — it is a suite to
  author, not a bar to edit.
- **A real calibration.** Run 1 moved no row and cannot: it needs five or six accepted documents
  **each with a spec node**, plus two or three weak ones with specs. Its own mission.

## Sequencing

**Item 1 first, and it is now two commits, not one.** Fix `sdd:plugin-contract-governance`'s table row
before touching any Quill agent — otherwise the fix reads as a Quill-specific workaround and the next
plugin inherits the same defect.

**Then item 2 with item 3 together.** The agent load lists and the output fields are one coherent
change: five frozen scenarios need both, and landing the load list without the declaration field
leaves the suites still failing.

**Then the bar edits (4–7),** whose effect is only observable once producers actually load the bars.

**Then the corrections (8–10),** which can ride together.

**There is no `quill-judge` sequencing constraint** — an earlier draft claimed one. The impl-judge for
these nodes is `aced-impl-judge`, because they specify agent-configuration artifacts. `quill-judge`
grades documentation and never its own definition.

## NEXT — all nine items landed; what remains is not this CR’s

**Branch:** `sdd/quill-producer-bars`, off `main` after PR #385 merged. No PR open yet.

| Item | Commit |
|---|---|
| 1 — SDD plugin-contract role-loads table | `59e08d9a` (+ `cyber-sdd` changeset) |
| 2 — the three agents’ load lists + declaration fields | `6faae222` |
| 3 — spend every coverage row by ID | `d863ba1b` |
| 4 — one identifier namespace per node | `e0f798c3` |
| 5 — north star joined to the declared doc type | `4649f520` |
| 6 — reconciliation duty + transcription audit | `e28048b9` |
| 7 — plugin readme vs the two-instrument model | `8c7fc31c` |
| 8 — `spec-judge: null` resolves to the SDD default judge | `b4f05dc2` |
| 9 — calibration states for ran-and-never-fired | `e83e926b` |

`pnpm verify` green at the repo root before each. Only item 1 carries a changeset;
`@cyberplace/quill-plugin` is private.

### Owed, and deliberately not absorbed

1. **The impl gate has never run for this CR.** The four `sdd-roles` node suites (83 scenarios)
   grade item 2’s work, and the judge is **`aced-impl-judge`** — these are agent-configuration
   artifacts, so the squad is ACED. `quill-judge` grades documentation and never its own
   definition; there is no self-grading and no sequencing constraint from it. This is the CR’s
   real terminus and the next thing to do.
2. **`apps/website/.agents/spec/content/docs/quill/production-chain/README.md`** carries a
   *"Recorded conflict — not resolved here"* section naming three artifacts and describing the
   `spec-judge: null` conflict as open. Item 8 closed it, in six artifacts rather than three. That
   node belongs to the **website** project spec, so editing it from here is cross-project
   absorption. Its frozen suite is unaffected — R3 was written to stay correct whichever way the
   conflict resolved, and it did.
3. **Twelve website nodes still use twelve identifier schemes**, and five collisions remain live
   (`motive-model/glossary/` ×4, `motive-model/overview/` ×1). Item 4 set the bar; renumbering the
   corpus to meet it is a migration across those nodes *and their frozen suites*, which is its own
   CR.
4. **Three item-10 bullets were never todos and are still open**: the glossary hard-codes the
   catalog entry count (`glossary.md:20`, "nine named prose defects"), coupling the ubiquitous
   language to a number the catalog will move; the doc-eval model’s instrument table undercounts
   the judged tier’s scope; and the spec bar flags no **coverage row no entry point reaches**,
   though it carries the symmetric rule for audiences and for coverage-vs-scenarios. Small, and
   they ride together.
5. **`init-quill`’s unreachable reject-a-missing-`governances`-block rule** — the repair is to make
   it reachable (step 3 validates the *found* entry, so a hand-edited registry gets repaired).
   Note the identical unreachable edge is frozen into the ACED sibling suite
   (`registry.feature:75`) in a project at `status: implemented`, so an impl gate passed against a
   scenario no implementation can lose. That is its own question.

The three things routed **out** at intake stay out: the missing home for the doc spec bar’s grading
face, the largely unfrozen defect catalog, and a real calibration.

### Method notes worth keeping

- **Check upstream before filing a defect as the plugin’s.** Item 1 was SDD’s; item 4 was not, and
  the check that settled it was reading SDD’s own nodes (they name use cases, carry no IDs, so no
  collision is reachable). Run the check, accept either answer.
- **Reproduce the brief’s counts.** The Warden’s five collisions reproduced exactly; "three
  artifacts" was six; "~14 schemes" measured as 12 across 12 nodes. Two of three were wrong in the
  direction of under-counting.
- **Check corpus debt before writing a rule.** Item 5 cost nothing (all eleven typed nodes already
  conformed); item 4 leaves a migration. Knowing which is which is what makes the follow-up list
  honest.
