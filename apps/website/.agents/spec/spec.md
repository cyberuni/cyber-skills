---
status: draft
name: website
project-path: apps/website
---

# website — the cyberplace documentation site

> Root project spec — the **descriptive** top index for the `website` project (the Astro site at
> `apps/website`). Backfilled onto an existing site. One node
> (`content/docs/agent-configuration/`) is authored and carries a `.feature`; the rest are **stubs**
> still awaiting their explore grill. No suite is frozen — no gate has run.

## What this is

`website` is the public documentation site for cyberplace — an [Astro](https://astro.build) 6 app
using the [Starlight](https://starlight.astro.build) docs theme, styled with Tailwind 4, built to
static files and published to GitHub Pages at `https://cyberuni.github.io/cyberplace/`.

It publishes 76 authored pages across 16 sections (getting-started, agent-configuration, motive-model, sdd,
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
| `src/content/docs/<section>/` | `content/docs/<section>/` — one behavioral leaf per doc section |
| `src/components/<X>.astro` | `components/<x>/` — one behavioral leaf per component |
| `src/styles/**` | [`styles/`](./styles/README.md) |
| `astro.config.mjs`, `package.json`, `public/` | `tooling/` |

The mirror keeps **every segment** of the source path, so the spec tree and the source tree read the
same. `content/` and `content/docs/` are **descriptive groupings**, not nodes; the behavioral leaf is
the section.

### Depth: this project mirrors past two levels — deliberately

The SDD layout law caps a node at `<capability>/<unit>` — two levels. This project's content tree
sits at **three** (`content/docs/<section>/`), which is a declared departure, not an oversight.

The reason is that collapsing a level would break the mirror the strategy exists to provide:
dropping `content/` or `docs/` leaves a spec path that matches no source path, and merging them into
one folder invents a name the source does not have. Under `mirror-source`, fidelity to the source
path is the whole value; a cap that forces a divergence defeats it.

What the cap protects is the mission scheduler's node↔capability alignment, and that is **intact
here**: one section is still exactly one node, and the two extra segments are groupings that own no
behavior and can never be the unit of a change. Nothing is smeared across nodes.

This is judged, not linted — `check-spec-structure` enforces no depth rule (breadth-vs-depth is
Warden judgment). A formation Warden pass may therefore contest it; this section is the standing
answer.

### Where a new concept lives

Slot here; do not invent placement:

- **a new documentation page** → the section's node, `content/docs/<section>/` (the leaf owns its
  section's pages; do **not** create a node per page)
- **a new documentation section** → a new `content/docs/<section>/` leaf, when its contract is worth
  freezing — otherwise it stays in the backfill gap
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

All are **stubs** — `## Use Cases` present, no `.feature`, no authored control flow — **except**
`content/docs/agent-configuration/`, which is authored (CFG drawn from source, 8 scenarios, scenario
map 1:1). Filling the rest is the per-unit explore grill.

| Node | Subject |
|---|---|
| [`content/docs/agent-configuration/`](./content/docs/agent-configuration/README.md) | the instruction-writing section — reachability and cross-reference integrity **(authored — the only node with a `.feature`)** |
| [`components/marketplace-search/`](./components/marketplace-search/README.md) | browsing and filtering the skill marketplace |
| [`components/tavern-storefront/`](./components/tavern-storefront/README.md) | browsing the crew storefront |
| [`components/mermaid/`](./components/mermaid/README.md) | rendering Mermaid diagrams in docs pages |
| [`components/site-title/`](./components/site-title/README.md) | the site's branded header |
| [`styles/`](./styles/README.md) | the visual theme — typography, color, light/dark |
| [`tooling/site-config/`](./tooling/site-config/README.md) | Astro/Starlight configuration, base path, build |
| [`tooling/navigation/`](./tooling/navigation/README.md) | the sidebar information architecture |

## Backfill gap (known)

Two gaps are **declared**, not silently omitted:

1. **Seven of eight nodes are stubs.** The site is fully implemented and deployed; only
   `content/docs/agent-configuration/` is captured as an authored contract. Each remaining node needs
   its explore grill to produce `## What` / `## Use Cases` / `## Control Flow` / `## Scenario map`
   and a `.feature`. On backfill the CFG is **drawn from the source**, not stopped at Use Cases.

2. **15 of 16 doc sections are unspecified.** Sections earn a node one at a time. Specified so far:
   `agent-configuration` (3 pages). Outstanding — `aced` (12 pages), `concepts` (11),
   `motive-model` (9), `sdd` (8), `governances` (6), `cli` (5), `cyberfleet` (5),
   `universal-plugin` (5), `getting-started` (3), `quill` (2), `cyberlegion` (2), `disciplines` (1),
   `marketplace` (1), `tavern` (1), plus 2 root pages — **73 pages** in total. Each is a future
   change request, opened when that section's contract is worth freezing. The repo registers
   **quill** for the `documentation` / `guide` / `reference` artifact types, so each runs its
   production chain (`quill-spec-writer` → `quill-doc-writer` → `quill-judge`).

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
| `docs` | `components/mermaid/` (behavior) · `content/docs/agent-configuration/` (behavior) |
| `marketplace` | `components/marketplace-search/` (behavior) · `components/tavern-storefront/` (behavior) |
| `navigation` | `components/site-title/` (behavior) · `content/docs/agent-configuration/` (behavior) · `tooling/navigation/` (behavior) |
| `theming` | `components/mermaid/` (behavior) · `components/site-title/` (behavior) · `styles/` (behavior) |

<!-- END generated: by-concept -->
