---
cr-ref: quill-writing-quality
project-spec: plugins/quill
status: draft
todos:
  - content: Retract the recurrence criterion at all six live sites (impl bar, spec bar x2, doc-impl-bar README, key-point lists, and the instruction-target suite)
    status: pending
  - content: Re-partition the two tiers by what is actually decidable mechanically — most integrity criteria are judgment, not inspection
    status: pending
  - content: Add declaration-agreement — a passage's presuppositions must match the spec's declared audience and prerequisites
    status: pending
  - content: Spec the judged tier — a second evaluation instrument beside static inspection
    status: pending
  - content: Author the defect catalog — named, citable bad-writing shapes, each with a near-miss that must NOT fire
    status: pending
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

## Open decisions — to settle in explore

1. **Reuse ACED's rubric machinery or build quill's own?** ACED already has inline `@rubric`
   scenarios, N runs, thresholds, and a case-judge. The judged tier is the same shape. Reuse is the
   obvious call and the reason to look twice: ACED grades *agent configuration* against simulated
   behavior, while this grades *prose* against a reader — the runner may transfer where the eval
   model does not.
2. **Where the catalog lives** — inside `quill-builder-impl`, or its own loaded-by-name bar. It is
   long, it will grow, and both faces read it.
3. **Does a judged finding block?** A graded tier that hard-blocks will be routed around. Options:
   block on confirmed-and-undefended only; advisory-until-calibrated; or leash-scoped by blast radius
   as SDD does elsewhere.
4. **Whether `quill-judge` runs both tiers or a second agent runs the judged one.** One agent is
   simpler; two keeps a boolean instrument from being contaminated by a graded one.

## Done means

1. The recurrence criterion appears nowhere — verified by search, not by memory. Current live sites:
   `quill-builder-impl` (criterion + key point), `quill-builder-spec` (the scenario-map rule + its
   key point), `doc-impl-bar/README.md`, and `instruction-target.feature:126`.
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

## NEXT

Todo 1, but read the ordering hazard above first — the one-clause strike in
`instruction-target.feature` is worth doing immediately and independently, because it is the only
part of this CR with a deadline attached.

Then todos 1–2 together. Nothing here is frozen and no quill spec node has been touched yet, and the
corrections want a single explore pass with the new tier: correcting the integrity criteria without
somewhere for the craft defects to go would leave them homeless, and re-partitioning the tiers is
what decides where "somewhere" is.

Start by reading `.research/documentation-craft/conclusion.md` in full. The CR's whole argument rests
on it, and two of its load-bearing claims are marked **medium** confidence — that a judge can carry
craft (our inference, not a finding) and that cross-page transfer holds (inferred from within-text
results). Do not let the explore pass promote either to settled without saying so.
