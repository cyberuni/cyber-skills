# verification — quill/doc-eval-model

Acceptance checks for the frozen scenarios in `doc-eval-model.feature`. Authored by the
impl-producer (`quill-doc-writer`); **run** by the impl-judge (`quill-judge`), which never authors
them.

**Target document (every scenario):** `apps/website/src/content/docs/quill/doc-eval-model.md`,
published at `/quill/doc-eval-model/`.

Every scenario below is settled by **static inspection** of that one file, as the feature's preamble
states. No scenario is settled by reading a sibling page, and no scenario asserts a section order, a
wording, an example, or a count.

## Document-wide checks — run once, apply to every scenario

| Check | Passes when |
|---|---|
| **Existence** | `apps/website/src/content/docs/quill/doc-eval-model.md` exists at that project-root-relative path |
| **Frontmatter** | frontmatter carries a non-empty `title` and a non-empty `description` |
| **No placeholder** | the file contains no `TBD`, `TODO`, `FIXME`, or `XXX`, and no bracketed fill-in markers |
| **No empty section** | no heading is immediately followed by the next heading or by EOF |
| **Link form** | every intra-site link is site-absolute and trailing-slashed — no relative paths and no references to files outside `apps/website/` |
| **Declared prerequisite glossed** | the one declared prerequisite (`/quill/overview/`) is linked, and `frozen .feature`, `spec gate`, and `impl gate` are each glossed or linked at first use, since a reader may arrive from search without having met SDD |

A failure of any document-wide check fails every scenario. Report it once, as a `BLOCKER`.

---

## D1 — Decide whether the gate can block without becoming a style argument

### Scenario: the page separates the instruments by what decides the verdict

In the section treating the two instruments (currently `## The split: what decides the verdict`):

- states **inspection** decides by **comparing two structured artifacts** *or* **matching a pattern**
  — both alternatives present
- states **judgment** decides by **simulating a reader**
- states the split is by **how a verdict is reached**
- states the split is **not** by which **file** *or* **bar** a criterion is written in — the negative
  is explicit, and names both file and bar. A page that only asserts the positive criterion fails
  this last step.

### Scenario: the page pairs each instrument with the verdict it yields

Same section:

- states **inspection yields a boolean** *and* that a failure **blocks**
- states **judgment yields a graded finding**
- presents each verdict shape as **following from** how that verdict is reached — an explicit
  derivation ("follows from", "because it compares…, the outcome is…"). Two independent assertions
  of the form "inspection: boolean / judgment: graded" with no connective fail this step.
- gives the reason craft is **judged rather than linted**: a **decision procedure cannot weigh many
  reader expectations at once**

### Scenario: the page bars style at both instruments, not only at the boolean one

Somewhere in the document, a single passage that:

- names all five — **tone, register, length, word choice, section order** — as things **neither**
  instrument asserts
- states the bar holds at the **judged** instrument as well as at the inspection one

### Scenario: the style bar is reachable from both reader arrivals

This is a **reader-path continuity** check over the page's own declared routes.

1. Locate the passage that gives each arrival its route through the page (currently
   `## Two ways through from here`). It must name a route for the **adoption decider** and a route
   for the reader **placing a concern of their own**, each as an ordered list of this page's own
   sections.
2. Walk the decider's route in order. At least one section on it contains a statement that **tone,
   register, length, word choice, and section order** are unassertable.
3. Walk the author's route in order. The same must hold on it.
4. Neither route reaches that statement by leaving the page: the statement is in the document, not
   behind a link. A route whose only path to the style bar is a link to a sibling page fails.

Note for the judge: the two occurrences are **not** a defect. The page is permitted to land a claim
on every path that needs it; what it may not do is land it where the reader cannot retrieve it.
Check only that the later occurrence is marked as **given** (e.g. "as stated above", a definite
reference) rather than presented as new.

### Scenario: the page states that a judged entry does not block until it is calibrated

In the section treating the judged tier's standing (currently
`## The judged tier reports before it blocks`):

- states an entry **does not block until it has been calibrated**
- **glosses calibration** as running the entry against documents the repository **already accepts**
  and **already considers weak** — both halves present
- states **why the asymmetry is deliberate**: a **miss ships a weak paragraph**, while a **false
  positive teaches the producer to route around the judge**
- links `/quill/quill-builder-impl/` as the page recording each entry's current standing
- **Negative check:** the page states the standing of **no** entry. Fails on any claim of the form
  "entry X is advisory / calibrated today", "every entry is currently advisory", or a per-entry
  standing table. Stating the *rule* ("an entry is advisory until calibrated") is required and is
  not a standing claim.

## D2 — Decide whether their own subject is in scope

### Scenario: the page states what puts an artifact inside Quill's lens

In the fit section (currently `## Is your subject even in the lens?`):

- states Quill applies to artifacts whose correctness is **structurally checkable**
- names a **declared path** and **required sections** as the surface that makes it so
- names a **reader flow** as additionally required for a **guide or tutorial**

### Scenario: the page routes a subject outside the lens to the SDD default

Same section:

- states such a subject is **outside Quill's lens**
- states it **recuses to the SDD-default builder**
- **Negative check:** no offer of a reduced, partial, best-effort, or subset Quill grading for that
  subject. The page must say the subject goes elsewhere whole.

## D3 — Decide what a green run lets them claim

### Scenario: the page states what a run with no findings does not certify

In the section on what a clean run certifies (currently `## What a clean run does not certify`):

- states the instrument **detects defects** and **does not certify quality**
- states a document with **zero findings is not thereby certified well written**
- gives the reason: **good prose is unbounded and cannot be enumerated**, while **bad prose recurs
  in a small number of nameable shapes**

## S1 — Decide what a scenario may assert

### Scenario: the page names the four scenario-scoped checks and what each verifies

In the section on what a scenario may assert (currently `## What a scenario may assert`), all four
present, each paired with what it verifies:

| Check | Must state it verifies |
|---|---|
| **Existence** | the target is at its declared **project-root-relative** path |
| **Structure** | the **headings the scenario names** are present |
| **Completeness** | there is **no placeholder text** and **no empty section** |
| **Reader-path** | a **sequential flow reaches its stated outcome**, with **every step present** and **no undeclared external prerequisite** |

All three clauses of the reader-path row are required.

### Scenario: the page states that a concern none of the four checks settles is not scenario material

Same section:

- states **every scenario a documentation `.feature` carries must be checkable by one of the four**
- states a concern **none of them settles does not belong in the suite**

## S2 — Find out what happens to a concern no scenario can hold

### Scenario: the page states why a scenario-scoped check cannot reach a relation between passages

In the section on between-passage concerns (currently `## When no scenario can hold it`):

- states each of the four checks **reads only the passage its scenario names**
- states each occurrence is **well-formed against its own scenario**
- states it is the **pair**, rather than either occurrence, that fails

### Scenario: the page states why another scenario is not the fix

Same section (currently the `### Why another scenario is not the fix` subsection):

- states a **scenario per pair does not scale**
- states such scenarios would **freeze document structure a documentation spec must never freeze**
- links `/quill/quill-builder-spec/` for what that is
- **Negative check:** the page does not restate what a documentation spec must never freeze — no
  list, table, or enumeration of the spec bar's contents. The link stands in place of it.

### Scenario: the page gives the criterion that routes a between-passage concern

Same section (currently `### Which of them is comparison, and which is reading`):

- states a concern whose **two sides are both structured and enumerable** is settled by
  **comparison**
- states a concern whose decision **requires reading as a reader** is **judged**
- names **a route omitting an option the document itself enumerated** as the case comparison settles
- names **at least one** case that **reads as comparable but requires reading as a reader** — e.g. a
  term predicated of a subject class it was not coined for, two claims that cannot both hold, or a
  passage presupposing what the reader's path never established. One suffices; more do not fail.

### Scenario: the page states why the judged criteria were once misclassified as inspection

Same section (currently `### Why the judged ones were once called inspection`):

- states these criteria were **once classed as inspection** because **evidence-with-citation made
  them feel mechanical**
- states the citation requirement **disciplines a finding rather than deciding one** — both verbs,
  contrasted

### Scenario: the page reaches the owning pages by link instead of developing their content

Read the document end to end. Each of the four topics is reached by a link to
`/quill/quill-builder-impl/`, and none is enumerated or restated:

| Topic | Link required | Fails if present |
|---|---|---|
| the enumeration rule's content | `/quill/quill-builder-impl/` | the rule's wording, its comparison procedure, or its citation form spelled out |
| the catalog's entries, their near-misses, and the citation each group owes | `/quill/quill-builder-impl/` | any entry named as a catalog entry, any near-miss stated, any per-group citation rule stated, or a count of the entries |
| the calibration procedure's steps and scoring | `/quill/quill-builder-impl/` | numbered calibration steps, a scoring rule, or a corpus-selection procedure |
| what a judged pass receives and does, including what a calibrated entry blocks on | `/quill/quill-builder-impl/` | what pass 1 receives item by item, the one-finding-per-passage rule, the declaration channel's file or fields, or the "confirmed and undefended" blocking condition |

Naming *a case* the routing criterion covers (required by the criterion scenario above) is not the
same as naming a catalog entry, and does not fail this scenario.

## S3 — Decide whether to penalize a claim that appears twice

### Scenario: the page lands the retraction rather than the retracted rule

In the recurrence section (currently `## Recurrence is not a defect`):

- states an **earlier revision** of the model held a claim landed in **two passages** to be a defect
- states the rule is **retracted**
- states **a claim may recur**

### Scenario: the page states what the measured comprehension cost attaches to

Same section:

- states the measured cost attaches to a passage whose **given information has no retrievable
  antecedent**
- states the cost **does not attach to a claim appearing twice**
- **attributes** the finding to a **cited source** — Haviland and Clark, named in the text — rather
  than asserting it in the page's own voice. A passage stating the finding with no attribution fails.

### Scenario: the page names the retracted rule's own fix as the worse defect

Same section:

- states the retracted rule **prescribed replacing the later statement with a pointer**
- states a **pointer standing where the reader needs the content now is the worse defect**
- gives the reason: such a pointer **guarantees** the bridging cost that recurrence only **risked**

### Scenario: the page gives the checkable question that replaces the retracted rule

Same section:

- states the right amount of redundancy is **relative to the audience** and **reverses** between
  audiences
- states **low-knowledge readers gain from explicit, redundant text** where **high-knowledge readers
  do better with gaps**
- states the checkable question is **agreement with the spec's declared audience and prerequisites**
- states the checkable question is **never quantity**

## S4 — Understand how a judged finding arrives, and what to do with one

### Scenario: the page states that the judged pass reads blind before it scores

In the section on how a judged finding arrives (currently the `### The reading pass runs blind`
subsection):

- states the **reading pass runs blind**, with the **catalog withheld until the reading is done**
- states the **scoring happens afterward, against that reading**
- gives the reason: a judge **shown the catalog before reading finds what it was told to find**,
  making the finding an **opinion about prose rather than evidence about a reader**
- links `/quill/quill-builder-impl/` for what the blind pass receives and how the scoring runs

### Scenario: the page states that a judged finding can be defended as a deliberate violation

Currently the `### A finding can be defended as deliberate` subsection:

- states the **producer may mark a finding intentional with a rationale**
- states the **judge must weigh that rationale before reporting**
- gives the reason the concession is required: **any expectation about prose may be violated to good
  effect**, so a catalog with **no defense path would be a style guide with a gate attached**
- links `/quill/quill-builder-impl/` for how a deliberate violation is declared
- **Negative check:** the page does not state the file or fields the declaration is written in.

### Scenario: the page states what makes a finding reportable at either instrument

Currently the `### Evidence, at both instruments` subsection:

- states a failure must **quote both locations**
- states each citation must name **where it came from, not only what it said**
- gives the reason: a quote **can be accurate and misattributed**, and **reads as verified precisely
  because the words check out**
- states the two locations must be **confirmed distinct**, since a relation between passages
  **cannot be evidenced by one passage read twice**
- states the requirement **holds at the judged instrument as well as at the inspection one**

## Deliberate violations

None declared.
