# verification — quill/overview

Acceptance checks for the frozen scenarios in `overview.feature`. Authored by the impl-producer
(`quill-doc-writer`); **run** by the impl-judge (`quill-judge`), which never authors them.

**Target document (every scenario):** `apps/website/src/content/docs/quill/overview.md`,
published at `/quill/overview/`.

Every scenario below is settled by **static inspection** of that one file. No scenario requires
building the site, and no scenario is settled by reading a sibling page.

## Document-wide checks — run once, apply to every scenario

| Check | Passes when |
|---|---|
| **Existence** | `apps/website/src/content/docs/quill/overview.md` exists at that project-root-relative path |
| **Frontmatter** | frontmatter carries a non-empty `title` and a non-empty `description` |
| **No placeholder** | the file contains no `TBD`, `TODO`, `FIXME`, or `XXX`, and no bracketed fill-in markers |
| **No empty section** | no heading is immediately followed by the next heading or by EOF — every `##`/`###` has prose, a list, a table, or a code block under it |
| **Link form** | every intra-site link is site-absolute and trailing-slashed (`/quill/<page>/`, `/sdd/overview/`, `/aced/overview/`) — no relative paths, no repo-relative file paths, no links into directories outside `apps/website/` |
| **Staleness regression guard** | the file does **not** claim any bar governance is `null`, does **not** contain a role-to-agent binding table, and does **not** enumerate the verification checks — all three were defects in the superseded draft |

A failure of any document-wide check fails every scenario. Report it once, as a `BLOCKER`, rather
than fifteen times.

---

## E1 — Find out what this is

### Scenario: the page stands alone without prerequisite reading

- **Reader-path continuity.** Read the page top to bottom in document order. No passage instructs the
  reader to read another page *before* continuing. Fails on any of: "read X first", "start with",
  "you should already have read", "prerequisite:", "before continuing, see", or a link presented as
  required prior reading rather than as an onward destination.
- **Terms explained at first use.** For each of these terms, the **first** occurrence in document
  order is accompanied by an inline gloss or an in-place link: `SDD`, `plugin`, `delegate role`,
  `gate`, `conductor`, `artifact-type`, `production chain`, `bar`, `.feature` / `frozen`.
  A gloss is an appositive, a dash clause, or a parenthetical in the same sentence or the sentence
  immediately following. A link to `/sdd/overview/` counts as satisfying the gloss for `SDD`.
- **Self-containment statement present.** The page states it assumes no prior reading.

### Scenario: the page states the gap a documentation runner fills

Required section: a heading whose text names documentation failing the way code does
(currently `## Documentation fails the way code fails`). Under it:

- names **missing content** ✔
- names **structural drift** ✔
- names **reader-path gaps** ✔
- states that these are the **same** defects code has (an explicit sameness claim — "the same
  defects code has", not merely an analogy)
- states that code has a **compiler** and a **test runner** and that documentation has **neither**

### Scenario: the page states what Quill treats a document as

Required section: the heading covering what Quill treats a document as
(currently `## What Quill treats a document as`). Under it:

- the exact claim **"implementation artifact with verifiable structure"** (case-insensitive)
- states the document's behavior is contracted **before the document is written** (an explicit
  ordering claim, not merely "there is a contract")
- names the **`.feature`** and states it is **frozen**, and identifies it as the artifact carrying
  the contract

### Scenario: the page places Quill inside SDD rather than as a standalone tool

Required section: the heading covering Quill not running on its own
(currently `## Quill does not run on its own`). Under it:

- states Quill is a **plugin** to SDD
- states the **conductor** resolves/invokes Quill's delegates when the artifact is a documentation
  **artifact-type**
- states Quill **does not run on its own** — no command the reader runs against their docs

## E2 — Check whether it applies to what they own

### Scenario: the page names the five documentation artifact-types

Required section: the heading covering whether Quill applies
(currently `## Does Quill apply to what you are holding?`). Under it:

- names all five, spelled exactly: `documentation`, `guide`, `tutorial`, `article`, `reference`
- states these are the **keys** by which SDD resolves the Quill chain for a file

### Scenario: the page states what makes a subject structurally checkable

Same section. Under it:

- states the subject must have a **declared path**
- states the subject must have **required sections**
- states a **guide or tutorial** additionally needs a **reader flow**

### Scenario: a subject the chain does not resolve for is given the recusal, not a refusal

Same section. Under it:

- states the **SDD default chain** handles a subject Quill does not resolve for
- **one** destination statement covers **both** reasons — no inspectable document surface, and a
  document of a type outside the five. Fails if only one reason is given a destination, or if the
  two are given different destinations.
- **Negative check:** the passage does not describe either case as *refused*, *rejected*,
  *unsupported*, *not supported*, or *turned away* — including in a negated form, since the word's
  presence is what a reader takes away.

## E3 — Get it running

### Scenario: the page presents installing and registering as two separate steps

Required section: the setup heading (currently `## Getting it running`). Under it:

- a fenced code block containing the install command `npx skills add cyberuni/cyberplace --plugin quill`
- states registering is a **further, separate step** — the two acts are numbered or otherwise
  presented as distinct, not as one instruction
- states that **without registration the conductor resolves Quill for nothing**

### Scenario: the next-step guidance names the page that owns registration

Same section. Under it:

- a link to `/quill/init-quill/`
- **Negative check:** the section does not reproduce the registry entry's contents — no JSON block,
  no field-by-field listing of the registry entry, no `.agents/universal-plugin.json` fragment.

## E4 — Find out what it will not touch

### Scenario: the page states that wording, style, and tone are never asserted

Required section: the heading covering the two instruments
(currently `## Two instruments, and what neither of them asserts`). Under it:

- states **wording** is not asserted
- states **style** and **tone** are not asserted
- attributes the limit to **both** instruments — an explicit "holds at the judged instrument as well
  as the boolean one" claim. Fails if the limit is attributed to only one instrument or left
  unattributed.
- links `/quill/doc-eval-model/` as the page of record for that limit

## S1 — Find which chain handles a documentation change

### Scenario: the page names the roles Quill fills and defers the bindings to the owning page

- states Quill **fills the production-chain delegate roles** for its artifact-types
- links `/quill/production-chain/`
- **Negative check — the load-bearing one.** No passage anywhere in the document pairs a
  production-chain role with the agent or governance that fills it. Grep the whole file for
  `quill-spec-writer`, `quill-doc-writer`, `quill-judge`, `quill-builder-spec` and
  `quill-builder-impl` **as fillers**: any sentence, table row, or list item that puts one of those
  names next to `spec-producer`, `solution-producer`, `spec-judge`, `impl-producer`, `impl-judge`,
  `oracle-spec`, `builder-spec`, `builder-impl`, `architect-spec`, or `architect-impl` fails this
  scenario. Link **text** naming a sibling page (e.g. "Builder bar — impl gate" as the label on
  `/quill/quill-builder-impl/`) is a page title, not a binding, and does not fail.

## S2 — Reach one specific part

### Scenario: every page in the section is reachable from the entry page

All five sibling URLs appear as links in the document:

| Sibling | URL that must be linked |
|---|---|
| Doc eval model | `/quill/doc-eval-model/` |
| Production chain | `/quill/production-chain/` |
| init-quill | `/quill/init-quill/` |
| Builder bar — spec gate | `/quill/quill-builder-spec/` |
| Builder bar — impl gate | `/quill/quill-builder-impl/` |

And: in the routing section (currently `## Where to go next`) each of the five links carries a
**description of what that page covers** in the same list item — not a bare link.

### Scenario: the route discriminates by the question a page answers

In the routing section:

- each of the five descriptions states **the question that page answers**. Fails if a description
  identifies its page by position ("the next page", "the last of the five", "further reading") or by
  nothing but its title.
- the two bar pages are distinguished **by gate**: the `/quill/quill-builder-spec/` entry names the
  **spec gate** and the `/quill/quill-builder-impl/` entry names the **impl gate**, and the two
  descriptions are not interchangeable.
- the `/quill/doc-eval-model/` entry is framed as **how** a document is checked and the
  `/quill/production-chain/` entry as **who** checks it — two different questions, visibly so.

### Scenario: both instruments are named and each routes to the page that owns the split

In the two-instruments section:

- **inspection** is named, and stated to reach a **boolean** verdict by **comparing the document
  against a frozen artifact**
- **judgment** is named, and stated to reach a **graded** verdict by **simulating a reader** against
  a **frozen catalog**
- a link to `/quill/doc-eval-model/` accompanies **each** of the two — one link per instrument, in
  or adjacent to that instrument's own statement. A single link after both, with neither attached to
  either, fails.

### Scenario: the entry page routes to the owning page instead of standing in for it

For each of the three topics, a link is present **and** the topic is not developed:

| Topic | Link that must be present | Must not appear |
|---|---|---|
| what a check verifies | `/quill/doc-eval-model/` | a table or list enumerating the checks and what each verifies |
| what a documentation spec must contain | `/quill/quill-builder-spec/` | a list of what a doc spec must contain or must never freeze |
| what the impl gate holds a document to | `/quill/quill-builder-impl/` | the enumeration rule's wording, catalog entries, near-misses, or per-entry standing |

"Developed" means **argued, enumerated, or tabulated**. A one-line statement of a claim at the point
a reader needs it is not a failure — the section boundary bars a second place that develops a claim,
not a second place that mentions it.

## Deliberate violations

None declared.
