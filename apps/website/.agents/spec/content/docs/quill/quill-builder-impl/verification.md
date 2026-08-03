# verification — quill/quill-builder-impl

Acceptance checks for every scenario of the frozen `quill-builder-impl.feature`, keyed by scenario
name. The impl-judge **runs** these; it does not author them.

**Target document (every scenario):** `apps/website/src/content/docs/quill/quill-builder-impl.md`

## Checks that apply to every scenario

- **Existence.** The target file exists at the path above.
- **Completeness / no placeholder.** The file contains no `TBD`, `TODO`, or `FIXME`, and no heading
  is immediately followed by another heading or by EOF.
- **Reader-path continuity.** Every named section below is present in the page's own headings, and
  every criterion is stated in the section named for it rather than deferred by a bare pointer.
- **Frontmatter.** `title` and `description` are present and non-empty.
- **Links.** Every site link resolves to a site-absolute `/quill/...` route; every in-page anchor
  (`#a2--bare-cross-reference`, `#b1--re-presented-as-new`) resolves to a heading on this page.

## Deliberate violations

None.

## Per-scenario checks

### the page identifies the bar by actor, gate, and scope

- **Section:** `## What this bar is`.
- **Checks:**
  1. names the **Builder** actor and the **impl gate** as the bar's position;
  2. states the bar runs **once per document** rather than once per scenario;
  3. states the bar **unions onto** the generic conformance bar rather than replacing it;
  4. states each criterion is a **relation between two passages**.

### the page states what the bar carries and links for the split's rationale

- **Section:** `## What the bar carries`.
- **Checks:**
  1. states the bar carries **one enumeration rule** and a catalog of **nine** entries;
  2. links `/quill/doc-eval-model/` as the owner of the two-instrument split;
  3. does **not** argue the split — the section forwards in one sentence and develops no argument
     for why the instruments divide as they do.

### the page states the enumeration rule and what reporting it must cite

- **Section:** `## The enumeration rule`.
- **Checks:**
  1. states a route must reach **every option the document itself named**;
  2. states an option absent from the routing is a **defect rather than a simplification**;
  3. requires a report to cite the **passage enumerating the set** and the **routing that skips a
     member**;
  4. states a failure of this rule is a **blocker**, not an advisory finding.

### the catalog is presented as three groups named by what the defect does to a reader

- **Section:** `## The defect catalog` (intro and group table).
- **Checks:**
  1. presents **nine** entries;
  2. groups them by **what the defect does to a reader**;
  3. names a group for what the reader **cannot retrieve** (A);
  4. names a group for what **misrepresents what the reader already has** (B);
  5. names a group for where the document **disagrees with its own spec** (C).

### group A names its three entries and what each fires on

- **Section:** `### Group A — what the reader cannot retrieve` and its three `####` entries.
- **Checks:**
  1. names **unresolvable presupposition**, **bare cross-reference**, and **undefined term at first
     use**;
  2. each of the three carries a **Fires on** condition;
  3. states that *the reader* means a reader on **one declared control-flow path**.

### group B names its three entries and what each fires on

- **Section:** `### Group B — what misrepresents what the reader already has` and its three `####`
  entries.
- **Checks:**
  1. names **re-presented as new**, **term drift**, and **contradiction**;
  2. each of the three carries a **Fires on** condition.

### group C names its three entries, and gates claim-without-mechanism on the declared doc type

- **Section:** `### Group C — where the document disagrees with its own spec` and its three `####`
  entries.
- **Checks:**
  1. names **declaration mismatch**, **claim without mechanism**, and **orphan claim**;
  2. each of the three carries a **Fires on** condition;
  3. states **claim without mechanism fires only where the declared doc type is explanation**.

### every catalog entry states the near-miss that must not fire it

- **Section:** all nine `####` entries under `## The defect catalog`.
- **Checks:**
  1. each of A1, A2, A3, B1, B2, B3, C1, C2, C3 carries a **Near-miss that must not fire** line —
     nine of nine, counted;
  2. the page states that an entry without a near-miss is a **style opinion with a rubric attached**
     (catalog intro).

### every catalog entry can be used without reading the rest of the page

- **Section:** all nine `####` entries, each read in isolation.
- **Checks (per entry, nine of nine):**
  1. the **fire condition** is stated at the entry;
  2. the **near-miss** is stated at the entry;
  3. the **citation the entry's group owes** is stated at the entry (each entry carries a
     **Citation:** line restating its group's rule, not only a pointer upward);
  4. no entry's usable content is supplied only by an earlier passage.

### the page states which finding to report when one passage fires several entries

- **Section:** `### One finding per passage`.
- **Checks:**
  1. states **one finding is reported per passage**;
  2. names **repair subsumption** as what selects which fired entry is reported.

### the page records recurrence as retracted rather than relocated

- **Section:** `## Recurrence is retracted`.
- **Checks:**
  1. states recurrence is **retracted rather than moved to another instrument**;
  2. states a claim **may recur freely**;
  3. states replacing the second passage with a **pointer is the worse defect**.

### the surviving entry fires on new-information marking, not on the recurrence

- **Section:** `#### B1 — Re-presented as new`.
- **Checks:**
  1. states what fires it is the **marking of returning content as new**;
  2. names at least one **form** that marking takes (indefinite article / existential / defining
     move);
  3. states content restated but **marked as already given** does not fire it;
  4. **negative check:** the entry does not state that recurrence itself fires it — it states the
     opposite explicitly.

### the page names the channel, the three fields, and when the judge reads them

- **Section:** `### Declaring a deliberate violation`.
- **Checks:**
  1. names the **`verification.md` the producer already writes for the judge** as the channel;
  2. states a declaration names the **entry**, the **location**, and the **rationale**;
  3. states the judge reads the record in the **scoring pass only**;
  4. states a rationale asserting only that the choice was deliberate **clears nothing**.

### each group states the citation it owes, and the three rules differ

- **Section:** the **Citation this group owes** paragraph under each of Group A, B, and C.
- **Checks:**
  1. group A requires the absence to be demonstrated **over a named path**;
  2. group A requires **what that path traverses beforehand** to be listed;
  3. group B requires **both passages to be quoted**;
  4. group C requires the **spec line disagreed with** to be quoted;
  5. the three rules are **textually distinct** from one another.

### the page requires each citation to name where it came from and the two locations to be confirmed distinct

- **Section:** `## Evidence — required at both instruments`.
- **Checks:**
  1. states a quote carries its **location** and not only its words;
  2. states two quotes resolving to the **same location are one passage read twice**;
  3. states such a finding is **not reportable**.

### the page states that an entry is advisory until calibrated and what it blocks on afterward

- **Section:** `### Advisory until calibrated`.
- **Checks:**
  1. states an entry does not block until run against documents the repo **already accepts** and
     documents it **already considers weak**;
  2. states the **false-positive rate must be reported rather than asserted**;
  3. states a calibrated entry blocks only on a finding that is **confirmed and undefended**.

### the page shows a per-entry standing, and every entry is advisory

- **Section:** `### Standing today`, plus the **Standing:** line on each of the nine `####` entries.
- **Checks:**
  1. each entry's standing is readable **beside that entry**;
  2. all **nine** entries are shown as **advisory** (table rows A1–C3, all `advisory`);
  3. the page states the whole catalog is therefore **non-blocking**;
  4. states this is the **designed starting state rather than an outage**.

### the page states that a frozen scenario outranks the bar and where the collision is filed

- **Section:** `## Precedence — a frozen scenario outranks this bar`.
- **Checks:**
  1. states the **scenario wins and the bar yields**;
  2. states the collision is filed as an **architect observation against the spec**;
  3. states the collision is **not reported as a gate blocker**.

### the page states the two passes in order and what the blind pass receives

- **Section:** `## Running a judged pass — blind, then scored`.
- **Checks:**
  1. states the first pass **simulates a reader on one declared control-flow path**;
  2. lists the **document**, that **declared path**, and the **audience row** as everything pass 1
     receives — exactly three items, with an explicit "nothing else";
  3. states the second pass **scores pass 1's transcript against the catalog**.

### the page routes the reason the first pass is blind rather than arguing it

- **Section:** `## Running a judged pass — blind, then scored`, the blind-pass paragraph.
- **Checks:**
  1. states the first pass is **blind to the catalog**;
  2. links `/quill/doc-eval-model/` as the owner of the reason;
  3. does **not** argue the reason — one sentence plus the link, no development of why blindness
     works.

### the page states that the catalog detects defects and never certifies quality

- **Section:** `## The defect catalog` (intro).
- **Checks:**
  1. states the catalog **names defects rather than certifying quality**;
  2. states a document with **zero findings is not thereby endorsed**.

### the page gives the calibration run as steps and states what must be recorded

- **Section:** `## Calibrating an entry`.
- **Checks:**
  1. presents the run as **ordered numbered steps**;
  2. states **the team names the corpus**, not the judge;
  3. states the judged pass **runs unchanged** during a calibration;
  4. requires the **false-positive rate and the named corpus to be recorded together**;
  5. states a rate recorded **without a named corpus is not a measurement**.

### the page states how a run is scored and that firing on an accepted document keeps the entry advisory

- **Section:** `### Scoring a run`.
- **Checks:**
  1. states **every firing on an already-accepted document counts as a false positive**;
  2. states a **miss on an already-weak document does not disqualify** the entry;
  3. states an entry firing on an already-accepted document **stays advisory**;
  4. names **widening that entry's near-miss** as the repair.

### the page states that calibration is per entry and not a vote across the catalog

- **Section:** `### Calibration is per entry`.
- **Checks:**
  1. states calibration is **per entry**;
  2. states entries clearing together **tells nothing about another entry**;
  3. states an entry firing on **neither corpus document is untested rather than calibrated**.

### the page names what neither instrument may assert

- **Section:** `## What neither instrument may assert`.
- **Checks:**
  1. names **tone, register, length, word choice, and section order** as out of scope;
  2. states the exclusion holds at **both instruments**;
  3. names **evidence** as what draws the boundary against style.

### the page routes the claims it does not own instead of developing them

- **Section:** `## What this page does not own`.
- **Checks:**
  1. the scenario-scoped checks are reached by a link to `/quill/doc-eval-model/`;
  2. the spec-gate bar is reached by a link to `/quill/quill-builder-spec/`;
  3. which agent runs this bar is reached by a link to `/quill/production-chain/`;
  4. none of the three is developed on this page in place of the link — each is one line plus its
     link.
