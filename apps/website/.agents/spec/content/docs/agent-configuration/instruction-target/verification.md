# verification — agent-configuration/instruction-target

Acceptance checks for the frozen scenarios in `instruction-target.feature`. Authored by the
impl-producer (`quill-doc-writer`); **run** by the impl-judge (`quill-judge`), which never authors
them.

**Target document (every scenario):** `apps/website/src/content/docs/agent-configuration/instruction-target.md`,
published at `/agent-configuration/instruction-target/`.

Every scenario below is settled by **static inspection** of that one file. The feature freezes
neither section order nor wording, so every section name below is given as *currently* — a check
that names a heading is satisfied by the passage wherever it sits.

## Document-wide checks — run once, apply to every scenario

| Check | Passes when |
|---|---|
| **Existence** | `apps/website/src/content/docs/agent-configuration/instruction-target.md` exists at that project-root-relative path |
| **Frontmatter** | frontmatter carries a non-empty `title` and a non-empty `description` |
| **No placeholder** | the file contains no `TBD`, `TODO`, `FIXME`, or `XXX`, and no bracketed fill-in markers |
| **No empty section** | no heading is immediately followed by the next heading or by EOF |
| **Link form** | every intra-site link is site-absolute and trailing-slashed, or an in-page `#anchor` resolving to a heading in this file |
| **No reference drift** | the declared doc type is **explanation**. No settings table, no per-harness option reference, no version-tracked field list. `globs:` and `applyTo:` appear only as evidence a mechanism exists |

A failure of any document-wide check fails every scenario. Report it once, as a `BLOCKER`.

---

## A1 — Decide whether to split a file

### Scenario: the article stands alone without prerequisite reading

Reader-path continuity check over the whole document, for a reader carrying only
`/agent-configuration/overview/`.

1. **Every term defined or linked at first use.** Walk the document top to bottom and confirm each
   load-bearing term is glossed or linked where it is first relied on:

   | Term | First use | Satisfied by |
   |---|---|---|
   | Target | lead, ¶1 | "identifies which of the agent's outputs an instruction governs, and therefore who eventually reads it" |
   | file type / description / prose matching | `## Specifying a target`, mechanisms table | the table's `Where the target lives` / `Decided by` / `What it settles` columns |
   | scope statement | `## Specifying a target`, the paragraph opening "Prose matching costs a **scope statement**" | glossed inline as "a line naming the target that its neighboring rules govern" |
   | drift | `## User: the default target`, ¶1 | linked to `#keeping-targets-apart-within-one-session`, where it is developed |
   | bleed | `## Keeping targets apart within one session`, ¶1 | glossed inline as "to keep shaping output it was never meant for", at the first use of the verb; arrangement 1's "accumulated nothing that can bleed" is downstream of it |
   | brief / mail | `## Agent: briefs and mail are not interchangeable`, the two bullets | each bullet defines its form before the section relies on it |
   | Tone | `## User: the default target`, ¶3 | glossed as "the purpose that governs how a thing is said rather than what it conveys", and *purpose* links to `/agent-configuration/instruction-purpose/` |
   | Procedure | same paragraph | glossed as "an instruction about what to do rather than how to say it" |
   | Reference / Menu | `## Agent…`, last ¶ | each glossed in its parenthetical ("context to load"; "a closed set of options the recipient must choose from") |

2. **No section directs the reader to read another document first.** Negative check over every
   link and every imperative in the document. Fails on any construction of the form "read X first",
   "start with X", "if you have not read X", or a prerequisite note. `## Related` is a link list with
   no reading instruction and does not fail this. Links to `/agent-configuration/instruction-purpose/`
   are references, not directives.

### Scenario: the article names separation by target as the seam that splits config

In `## Composing configuration`, ¶2:

- states that **separating instructions by target makes them reusable independently** — "Separating
  instructions by target is what makes them reusable independently"
- states that **mixing targets in one unit is what forces it to be adopted whole** — "Mixing targets
  in one unit is what forces it to be adopted whole"

Both must be present as claims about the general case, not only as a property of the
`article-writer-voice` example.

### Scenario: a mixed-target file routes to a separate unit or to prose matching

In `## Specifying a target`:

- states **a path binds at file granularity while the targets vary inside the file** — the paragraph
  ending "The glob binds at file granularity while the targets vary inside the file."
- **directs a target whose rules can stand as their own unit to description matching** — "where a
  target's rules can stand as their own unit, split them out and let description matching load each
  on its own situation"
- **reserves prose matching for variants that splitting would duplicate** — both the routing bullet
  ("reserved for variants that splitting would duplicate") and "Prose matching is for the case where
  splitting would copy more than it separates"

### Scenario: the article defines Target before naming any mechanism

- the **opening** (the first paragraph, before any `##`) states Target is **which of the agent's
  outputs an instruction governs**
- the same sentence states this determines **who eventually reads the instruction**
- **Ordering check:** the first occurrence of any mechanism name — "file type matching",
  "description matching", "prose matching" — is at a **later line** than that definition. Currently
  the definition is line 6 and the first mechanism name is inside `## Specifying a target`.

### Scenario: the opening motivates Target with two values that contradict

In the opening, ¶1–¶2:

- presents **two instruction values that cannot both be one house style** — a caveman register for
  replies and plain, carefully written English for documentation, with the explicit statement "no
  single house style could hold both a caveman register and careful written English"
- states that **assigning them to separate targets lets them coexist** — "assigned to two targets
  they coexist"

## A2 — Bind a unit to its target

### Scenario: file type matching is reserved for content a path can name

In `## Specifying a target`:

- **reserves** file type matching for **both** conditions conjoined — the routing bullet "reserved
  for the case where the harness offers a path glob **and** a path names the content the instruction
  governs". A statement carrying only one of the two conditions fails.
- states it is **deterministic, because the harness evaluates the glob rather than the agent judging
  the situation** — the causal connective is required, not two adjacent assertions
- **names at least one harness that provides a glob field** — Cursor (`globs:`) and GitHub Copilot
  (`applyTo:`); either alone suffices

### Scenario: description matching is reserved for content no path can name

Same section:

- **reserves** description matching for the case where **no path names the content the instruction
  governs**, and the enumeration that follows includes **both** named sub-cases: "the harness offers
  no path glob at all" and "the output is not a file at all". Both must be present.
- states it is **a semantic judgment the agent makes rather than a rule the harness evaluates** —
  both halves of the contrast

### Scenario: each mechanism states where the target lives, who decides, and what it settles

The mechanisms table in `## Specifying a target`:

- names all three: **file type matching**, **description matching**, **prose matching**
- for **each** row, a non-empty value in all three of: where the target lives, who decides it, what
  it settles

### Scenario: a target needing a substantial body of instruction is isolated rather than scoped

In `## Specifying a target`, the closing paragraph:

- states that where one target needs a **substantial body of instruction**, **isolating it in its own
  subagent or session beats scoping it in place**
- states that **isolation removes the competing target from context**
- states that **a scope statement instead asks the agent to honor a boundary on every turn**

### Scenario: a target needing a short instruction is bound by a scope statement in the body

In `## Specifying a target`, the paragraph beginning "Prose matching costs a **scope statement**":

- states that a target needing **only a scope statement rather than a substantial body of
  instruction** is specified by **writing the target into the instruction body**. The conditional is
  required — an unconditional "write the target into the body" fails, because the scenario's `Given`
  is the short-instruction case and its complement is the isolation scenario above.
- states that **no harness setting enforces that boundary**

### Scenario: the Artifact section states it is the only target with a path

In `## Artifact: the only target with a path`, ¶2 — all three, and the second and third stated as
**consequences of having a path**, not as free-standing facts:

- **Artifact is the only target that has a path**
- **having a path is what makes file type matching possible**
- **having a path is why a single file can hold content governed by several targets at once** —
  currently supplied with its mechanism: "the path belongs to the file, while the content inside it
  can answer to whatever conventions it likes"

### Scenario: the User and Agent sections state that no path reaches them

Two sections, checked separately; **both** must satisfy both steps.

| Section | No file path corresponds | Description or prose matching carries the target |
|---|---|---|
| `## User: the default target` | "No file path corresponds to the User target." | "description matching or prose matching carries the target instead" |
| `## Agent: briefs and mail are not interchangeable` | "No file path corresponds to either form" | "so a description or the instruction body has to carry the target" — *the instruction body* is where prose matching lives per the mechanisms table |

### Scenario: the Agent section distinguishes a brief from mail by the recipient's standing mission

In `## Agent: briefs and mail are not interchangeable`, the paragraph beginning "The distinction that
matters is the recipient's standing mission" — all four:

- **a brief becomes the recipient's mission**
- **mail arrives at an agent that already has a mission**
- **mail therefore competes for attention rather than setting the agenda**
- **mail must therefore stand on its own, carrying the context the recipient needs to act without
  access to the sender's session**

### Scenario: the User section states that every purpose applies to it, not only Tone

In `## User: the default target`, ¶3:

- states **every purpose applies to the User target, not only Tone**
- **gives an example of a User instruction that is not about how something is said** — "when you need
  user input, state the reasoning that led to the question", identified as **Procedure**. The example
  must be labelled as something other than Tone; a bare example fails.

### Scenario: the User section states that the user can answer back

In `## User: the default target`, last ¶:

- states **the user can respond, which no other target can**
- states **a brief must instead anticipate what would have been asked**

## A3 — Stop a unit bleeding

### Scenario: the article attributes drift to accumulation of unlabeled examples

In `## Keeping targets apart within one session`, ¶1–¶2:

- states **produced output accumulates as unlabeled examples** — "produced output accumulates as
  unlabeled examples, carrying no record of which target they were for"
- states **drift runs toward whichever target was served most** — "toward whichever target the agent
  has been serving most"

### Scenario: a separate session is reserved for an artifact a brief can specify

Arrangement **1** in the numbered list:

- **reserves** it for **an artifact that can be specified in a brief** — the reservation must be on
  the arrangement itself, not only implied by the routing table below it
- states **a freshly spawned session has accumulated nothing that can bleed**
- states its cost is **starting with no context**, which **fits poorly when the artifact is the
  residue of a long discussion**

### Scenario: restating the target is reserved for an artifact a brief cannot specify

Arrangement **2**:

- **directs an artifact that cannot be specified in a brief** to restating the target **at the moment
  of production**
- states its cost is **having to remember to do it**

### Scenario: producing early is reserved for a session that knows its artifact upfront

Arrangement **3**:

- **reserves** producing the artifact early for **a session that knows at the outset which artifact
  it will produce**
- states **producing early works because less output for another target has accumulated** — the
  causal connective is required
- states its cost is **nothing to apply, but that it depends on that foreknowledge** — both halves

### Scenario: scoping the instruction is reserved for a session that discovers its artifacts as it runs

Arrangement **4**:

- **reserves** it for **a session that does not know at the outset which artifact it will produce**
- states it **separates the targets least of the four**
- states **a scope statement is exactly what accumulation erodes**
- states it is **nonetheless the only arrangement asking nothing at production time**

### Scenario: the four arrangements are ranked by separation strength

The numbered list in `## Keeping targets apart within one session`:

- **exactly four** arrangements are presented
- states that **the four arrangements remedy drift in an instruction governing a produced artifact.**
  The scope must be **stated**, not left to be inferred from the arrangements or the routing
  questions below — currently the introducing sentence, "Four arrangements remedy drift in an
  instruction governing a produced artifact". A sentence that introduces the four without naming what
  kind of instruction they remedy fails this step, **even though every item beneath it concerns an
  artifact**: the four items and the three routing questions all being artifact-shaped is precisely
  the implication this step exists to reject.
- the list states its **ordering by how strongly each separates the targets** — "ordered by how
  strongly each separates the targets — decreasing separation, increasing convenience"
- **each of the four carries the cost of adopting it.** Check per item, not in aggregate: 1 = no
  starting context; 2 = having to remember; 3 = depends on foreknowledge; 4 = weakest separation,
  eroded by accumulation.

**Enumeration check (`quill-builder-impl` inspection rule).** The document enumerates four
arrangements; the routing table immediately below the list must reach **all four**. Compare the set
`{separate session, restate at production, produce early, scope the instruction}` against the table's
outcomes. Any arrangement enumerated but never routed to is a `BLOCKER`.

## C1 — Predict whether two configs will fight

### Scenario: the article addresses the user combining units, not only the author writing them

In `## Composing configuration`:

- states **units governing different targets can be enabled together** — the coexistence table's
  first row plus "both may be in force at once"
- **gives that reader a way to tell whether two units govern the same output** — an operation the
  user can perform without authoring anything: "Ask of each unit where its output lands — into a file
  that outlives the session, into this conversation, or into another agent's context". A passage
  asserting that different targets coexist but supplying no test fails this step.

### Scenario: two units on different targets are shown coexisting

Same section:

- states the test as **comparing what each of the two units governs** — "The test is to compare what
  each of the two governs"
- states **two contradicting units whose targets differ never meet, so both may be in force at once**
- **names a concrete pair of units in that position** — `article-writer-voice` (Artifact) and
  `i-have-adhd` (User), each attributed to its target

### Scenario: two units on the same target are named a real conflict

Same section, the paragraph beginning "Two contradicting units governing the same target":

- states that two contradicting units governing the same target is a **genuine conflict rather than a
  coexistence**
- states **one of them has to win, because there is no second target to separate them onto**

The lead makes the same claim; that recurrence is not a defect. The check is satisfied by the
occurrence inside the coexistence treatment, which is the section the scenario's `When` names.

### Scenario: two units sharing a purpose do not compete on that account

Same section, last ¶:

- states **a block's purpose is unchanged by which target receives it**
- states **only a shared target puts two units in conflict**

## C2 — Diagnose over-reach

### Scenario: each of the three targets has its own section

List the document's headings. There is a section covering each of **Artifact**, **User**, and
**Agent**. Currently `## Artifact: the only target with a path`, `## User: the default target`,
`## Agent: briefs and mail are not interchangeable`. The heading text need not be the bare target
name; it must identify the target.

### Scenario: each target names where its output goes, the forms it covers, and an example

The three-targets table in `## The three targets`. For **each** of Artifact, User, and Agent, a
non-empty value in all three of: where that output goes, the forms of output it covers, an example of
a unit governing that target.

### Scenario: a unit bound to the target the user intended is diagnosed as drift

In `## Keeping targets apart within one session`, ¶2–¶3:

- states **a scope statement made once competes against the examples the session accumulates**
- states **the longer the session runs the weaker that scope statement's position**
- **points a reader who has diagnosed drift to the arrangements** — "That is drift rather than a
  mis-scoped unit, and the remedy is one of the four arrangements below, chosen by the questions that
  follow them." The pointer must be to the arrangements *and* to the chooser, since a reader who has
  only diagnosed drift still needs a criterion; a passage naming four options with no route fails.

### Scenario: an instruction that names no target is placed on the user by default

In `## User: the default target`, ¶1:

- states that **the user receives whatever the agent neither writes to a file nor addresses to another
  agent** — currently "The user receives whatever the agent neither writes to a file nor addresses to
  another agent." The claim is the **residual** one: what is left after writing-to-a-file and
  addressing-another-agent are excluded. A formulation that instead **enumerates** what the user does
  not receive — "everything other than a file or a brief" — fails, because it is false of mail, which
  is neither a file nor a brief and does not reach the user.
- states **the User target is therefore always in force** — the inference marker ("therefore") is
  required; two adjacent assertions fail

## Deliberate violations

None declared.

## Revision note — contract repair

Two blocks above were re-derived after the `.feature` was repaired and re-frozen; the rest of this
file is unchanged and its scenarios were unaffected.

| Block | Was | Now |
|---|---|---|
| `an instruction that names no target is placed on the user by default` | quoted the defective enumeration ("everything the agent produces other than a file or a brief goes to the user") | checks the residual formulation the repaired `Then` requires, and names the enumeration as an explicit failure |
| `the four arrangements are ranked by separation strength` | count, ordering, per-item cost | plus the artifact-scope clause, with inference-from-the-items named as a failure |
