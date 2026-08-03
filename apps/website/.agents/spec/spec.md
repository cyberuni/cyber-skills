---
status: implemented
name: website
project-path: apps/website
approval:
  impl:
    verdict: approve
    by: agent
    cause: dimension
    why:
      floor: none at impl — no frozen scenario was narrowed here. The Clearance that fired earlier belongs to the spec gate's contract repair and was pre-authorized by the owner.
      blast: low — two passages in one published article plus its verification record. No sibling page, no sidebar, no other suite.
      novelty: medium — the first contract repair on this corpus driven by a Conflict the impl gate found inside an already-frozen suite, then re-gated and re-implemented in sequence.
      confidence: high — a cold quill-judge returns 29 of 29 scenarios PASS with every passage independently located, the document-scoped enumeration rule clean across all four enumerated sets, and no inspection failure. It read the calibration table before aggregating and correctly held both judged findings advisory. Pass 1 ran blind in a separate context. It confirmed the old enumeration survives nowhere and all 30 verification quotes resolve.
      cr: website-target-doc-spec
  spec:
    verdict: approve
    by: agent
    cause: dimension
    why:
      floor: none — one new behavioral leaf under an existing grouping, purely additive. No pre-existing frozen scenario anywhere in this project was narrowed, rewritten or re-opened; the node's own suite was unfrozen throughout, so no Clearance floor could fire.
      blast: low — a single page node (README + suite) and its parent grouping's findings list. No sibling node, no root node-table entry, and no published document changed at this gate.
      novelty: low — the section's fourth specified page, against a layout and depth departure both already declared and argued in this spec.
      confidence: high — four cold sdd-spec-judge rounds, each a fresh actor re-deriving the previous round's fixes rather than accepting them. Round 4 returns {oracle,builder,architect} all PASS, ALIGNED true, no failing scenario and no content gap, having independently re-derived the 29/29 map identity, traced all 14 coverage rows, walked every CFG edge, and spot-checked the producer's transcription audit across all three source kinds. Findings 7 → 7 → 1 → 0, with every pre-existing defect closed by round 3 and the last self-inflicted one closed without introducing another.
      cr: website-target-doc-spec
---

# website — the cyberplace documentation site

> Root project spec — the **descriptive** top index for the `website` project (the Astro site at
> `apps/website`). Backfilled onto an existing site. Ten nodes are authored and carry a `.feature`;
> the remaining seven are **stubs** still awaiting their explore grill.

## What this is

`website` is the public documentation site for cyberplace — an [Astro](https://astro.build) 6 app
using the [Starlight](https://starlight.astro.build) docs theme, styled with Tailwind 4, built to
static files and published to GitHub Pages at `https://cyberuni.github.io/cyberplace/`.

It publishes 80 authored pages across 16 sections (getting-started, agent-configuration, motive-model, sdd,
cli, governances, concepts, aced, quill, cyberlegion, cyberfleet, disciplines, universal-plugin,
marketplace, tavern, plus root pages), and carries four interactive surfaces beyond plain prose: a
marketplace search, a crew storefront, Mermaid diagram rendering, and a custom site title.

The project is **private** (`"private": true`) — it is never published to npm. What ships is the
built `dist/`, so this spec colocates at `apps/website/.agents/spec/` rather than hoisting; there is
nothing to keep it out of.

**Non-goals** — the *content* of the documentation is written against the source projects it
documents; this spec owns the **site**, and treats the corpus as the thing the site publishes (see
the backfill gap below). The skills, plugins, and CLI the docs describe are specified by their own
project specs (`.agents/specs/*`, `packages/*/.agents/spec`).

## Key terms

- **content collection** — Astro's typed directory of Markdown/MDX under `src/content/docs`; each
  file becomes one page at a slug derived from its path.
- **base path** — the URL prefix the site is served under (`/cyberplace/`), because GitHub Pages
  hosts it in a subdirectory rather than at a domain root.
- **sidebar** — the navigation tree, declared by hand in `astro.config.mjs` rather than derived from
  the file tree.

## Placement map — strategy: mirror-source

This spec is organized **mirror-source**: spec nodes track the source tree, so a contributor who
navigates by code finds the spec node in the same shape.

| Source | Spec node |
|---|---|
| `src/content/docs/<section>/<page>.md` | `content/docs/<section>/<page>/` — one behavioral leaf per **page** |
| `src/components/<X>.astro` | `components/<x>/` — one behavioral leaf per component |
| `src/styles/**` | [`styles/`](./styles/README.md) |
| `astro.config.mjs`, `package.json`, `public/` | `tooling/` |

The mirror keeps **every segment** of the source path, so the spec tree and the source tree read the
same. `content/`, `content/docs/`, and each `content/docs/<section>/` are **descriptive groupings**,
not nodes; the behavioral leaf is the **page**.

**A document is the unit of contract.** Each page's node states its **north star** (the understanding
a reader leaves with), its **required coverage** (the claims the document is incomplete without), and
the **reader questions it must route**. It freezes what the document must land, never its section
order or wording. This is the granularity quill is built for — it treats a document as an
implementation artifact with verifiable structure, checked by two instruments: inspection against a
frozen suite, and a judged pass against a catalog of named prose defects.

### Depth: this project mirrors past two levels — deliberately

The SDD layout law caps a node at `<capability>/<unit>` — two levels. This project's content tree
sits at **four** (`content/docs/<section>/<page>/`), which is a declared departure, not an oversight.

The reason is that collapsing a level would break the mirror the strategy exists to provide:
dropping `content/` or `docs/` leaves a spec path that matches no source path, and merging them into
one folder invents a name the source does not have. Under `mirror-source`, fidelity to the source
path is the whole value; a cap that forces a divergence defeats it.

What the cap protects is the mission scheduler's node↔capability alignment, and that is **intact
here** — arguably sharper than the cap would give: one **page** is exactly one node, which is the
finest true unit of change in a documentation corpus (a doc is edited as a whole; two people editing
one page collide for real). The three extra segments are groupings that own no behavior and can never
be the unit of a change. Nothing is smeared across nodes.

This is judged, not linted — `check-spec-structure` enforces no depth rule (breadth-vs-depth is
Warden judgment). A formation Warden pass may therefore contest it; this section is the standing
answer.

### Where a new concept lives

Slot here; do not invent placement:

- **a new documentation page** → its own leaf, `content/docs/<section>/<page>/`, when its contract is
  worth freezing — otherwise it stays in the backfill gap
- **a new documentation section** → a new `content/docs/<section>/` descriptive grouping, plus a leaf
  per page inside it
- **a property spanning two pages** (a hub reaching its axis pages, one page citing another) → the
  node of the page that **owns the relationship**, not a node of its own; if it holds across every
  section, it is a rule → `design/`
- **a new interactive component** (`src/components/<X>.astro`) → a new `components/<x>/` leaf
- **a change to theming, typography, or the color system** → `styles/`
- **a change to the sidebar / information architecture** → `tooling/navigation/`
- **a change to Astro or Starlight configuration, integrations, the base path, or the build** →
  `tooling/site-config/`
- **a rule or model that spans nodes** (a content style rule, an IA principle) → `design/`
  (descriptive), with the scenarios enacting it in the capability node
- **a decision + its rationale** → `design/decisions/` (the ADR log — append-only, ungated)
- **a whole-site usage flow** crossing several nodes (a reader lands, searches, navigates, reads) →
  `workflows/`
- **a cross-cutting concern** spanning several nodes → a `concept:` tag, recovered through the
  by-concept index below — **never** a deeper folder. The mirror segments above are the *only*
  sanctioned depth; a concern is never a folder level.

### The cost of mirror-source here — declared, not hidden

`src/` is **layer-organized** (`content/`, `components/`, `styles/`), not feature-organized, so this
tree is a **coarse partition**: one capability can smear across `content/`, `components/`, and
`styles/` at once. Adding marketplace search, for example, touches a component node, a style, and a
content page.

The consequence is **precision, not correctness**. The mission scheduler is conservative — a
collision it cannot resolve **serializes** — so a coarse partition yields a *slower* schedule, never
a corrupted one. Three mechanisms recover most of the loss: the collision ladder descends below the
node (file, region, semantic, symbol), worktrees dissolve file-level false dependencies until
write-back, and `concept:` tags carry the capability view the folders do not.

**The exit, when it is earned:** a `concept:` tag that spans many nodes is the measured signal that a
capability wants its own home. Hoist one capability at a time when the scheduler's false-conflict
rate justifies the move. Capability-first is the destination; it is not an entry toll, and this
project adopted on the shape it has.

## Behavioral nodes

Ten nodes are **authored** — `## What` / `## Use Cases` / `## Control Flow` / `## Scenario map`
present, with a `.feature` bound 1:1 to the scenario map. The remaining seven are **stubs** —
`## Use Cases` present, no `.feature`, no authored control flow. Filling those is the per-unit
explore grill.

| Node | Subject |
|---|---|
| [`content/docs/agent-configuration/instruction-target/`](./content/docs/agent-configuration/instruction-target/README.md) | the "Target" article — north star, required coverage, reader routing **(authored)** |
| [`content/docs/motive-model/overview/`](./content/docs/motive-model/overview/README.md) | the Motive Model entry page — the premise, the AI-is-never-an-actor rule, the route **(authored)** |
| [`content/docs/motive-model/four-actors/`](./content/docs/motive-model/four-actors/README.md) | the four motives, their objects and boundaries **(authored)** |
| [`content/docs/motive-model/glossary/`](./content/docs/motive-model/glossary/README.md) | the definition of record for the model's load-bearing terms **(authored)** |
| [`content/docs/quill/overview/`](./content/docs/quill/overview/README.md) | the Quill section's entry page — what Quill is and the route to its five siblings **(authored)** |
| [`content/docs/quill/doc-eval-model/`](./content/docs/quill/doc-eval-model/README.md) | how Quill decides a document is correct — the two instruments **(authored)** |
| [`content/docs/quill/production-chain/`](./content/docs/quill/production-chain/README.md) | Quill's three agents and the five SDD roles they fill **(authored)** |
| [`content/docs/quill/init-quill/`](./content/docs/quill/init-quill/README.md) | registering Quill as a project's documentation SDD plugin **(authored)** |
| [`content/docs/quill/quill-builder-spec/`](./content/docs/quill/quill-builder-spec/README.md) | the spec-gate Builder bar — what a documentation spec must contain **(authored)** |
| [`content/docs/quill/quill-builder-impl/`](./content/docs/quill/quill-builder-impl/README.md) | the impl-gate Builder bar — the enumeration rule and the defect catalog **(authored)** |
| [`components/marketplace-search/`](./components/marketplace-search/README.md) | browsing and filtering the skill marketplace |
| [`components/tavern-storefront/`](./components/tavern-storefront/README.md) | browsing the crew storefront |
| [`components/mermaid/`](./components/mermaid/README.md) | rendering Mermaid diagrams in docs pages |
| [`components/site-title/`](./components/site-title/README.md) | the site's branded header |
| [`styles/`](./styles/README.md) | the visual theme — typography, color, light/dark |
| [`tooling/site-config/`](./tooling/site-config/README.md) | Astro/Starlight configuration, base path, build |
| [`tooling/navigation/`](./tooling/navigation/README.md) | the sidebar information architecture |

## Backfill gap (known)

Two gaps are **declared**, not silently omitted:

1. **Seven of seventeen nodes are stubs.** The site is fully implemented and deployed; the four
   non-content nodes (`components/*`, `styles/`, `tooling/*`) are captured only as stubs, as are the
   remaining `components` leaves. Each needs its explore grill to produce `## What` / `## Use Cases` /
   `## Control Flow` / `## Scenario map` and a `.feature`. On backfill the CFG is **drawn from the
   source**, not stopped at Use Cases.

2. **70 of 80 pages are unspecified.** A page earns a node when its contract is worth freezing.
   Specified so far: `agent-configuration/instruction-target`, three `motive-model` pages
   (`overview`, `four-actors`, `glossary`), and all six `quill` pages. Outstanding — the two
   remaining `agent-configuration` pages (`overview`, `instruction-purpose`), the six remaining
   `motive-model` pages, then `aced` (12 pages), `concepts` (11), `sdd` (8), `governances` (6),
   `cli` (5), `cyberfleet` (5), `universal-plugin` (5), `getting-started` (3), `cyberlegion` (2),
   `disciplines` (1), `marketplace` (1), `tavern` (1), plus 2 root pages. Each is a future change
   request. The repo registers **quill** for the `documentation` / `guide` / `reference` artifact
   types, so each runs its production chain (`quill-spec-writer` → `quill-doc-writer` →
   `quill-judge`) — as the `quill` section itself did.

   **Two section-level defects are recorded but unowned** — `overview.md` never links the Target
   page, and it carries a broken relative link to `../instructions.md`. Both are the hub's contract
   to hold, so they are parked in
   [`content/docs/agent-configuration/`](./content/docs/agent-configuration/README.md) until
   `overview` is specified.

Not a gap, but worth stating because it reads like one: the `marketplace/` and `tavern/` content
sections are **absent from the sidebar by design**. The site's information architecture is
**two-tier** — the sidebar covers the docs, while those two destinations are reached from the **top
navigation** rendered by `components/site-title/`. A reconciliation of sidebar-vs-corpus must not
flag them.

<!-- BEGIN generated: by-concept (project-spec/concept-index) -->

## By concept

> Generated from `concept:` frontmatter by `project-spec/concept-index` — do not edit by hand.

| Concept | Facets |
|---|---|
| `build` | `tooling/site-config/` (behavior) |
| `composition` | `content/docs/agent-configuration/instruction-target/` (behavior) |
| `docs` | `components/mermaid/` (behavior) · `content/docs/agent-configuration/instruction-target/` (behavior) · `content/docs/motive-model/four-actors/` (behavior) · `content/docs/motive-model/glossary/` (behavior) · `content/docs/motive-model/overview/` (behavior) · `content/docs/quill/doc-eval-model/` (behavior) · `content/docs/quill/init-quill/` (behavior) · `content/docs/quill/overview/` (behavior) · `content/docs/quill/production-chain/` (behavior) · `content/docs/quill/quill-builder-impl/` (behavior) · `content/docs/quill/quill-builder-spec/` (behavior) |
| `marketplace` | `components/marketplace-search/` (behavior) · `components/tavern-storefront/` (behavior) |
| `motive-model` | `content/docs/motive-model/four-actors/` (behavior) · `content/docs/motive-model/glossary/` (behavior) · `content/docs/motive-model/overview/` (behavior) |
| `navigation` | `components/site-title/` (behavior) · `tooling/navigation/` (behavior) |
| `quill` | `content/docs/quill/doc-eval-model/` (behavior) · `content/docs/quill/init-quill/` (behavior) · `content/docs/quill/overview/` (behavior) · `content/docs/quill/production-chain/` (behavior) · `content/docs/quill/quill-builder-impl/` (behavior) · `content/docs/quill/quill-builder-spec/` (behavior) |
| `theming` | `components/mermaid/` (behavior) · `components/site-title/` (behavior) · `styles/` (behavior) |

<!-- END generated: by-concept -->
