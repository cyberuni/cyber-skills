---
cr-ref: quill-writing-quality
project-spec: plugins/quill
status: draft
todos:
  - content: Retract the recurrence criterion at all eleven live sites across nine files (see the corrected inventory in ## Done means)
    status: completed
  - content: Re-partition the two tiers by what is actually decidable mechanically — most integrity criteria are judgment, not inspection
    status: completed
  - content: "Add declaration-agreement — folded into the catalog as entry C1 (declaration mismatch), not a separate criterion"
    status: completed
  - content: Spec the judged tier — a second evaluation instrument beside static inspection
    status: in_progress
  - content: Author the defect catalog — named, citable bad-writing shapes, each with a near-miss that must NOT fire
    status: completed
  - content: Calibrate against the corpus before the tier gates — known-good and known-weak documents
    status: pending
  - content: Spec gate — cold spec-judge, freeze, ledger gate line
    status: pending
  - content: Handoff — Warden placement pass, commit, follow-up drain
    status: pending
---

# CR: give quill an instrument for prose quality

Quill can check that a document **says the required things**. It cannot check that the document is
**well written**, and its one attempt at the latter — the document-integrity bar added earlier this
session — was aimed at the wrong target.

Source: conversation, no forge issue. Backed by [`.research/documentation-craft/`](../../.research/documentation-craft/conclusion.md).

## Why now — the bar's first live run was half wrong

The cold `quill-judge` round over the Target article returned 20/20 scenarios PASS and one integrity
`BLOCKER`: the coexistence rule landed at the lead and again in the installer decision table. The
finding was **partly a false positive**. Those two passages sit on different branches of the
article's own CFG — a reader arriving at *Composing configuration* from the sidebar has not read the
lead — so the table was that reader's only statement of the rule. The prescribed fix (anaphora) then
made the article *worse* for exactly that reader, by replacing content with a pointer.

The criterion was `a claim appears in exactly one place`. The research says it has no empirical
warrant.

## What the research changed

Full dossier in `.research/documentation-craft/`; three findings drive this CR.

| Finding | Consequence for quill |
|---|---|
| **Repetition is not the active ingredient.** Haviland & Clark rewrote their contexts so the critical noun was repeated in *both* conditions while only one posited existence — the antecedent effect survived at **Δ137 ms, p<.001**, and a within-condition check found repetition bought nothing (19 ms the wrong way, n.s.). The measured cost attaches to a passage whose given information has **no retrievable antecedent** (E01, E03, E03b). | Replace the recurrence criterion with **unresolvable presupposition**. A claim may recur freely; a passage may not presuppose what the reader cannot retrieve. The symmetrical defect — a **bare cross-reference** that withholds content — is worse, since it guarantees the bridging cost rather than risking it. |
| **The right amount of redundancy is audience-relative and reverses.** Low-knowledge readers benefit from explicit, redundant text; high-knowledge readers can do better with gaps (E06). | There is no audience-independent setting. The spec already declares audience and prerequisites, so the checkable question is **agreement**, not quantity. |
| **No craft lint — but a craft judge is admissible.** Gopen & Swan disclaim rule status for their own principles, and their sources predate LLM judges by 30 years. Of their two reasons, "too many expectations at once" is a claim about a *decision procedure's capacity* and does not transfer to a reader-simulating judge; "any expectation can be violated to good effect" transfers intact (E05, E16–E17). | Add a **second instrument**. Craft is judged, not linted — and the surviving reason becomes a process requirement: a deliberate-violation defense. |

## The design

### Two instruments, split by how a verdict is reached

| | **Inspection** | **Judgment** (new) |
|---|---|---|
| Carries | existence, structure, completeness, reader-path; route-vs-enumeration | every prose-semantic criterion, including most of what the integrity bar now holds |
| Decides by | comparing two structured artifacts, or matching a pattern | simulating a reader |
| Verdict | boolean, mandatory citation | graded, citation + location |
| Anchor | the frozen `.feature` + the spec's own tables | the defect catalog |
| Fails on | a condition not met | a defect confirmed and not defended |

**The partition has to be redrawn, and this is the review's main finding.** The integrity criteria
were built as *inspection*, but none of them is mechanically decidable. Deciding that a passage
presupposes something, that no antecedent is retrievable, that a term has changed subject class, or
that two claims cannot both hold — each requires reading as a reader, not matching a pattern. They
were only ever "inspection" because evidence-with-citation made them *feel* mechanical.

So the honest split is by **what decides the verdict**, not by which file the criterion lives in.
Inspection keeps what compares two structured things: does the file exist, is the heading present,
does the CFG spend the coverage table's enumeration. Everything prose-semantic moves to judgment —
which means **the existing integrity bar is largely the seed of the defect catalog**, not a peer of
it. That is a larger change than "add a tier", and it should be stated plainly at the spec gate
rather than discovered during implementation.

The judged tier is **not** a second spec gate and **not** a style preference. It runs a catalog of
named defects, and the producer may mark any finding as a deliberate violation with a rationale the
judge must weigh — the concession Gopen & Swan's surviving argument requires.

### Detect bad writing; do not certify good writing

The asymmetry is the whole point. Good prose is unbounded and cannot be enumerated. Bad prose recurs
in a small number of shapes that can be named, quoted, and rebutted. The catalog is a list of
**defects**, never a standard a document must reach — a document with zero findings is not thereby
certified well written, and the bar must say so in those words so no one reads a green judge as an
endorsement.

### The catalog — first draft, to be settled in explore

Each entry needs a **citation rule** (what the judge must quote) and a **near-miss** (a case that
looks like the defect and must NOT fire). The near-miss is what stops a catalog entry from becoming
a style opinion with a rubric attached.

The location requirement added to the inspection bar carries over: a citation names *where* it came
from, not only what it said. It was added after a finding in this session's own research quoted a
real figure accurately and attached it to the wrong experiment — the words checked out, so the
finding read as verified. A judged tier is more exposed to this than an inspection is, since its
findings are arguments rather than conditions.

| Defect | Fires on | Near-miss that must not fire |
|---|---|---|
| **Unresolvable presupposition** | a passage presupposes X; no antecedent is retrievable on the reader's declared path | a presupposition licensed by a declared prerequisite |
| **Bare cross-reference** | a pointer stands where the reader needs the content now | a pointer to genuinely out-of-scope depth, with a forwarding address |
| **Re-presented as new** | already-established content carried with new-information marking, as if first stated | a legitimate **echo** — content restated but marked as given |
| **Declaration mismatch** | prose presupposes a sibling the spec declares *not* prerequisite | prose restating that sibling's claim in full |
| *(the spec's declared audience and prerequisites are this catalog's **input**, not a separate tier — an earlier draft listed declaration-agreement as an inspection criterion and as a catalog entry, which is one criterion in two places)* | | |
| **Claim without mechanism** *(explanation type only)* | a chain of assertions with no causal step, in a doc type whose job is the causal step | a definition, a table row, a summary recap |
| **Orphan claim** | a claim landed and never used, connected, or paid off | a claim that *is* the payoff — a north-star statement, or a coverage row the spec requires for its own sake |
| **Undefined term at first use** | a load-bearing term relied on before it is glossed or linked | a term the declared audience owns |

`Claim without mechanism` returns here deliberately. It was ruled out of the inspection bar earlier
this session on the grounds that *"no citation settles it"* — which was the right call for a lint and
the wrong one for a judge.

### The alternative the design must argue against

**Do nothing structural: put graded scenarios in the doc `.feature`.** ACED already grades inline
`@rubric` scenarios inside a suite, so a "judged tier" may be an unnecessary invention — the catalog
could be a set of scenarios the spec-producer includes per document. Reasons to reject it are real
but must be *stated*, not assumed: a catalog entry applies to every document (authoring it per suite
duplicates it 76 times), and a defect the spec did not anticipate is exactly what the judged tier
exists to catch — a per-suite scenario can only encode a defect someone already thought of. If those
two reasons do not survive scrutiny, the cheaper design wins and this CR shrinks to a criteria
correction.

### Cost, and the failure mode of getting it wrong

A judged tier adds a rebuttal loop to the impl gate. If the catalog is chatty, every document
acquires a round of defend-or-fix, and the predictable outcome is that the tier gets routed around —
disabled, or its findings waved through. A false positive here is more expensive than a miss: a miss
ships a weak paragraph; a false positive teaches the producer to ignore the judge. Calibration
below is what keeps that from happening, and open decision 3 (does a judged finding block?) should
be settled with this asymmetry in view.

### Calibration is a gating prerequisite, not a follow-up

The catalog does not gate until it has been run against documents the team already considers good
and already considers weak. A criterion that fires on an accepted document is miscalibrated. This is
the empirical test the "a judge can do it" inference currently lacks (dossier D2), and it is the
todo that must not be dropped when the CR is under time pressure.

Independence follows the repo's existing finding: a **separate agent**, since LLM self-verifiers are
unsound as their own critics while a separate verifier reverses the loss
(`.research/impl-judge-independence/`).

## Scope

**In** — `quill-builder-impl` criteria correction; declaration-agreement; the judged tier and its
defect catalog; the producer-side defense mechanism; calibration; whatever spec-bar changes the
above require.

**Out**

- **Cross-page and corpus-level concerns** — reading order, foreshadow marking, claim overlap between
  articles. The dossier is explicit that these are corpus properties and that no framework surveyed
  supplies them. They belong to the **formation loop** (the Warden), whose structural analogue
  `check-scenario-overlap` already exists. Separate CR.
- **Fixing the Target article.** It is the driving case, not the deliverable; its own CR is
  `website-target-doc-spec`, still parked at its spec gate.

## Resolved decisions — settled with the owner, do not relitigate

1. **The judged tier is the existing bar, graded.** `quill-builder-impl` stops being a boolean
   inspection bar and carries both instruments: one enumeration rule (inspection) plus the defect
   catalog (judgment). No new bar, no new file — both faces already load it. Split the catalog out
   only when one read can no longer hold it. *This collapses old decisions 2 and 4 into one.*

   The cheaper alternative — graded `@rubric` scenarios inside each doc `.feature` — is rejected on a
   ground stronger than the two the brief stated: a catalog entry carries **no per-document
   content**, so it is a *bar*, not a *contract*, and authoring it per suite would duplicate it 76
   times over. SDD already has the place for a per-document invariant, and this is it.

2. **Borrow ACED's blind two-pass asymmetry, not its threshold plumbing.** Pass 1 simulates a reader
   on one declared CFG path, blind to the catalog; pass 2 scores that transcript
   (`aced-case-judge`). This is the answer to the false-positive asymmetry in `## Cost`: a defect a
   blind reader stumbled on is evidence about a reader, not an opinion about prose. Cost is a blind
   dispatch per document per run — accepted.

3. **Advisory until calibrated, then blocking on confirmed-and-undefended.** Calibration (todo 6) is
   what *earns* an entry its blocking power, which is precisely what stops it being the todo dropped
   under time pressure. Two states to spec, and a document may ship with an open finding during the
   advisory window.

**Still open (todo 4's business, not a gate on todos 1–2):** whether `quill-judge` runs both
instruments or a second agent runs the judged one.

## Done means

1. The recurrence criterion appears nowhere — verified by search, not by memory.

   **The site inventory below corrects this brief: eleven mentions across nine files, not six.**
   `grep -rn "exactly one place"` finds only seven of them; the other four are phrased as
   *Restatement* and are invisible to that search. Search both terms.

   | File | Sites | State |
   |---|---|---|
   | `apps/website/.agents/spec/.../instruction-target.feature` | :126 | ✅ `ee2666fa` |
   | `.agents/specs/quill/design/doc-eval-model.md` | :29 + the all-inspection framing | ✅ |
   | `.agents/specs/quill/sdd-roles/doc-impl-bar/README.md` | :15, :23, :40 | ✅ |
   | `plugins/quill/skills/quill-builder-impl/SKILL.md` | criterion + key point 1 | ✅ |
   | `plugins/quill/skills/quill-builder-impl/README.md` | :9, :18 | ✅ |
   | `plugins/quill/skills/quill-builder-spec/SKILL.md` | the quantifier rule + its gherkin example + key point 7 | ✅ |
   | `plugins/quill/agents/quill-judge.md` | :57 + the precedence example | ✅ |
   | `plugins/quill/agents/quill-doc-writer.md` | :30 | ✅ |
2. Every criterion sits in the tier that matches how its verdict is reached, and the bar says which.
3. The catalog separates documents this repo already accepts from documents it already considers
   weak, with the false-positive rate reported — not asserted.
4. A judged finding a producer disputes has a defined path that does not require a human.

## Ordering hazard — this CR and `website-target-doc-spec` collide

`instruction-target.feature:126` carries `And it makes that claim in exactly one place, later
passages referring back` — added this session, before the research. That CR is parked at its spec
gate. **If its gate runs first, the disproven criterion gets frozen into a suite**, and retracting it
afterwards costs a re-freeze.

Either land todo 1 before that gate runs, or strike that one clause from the suite now as a
standalone correction. The second is cheaper and does not depend on this CR at all.

## NEXT — resume here

**The deadline strike is landed** (`ee2666fa`) and `website-target-doc-spec` can now take its spec
gate without freezing the disproven criterion.

**The spec side of todos 1–2 is landed.** `doc-eval-model.md` and `doc-impl-bar/README.md` now carry
the two-instrument partition, the retraction with its warrant, and the judged instrument's contract.

**Todos 1–2 are done** across all eleven sites — spec side in `41d3f9d2`, impl side in the commit
after it. Verified by searching both `exactly one place` *and* `restatement`; every surviving hit is
a retraction statement, a plan, or the research dossier.

**Todo 5 is done — the catalog is authored**, nine entries in three groups, in
`quill-builder-impl/SKILL.md` (209 lines, in family with `quill-builder-spec`; the split threshold is
not reached). Todo 3 folded in as entry **C1, declaration mismatch** — the spec's audience and
prerequisites are the catalog's *input*, so a separate declaration-agreement criterion would put one
criterion in two places.

**Resume at todo 6 — calibration. It is the gate on everything else.** Every entry is advisory until
run against documents this repo already accepts and already considers weak, with a false-positive
rate **reported rather than asserted**. Nothing blocks until that runs, so the catalog currently has
no teeth by design. Suggested corpus: the Target article (known-good — 20/20 with one integrity
finding that was half a false positive) against a document the team already considers weak. An entry
that fires on an accepted document is miscalibrated and stays advisory.

**The catalog is unrun.** Nine entries and their near-misses are reasoned, not measured. Group A is
the one to watch: its findings are *negatives* over a named reader path, which is the hardest thing
to evidence and the easiest to fabricate.

### What todo 4 still owes

The tier's contract is written — blind two-pass, deliberate-violation defense,
advisory-until-calibrated, detect-never-certify — across `doc-eval-model.md`,
`doc-impl-bar/README.md`, and the shipped bar. What remains is the open decision below, and the
mechanics calibration will force: how a producer *records* a deliberate-violation rationale so the
judge can read it, and where a per-entry calibration verdict is stored.

### Still open

**Does `quill-judge` run both instruments, or a second agent run the judged one?** One agent is
simpler; two keeps a boolean instrument from being contaminated by a graded one. Todo 4's business —
it does not gate the retraction.

## The quantifier's replacement — path coverage, not a count

`quill-builder-spec`'s rule *"Quantify a claim that more than one passage could carry"* has two
halves, and only one is disproven. The remedy (`in exactly one place`) falls. The **problem** it
names survives: `Then it states X` is satisfied by X appearing anywhere, so a coverage row whose
claim is load-bearing across sections is under-specified.

The correct quantifier is **path coverage**, and the driving case hands it over. A reader arriving at
*Composing configuration* from the sidebar never read the lead — so the question was never *how many
places* carry the claim, but *whether every path that needs it reaches it*:

```gherkin
Then it presents two values that cannot both be one house style
And it states that contrast on each path the control flow routes to it
```

This is strictly stronger than what it replaces, it stays **inspection** (CFG branches are in the
spec, passages are in the document — a comparison), and it freezes nothing on the never-freeze list.
It also inverts the retracted rule's verdict on the Target article: the installer decision table was
not a redundancy to be collapsed, it was the sidebar reader's only statement of the rule.

### Findings the commits will not show

- **The tier partition in this brief was wrong once already** and is corrected in 6262c73e: the
  integrity criteria are not mechanically decidable, so most of the shipped integrity bar becomes the
  seed of the defect catalog rather than a peer of it. Anyone resuming should treat "add a tier" as an
  understatement of the change.
- **Two of the research conclusion's load-bearing claims are marked medium confidence** — that a judge
  can carry craft (our inference from the sources' 1990 vintage, not a finding) and that within-text
  coherence results transfer across pages. Do not let an explore pass promote either to settled
  without saying so.
- **The dossier's citation was itself corrected** (df705cf2): the warrant is Experiment II's
  controlled replication at Δ137 ms, p<.001 — not the 19 ms null, which is Experiment III and
  non-significant. Cite E03; the null corroborates and cannot carry a design decision.
- **Calibration is a gating prerequisite**, not a follow-up (todo 5). It is the empirical test the
  "a judge can do it" inference lacks, and the first thing that will be dropped under time pressure.

### Do not relearn

`## What the research changed` and `## The design` hold settled ground, and
`.research/documentation-craft/conclusion.md` is the source they compress — read it before reopening
any of it. `## Scope` records what is deliberately out: cross-page ordering, foreshadow marking, and
claim overlap between articles all belong to the formation loop, not here.
