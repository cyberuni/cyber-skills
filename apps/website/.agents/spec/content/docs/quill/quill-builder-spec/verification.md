# verification — quill/quill-builder-spec

Acceptance checks for every scenario of the frozen `quill-builder-spec.feature`, keyed by scenario
name. The impl-judge **runs** these; it does not author them.

**Target document (every scenario):** `apps/website/src/content/docs/quill/quill-builder-spec.md`

## Checks that apply to every scenario

- **Existence.** The target file exists at the path above.
- **Completeness / no placeholder.** The file contains no `TBD`, `TODO`, or `FIXME`, and no heading
  is immediately followed by another heading or by EOF.
- **Reader-path continuity.** Every named section below is reachable from the page's own headings
  (no section referenced here is absent), and every requirement is stated in the section named for
  it rather than deferred to another passage by a bare pointer.
- **Frontmatter.** `title` and `description` are present and non-empty.
- **Links.** Every site link is site-absolute and resolves to a page that exists — the `/quill/...`
  routes, plus `/sdd/overview/` (whose `## The governances` table is the anchor target
  `#the-governances`).

## Deliberate violations

None.

## Per-scenario checks

### the reference page exists at its declared path

- **Section:** n/a (whole file).
- **Check:** the file exists at `apps/website/src/content/docs/quill/quill-builder-spec.md` and is
  non-empty.

### the page states which actor and which gate this bar belongs to

- **Section:** `## What this bar is` → `### Which actor, and which gate`.
- **Checks:**
  1. states this is the **Builder** actor's bar;
  2. states it applies at the **spec gate**, and contrasts that with the impl gate;
  3. carries a link to `/quill/quill-builder-impl/`.

### the page states that the bar unions onto the generic builder bar rather than replacing it

- **Section:** `### It unions onto the generic SDD builder-spec bar`.
- **Checks:**
  1. states the bar **unions onto** the generic SDD `builder-spec` bar rather than replacing it;
  2. states the generic testability and coverage requirements still apply;
  3. does **not** develop or re-derive those generic requirements here — the section names them and
     forwards to the section that names them plus their owning governance.

### the page states the two directions the bar is read in

- **Section:** `### One bar, read in two directions`.
- **Checks:**
  1. states the spec-producer role reads the bar **forward** while authoring;
  2. states the gate reads the same bar **backward** while grading;
  3. states this is why each requirement is given with the condition that decides it.

### the page enumerates the seven required elements of the What section

- **Section:** `## The seven required elements of `## What`` (intro list).
- **Check:** all seven are named as required — audience table, declared doc type, north star,
  statement of why the document exists, required-coverage list, non-goals, prerequisites.

### the page requires an audience row to name a role and a goal

- **Section:** `### 1. Audience — a table whose rows name a role and a goal`.
- **Checks:**
  1. states the audience is a **table**, not a phrase;
  2. states each row names a role **together with what that role is trying to accomplish**;
  3. gives at least one example phrase that fails (`the reader` / `users` / `developers`);
  4. states why it fails — it names no goal, so nothing about the document follows from it;
  5. states the audience list is written **before** the coverage list and the use cases, which are
     derived from it.

### the page states that an audience with no reader entry point is not an audience

- **Section:** `### An audience with no reader entry point is not an audience`.
- **Checks:**
  1. states a row no reader entry point serves **fails** as an audience;
  2. states a row carrying at least one reader entry point **stands**;
  3. names **adding a reader entry point** as one remedy;
  4. names **cutting the row** as the other remedy.

### the page treats opposite needs on one fact as a decision to be recorded

- **Section:** `### Two audiences needing opposite things from one fact`.
- **Checks:**
  1. states this is a signal to decide between **one document and two**;
  2. states the decision must be **recorded** whichever way it goes;
  3. states that leaving the case **undecided** is what fails.

### the page requires a north star to carry a failure mode

- **Section:** `### 3. North star — one sentence, carrying a failure mode`.
- **Checks:**
  1. states the north star names what the reader **leaves with**;
  2. states it must carry a **concrete reader state that would mean the document missed**;
  3. states that a north star without such a state **grades nothing**.

### the page routes a document whose purpose restates its title

- **Section:** `### 4. Why the document exists`.
- **Checks:**
  1. directs the case to be **stated outright** rather than papered over;
  2. states the consequence surfaced — the document may not need to exist separately from its
     parent;
  3. directs a problem that **can** be stated independently to be stated in the domain's own terms.

### the page states the drop test for a key point

- **Section:** `### 5. Required coverage — key points, and the drop test`.
- **Checks:**
  1. states each row is a **claim the document must land**, not a section name;
  2. states the test — whether a reader would be **worse off** if the row were dropped and the
     document left unchanged;
  3. states a row failing that test is **cut**;
  4. states each row must be checkable by **static inspection**, with a link to
     `/quill/doc-eval-model/`.

### the page states when a coverage list is complete

- **Section:** `### When the coverage list is complete`.
- **Checks:**
  1. states the list is complete when a document meeting **every** row cannot still trip the north
     star's failure mode;
  2. states that if such a document could still trip it, **a key point is missing**.

### the page requires a non-goal to carry a forwarding address

- **Section:** `### 6. Non-goals — each with a forwarding address`.
- **Checks:**
  1. states each exclusion names **where that material lives instead**;
  2. states an exclusion with no forwarding address reads as an **omission rather than a decision**.

### the page requires prerequisites to name the document that supplies them

- **Section:** `### 7. Prerequisites — each naming the document that supplies it`.
- **Checks:**
  1. states prerequisites name what a reader must already know;
  2. states each names **which document supplies it**;
  3. states a document claiming to be **self-contained declares that explicitly**.

### the page requires reader entry points grouped by audience

- **Section:** `## `## Use Cases` — reader entry points, grouped by audience`.
- **Checks:**
  1. states each row is **one way a reader arrives**;
  2. states a row gives the **trigger**, **what the reader brings**, and **what they leave with**;
  3. states rows are **grouped under their audience**;
  4. states every audience carries **at least one** entry point;
  5. states every entry point **traces to a coverage row** that serves it.

### the page routes a document to its type by what the reader is doing

- **Section:** `### 2. Doc type — one of four, declared, chosen by what the reader is doing`.
- **Checks:**
  1. routes *doing something for the first time, learning by doing* → **tutorial**;
  2. routes *accomplishing a goal they already understand* → **how-to**;
  3. routes *looking one thing up* → **reference**;
  4. routes *building understanding rather than doing a task* → **explanation**;
  5. states what counts as **success** for each of the four;
  6. states that **mixing types in one document** is a common structural defect.

### the page distinguishes the reader's decision path from the table of contents

- **Section:** `## `## Control Flow` — the reader's decision path`.
- **Checks:**
  1. states the graph draws the **questions the document must answer to route a reader**;
  2. states a list of the document's sections is **not** a control-flow graph;
  3. states the difference — a section list records what was written, the graph records what a
     reader needs and in what order;
  4. presents branching first on **which audience the reader is** as the default where several
     audiences are served.

### the page routes a disjunction by the kind of node it sits in

- **Section:** `### A disjunction is read by the node it sits in`.
- **Checks:**
  1. directs a disjunction in a **decision node** to be **kept**, on the ground that a decision node
     is a question;
  2. directs a disjunction in an **outcome node** to be **promoted** to a decision node with the
     criterion on its edges;
  3. states the consequence of leaving it in an outcome node — the reader is left needing to choose
     with no criterion to choose on.

### the page treats an unrouted option as a gap rather than a simplification

- **Section:** `### A route must reach every option the spec enumerates`.
- **Checks:**
  1. states the omitted member is a **gap rather than a simplification**;
  2. names **routing to the option** as one remedy;
  3. names **stating why the option is excluded** as the other remedy.

### the page binds every coverage row to at least one scenario

- **Section:** `## `## Scenario map` — one-to-one with the suite`.
- **Checks:**
  1. states the map is **one-to-one with the suite**;
  2. states every coverage row is reachable from **at least one** scenario;
  3. states a coverage row no scenario checks is **unenforced**.

### the page names what the other half of the union bar still requires

- **Section:** `### What the other half of the union still requires`.
- **Checks:**
  1. states every **edge of the spec's control flow carries a scenario**;
  2. states every **guard or negative edge is paired with a positive companion**;
  3. states every scenario asserts an **observable boolean outcome**;
  4. **links** the governance that owns those three requirements — the section contains a markdown
     link (`[...](...)`) whose target is the page that locates the SDD `builder-spec` governance
     (`/sdd/overview/#the-governances`), and names that governance as the owner — rather than
     deriving the three requirements on this page. A named owner with no link **fails** this check:
     the frozen `Then` says *links*, not *names*.

### the page directs a shared claim to be asserted against the reader's paths

- **Section:** `### A load-bearing claim is asserted against the reader's paths`.
- **Checks:**
  1. states an assertion that the document merely **states** the claim is satisfied wherever the
     claim lands;
  2. directs the claim to be required **on each path the control flow routes a reader to it**;
  3. states this freezes **no wording, no section order, and no count**.

### the page requires a routing scenario to assert what decides

- **Section:** `### A routing scenario asserts what decides`.
- **Checks:**
  1. directs the assertion to name **what decides** which option a case takes;
  2. states an assertion naming only **where the case lands** passes whether or not that destination
     is the right one;
  3. states the consequence — the suite **ratifies the route the draft took instead of testing it**;
  4. states a destination-only assertion is worth writing **only where the set has one member**.

### the page routes a subject by whether it has an inspectable document surface

- **Section:** `### Fit — whether this bar applies at all`.
- **Checks:**
  1. directs a subject with a **declared path and required sections** to be graded under this bar;
  2. directs a subject with **no inspectable document surface** to **recuse to the SDD-default
     chain**;
  3. states that carrying prose does not by itself make an artifact a documentation subject.

### the page reaches what it does not own by link

- **Section:** `## What this page does not own`.
- **Checks:**
  1. the impl-gate bar is reached by a link to `/quill/quill-builder-impl/`;
  2. what the static checks verify is reached by a link to `/quill/doc-eval-model/`;
  3. which agent fills the spec-producer role is reached by a link to `/quill/production-chain/`;
  4. none of the three is developed on this page in place of the link — each is one line plus its
     link.

### a reader reaches one requirement without reading the page through

- **Section:** every `###` requirement heading on the page.
- **Checks:**
  1. each requirement sits under a heading naming the **element it governs** (audience, doc type,
     north star, why it exists, key points, non-goals, prerequisites, use cases, control flow,
     disjunction, routing coverage, scenario map, shared claim, routing scenario, never-freeze,
     what is frozen, missing element);
  2. each requirement is **stated where its heading leads**, not replaced by a pointer to another
     passage;
  3. each defines or links every term it depends on at the point of use — spot-check
     *reader entry point* (defined in `### An audience with no reader entry point is not an
     audience`), *static inspection* (linked to `/quill/doc-eval-model/`), and *control flow*
     (glossed inline in `### A load-bearing claim is asserted against the reader's paths`).

### every requirement is stated with the condition that makes it pass

- **Section:** each of the seven required-element sections plus the `## Use Cases`,
  `## Control Flow`, and `## Scenario map` sections.
- **Checks:**
  1. every required element carries a condition that decides whether it passes (a test, a failing
     case, or a stated "fails when…");
  2. **no element is given as a name alone** — no bullet or row names an element with no pass
     condition attached.

### the page states that a missing element is returned rather than guessed

- **Section:** `## When a required element is missing`.
- **Checks:**
  1. states a missing **audience, doc type, north star, or coverage table** is returned as a
     **content gap for the user to settle**;
  2. states the audience is **not inferred** from the document's existing prose;
  3. states why — inferring **launders whatever audience the draft happens to serve into the
     contract**.

### the page states that routing coverage is checked against the spec, not the draft

- **Section:** `### A route must reach every option the spec enumerates`.
- **Checks:**
  1. states the check is made **against the spec** rather than against the document;
  2. states why — at the spec gate the document **may not exist yet**;
  3. states the cost of grading against the draft — the **draft's omissions become the contract**.

### the page enumerates what a documentation spec never freezes

- **Section:** `## What a documentation spec never freezes`.
- **Checks:** names all four — the **order of the document's sections**; **wording, phrasing, and
  headings**; **which specific examples are used**; **length, tone, and voice**.

### the page states what the spec does freeze, in one rule

- **Section:** `### What the spec does freeze`.
- **Checks:**
  1. states the **claims the document must land** are frozen;
  2. states the **paths a reader takes** to reach those claims are frozen;
  3. states an example is asserted by the **kind of example required**, not by which example is
     used;
  4. states the rule in one line — *freeze the claims and the reader's path, and leave the prose to
     the author*.

### the page names the cost that freezing prose would buy

- **Section:** `### Why the prohibition exists`.
- **Checks:**
  1. states a spec freezing order, wording, examples, or tone **breaks on every honest revision
     while catching no real defect**;
  2. names that outcome as the failure mode that **makes teams abandon documentation specs**;
  3. states a **reordering that serves readers better must not fail the gate**.

### the page presents the place-count rule as retracted, with the ground for the retraction

- **Section:** `### The place-count rule is retracted`.
- **Checks:**
  1. marks the place-count rule **retracted rather than current**;
  2. states recurrence has **no empirical warrant as a defect**;
  3. states the count gets its **driving case backwards**, because a reader arriving at a later
     section has not read the lead;
  4. **negative check:** that same section states **no requirement fixing how many places a claim
     may appear in** — grep the section for any current-tense count requirement (`exactly one
     place`, `only once`, `at most N places`) appearing other than as the retracted rule being
     named.
