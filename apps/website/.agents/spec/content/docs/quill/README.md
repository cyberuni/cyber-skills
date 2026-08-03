# quill — the Quill plugin section

Descriptive grouping. Mirrors `src/content/docs/quill/`, the section documenting **Quill** — SDD's
documentation-domain plugin. Six pages, six behavioral leaves.

Quill is the subject of these pages; the **artifact** is a website page, so every node here belongs
to the `website` project spec. Quill's own contract lives at `.agents/specs/quill/` and is an
**input** to these documents, never their owner. A defect found in Quill while writing them is a
follow-up against that spec, not a change made here.

## The pages

| Page | Doc type | Owns |
|---|---|---|
| [`overview/`](./overview/README.md) | explanation | what Quill is, the problem it resolves, its domain types, and the route to the other five pages |
| [`doc-eval-model/`](./doc-eval-model/README.md) | explanation | the **two-instrument** split — inspection vs judgment — and why a document needs both |
| [`production-chain/`](./production-chain/README.md) | reference | the five SDD production-chain roles, Quill's bindings, and the write-vs-run independence anchor |
| [`init-quill/`](./init-quill/README.md) | how-to | registering Quill in a project — the registry entry, its failure modes, and the next step |
| [`quill-builder-spec/`](./quill-builder-spec/README.md) | reference | the **spec-gate** Builder bar — what a documentation spec must contain and must never freeze |
| [`quill-builder-impl/`](./quill-builder-impl/README.md) | reference | the **impl-gate** Builder bar — the document-scoped enumeration rule and the judged defect catalog |

## Ownership boundaries — one claim, one owner

Six pages over one subject is the shape that manufactures scenario overlap: each page can plausibly
explain the checks, the roles, and the bars. The boundary below is the contract. A page that
**develops** a claim another page owns is a defect at the impl gate, not a courtesy to the reader —
the reader is served by a **link**, and the duplicate is the thing that goes stale.

**Develop, not state.** This rule bans arguing a claim, enumerating it, or tabulating it in a second
place. It does not ban **stating** it. A one-line caveat at the point a reader needs it — *the
catalog detects defects and never certifies quality*, standing beside an entry a reader is consulting
— is not a boundary breach, and cutting it to a pointer would build the exact defect Quill's own
catalog names: a bare cross-reference standing where the reader needs the content now. Quill retracts
recurrence as a defect on measured grounds; a claim may arrive on every path that needs it, and what
it may not do is arrive where the reader cannot retrieve it. So the test is not *does this claim
appear twice* but **does this page argue, enumerate, or tabulate what another page owns**.

The section's one-claim-one-owner rule and Quill's recurrence retraction are therefore not in
tension: ownership governs where a claim is *made good*, never where it may be *mentioned*.

| Claim | Owner | Every other page |
|---|---|---|
| what the four scenario-scoped checks verify | `doc-eval-model` | names them, links, does not enumerate what each verifies |
| why the document-scoped check exists (scenario scope is blind to relations *between* passages) | `doc-eval-model` | may state that it exists |
| the **content** of the document-scoped enumeration rule | `quill-builder-impl` | links |
| **why** craft is judged rather than linted, and why a judged verdict is graded rather than boolean | `doc-eval-model` | links |
| **why** the first pass must be blind, and **why** an entry is advisory until calibrated | `doc-eval-model` | links |
| **what** a judged pass does — what pass 1 receives, one finding per passage, the declaration channel and its fields, the calibration run's steps and scoring, the per-entry standing | `quill-builder-impl` | links |
| the **entries** of the defect catalog, their near-misses, and the citation each group owes | `quill-builder-impl` | links |
| what a documentation spec must contain, and must never freeze | `quill-builder-spec` | links |
| which agent fills which role, and who **writes** vs who **runs** | `production-chain` | links |
| the registry entry's **shape** and how it is written | `init-quill` | links |
| the **values** inside that entry — which agent name and which bar fills each slot | `production-chain` | links |
| install command and domain types | `overview` | links |

### The why/what seam on the judged tier

`doc-eval-model` and `quill-builder-impl` both touch the judged instrument, and the first draft of
this table let both develop it. The seam is **explanation versus reference**, and it is recorded here
rather than left to each page's own reading:

- `doc-eval-model` carries the **argument**. Craft is judged because a decision procedure cannot
  weigh many reader expectations at once; the first pass is blind because a judge shown the catalog
  finds what it was told to find; an entry stays advisory because a miss ships a weak paragraph while
  a false positive teaches the producer to route around the judge. It states **that** each mechanism
  exists and links for its operation.
- `quill-builder-impl` carries the **procedure**. What pass 1 receives and what it does not, the
  file and fields a producer declares a deliberate violation in, the steps of a calibration run and
  how it is scored, the standing of each entry today, and what a calibrated entry blocks on.

A reader who wants to know *whether to trust the judged tier* reads the first; a reader running it
reads the second. Neither restates the other's half — it links.

**The single authority for role and bar bindings is `.agents/universal-plugin.json`.** A page
derives a binding table from the registry, never from another page's prose — the current section is
stale precisely because a table was copied and the registry then moved under it.

## What a page node here owns

Per [`../README.md`](../README.md): the document's **north star**, its **required coverage**, and
the **reader questions it must route**. It freezes what the document must land — never its section
order or its wording.

**What it does not own:** sidebar placement (`../../../tooling/navigation/`) and frontmatter/routing
(`../../../tooling/site-config/`). This section adds four pages to the sidebar; that edit is
delivered with this change request but contracted by `tooling/navigation/`, which is still a stub.
