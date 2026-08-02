---
status: draft
name: website
project-path: apps/website
---

# website — the cyberplace documentation site

> Root project spec — the **descriptive** top index for the `website` project (the Astro site at
> `apps/website`). Backfilled onto an existing site: the skeleton below is **stubs**, not authored
> contracts. Every behavioral node still needs its explore grill.

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
| `src/content/docs/**` | [`content/`](./content/README.md) — one behavioral leaf owning the whole corpus |
| `src/components/<X>.astro` | `components/<x>/` — one behavioral leaf per component |
| `src/styles/**` | [`styles/`](./styles/README.md) |
| `astro.config.mjs`, `package.json`, `public/` | `tooling/` |

Where a new concept lives — slot here, do not invent placement:

- **a new documentation page or section** → `content/` (the leaf owns its whole subtree; do **not**
  create a node per doc section — see the backfill gap)
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
- **a cross-cutting concern** that would want a third folder level → a `concept:` tag, recovered
  through the by-concept index below. **Never** a third folder level.

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

All are **stubs** — `## Use Cases` present, no `.feature`, no authored control flow. Filling each one
is the per-unit explore grill, not this scaffold.

| Node | Subject |
|---|---|
| [`content/`](./content/README.md) | the published documentation corpus |
| [`components/marketplace-search/`](./components/marketplace-search/README.md) | browsing and filtering the skill marketplace |
| [`components/tavern-storefront/`](./components/tavern-storefront/README.md) | browsing the crew storefront |
| [`components/mermaid/`](./components/mermaid/README.md) | rendering Mermaid diagrams in docs pages |
| [`components/site-title/`](./components/site-title/README.md) | the site's branded header |
| [`styles/`](./styles/README.md) | the visual theme — typography, color, light/dark |
| [`tooling/site-config/`](./tooling/site-config/README.md) | Astro/Starlight configuration, base path, build |
| [`tooling/navigation/`](./tooling/navigation/README.md) | the sidebar information architecture |

## Backfill gap (known)

Two gaps are **declared**, not silently omitted:

1. **Every node is a stub.** The site is fully implemented and deployed; none of it is captured as an
   authored contract. Each node needs its explore grill to produce `## What` / `## Use Cases` /
   `## Control Flow` / `## Scenario map` and a `.feature`. On backfill the CFG is **drawn from the
   source**, not stopped at Use Cases.

2. **The 76-page corpus is one leaf, not 16 nodes.** `content/` owns the entire
   `src/content/docs/**` subtree as a single behavioral leaf. The 16 sections — `aced` (12 pages),
   `concepts` (11), `motive-model` (9), `sdd` (8), `governances` (6), `cli` (5), `cyberfleet` (5),
   `universal-plugin` (5), `getting-started` (3), `agent-configuration` (3), `quill` (2),
   `cyberlegion` (2), `disciplines` (1), `marketplace` (1), `tavern` (1), plus 2 root pages — are
   **not** individually specified. Splitting them into per-section nodes is a future change request,
   to be opened when the corpus contract earns the granularity. Note the repo registers **quill** for
   the `documentation` / `guide` / `reference` artifact types, so that split would run its production
   chain.

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
| `docs` | `components/mermaid/` (behavior) · `content/` (behavior) |
| `marketplace` | `components/marketplace-search/` (behavior) · `components/tavern-storefront/` (behavior) |
| `navigation` | `components/site-title/` (behavior) · `tooling/navigation/` (behavior) |
| `theming` | `components/mermaid/` (behavior) · `components/site-title/` (behavior) · `styles/` (behavior) |

<!-- END generated: by-concept -->
