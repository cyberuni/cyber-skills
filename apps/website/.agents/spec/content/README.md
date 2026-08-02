---
spec-type: behavioral
concept: [docs]
---

# content — the published documentation corpus

> **Stub.** `## Use Cases` is named, not authored. No `.feature` yet. Filling this node is the
> per-unit explore grill.

## What

Everything the site publishes as prose: 76 pages across 16 sections under `src/content/docs`,
rendered by Starlight from Markdown and MDX. This node **owns its whole subtree** — under
mirror-source a folder with a testable surface becomes one behavioral leaf, and no node is created
below it.

Its testable surface is the corpus as published: that every page reaches a URL, that its frontmatter
carries what Starlight requires, that internal links resolve under the base path, and that a page
referenced by the sidebar exists.

**Non-goals** — the *accuracy* of what each page says about the project it documents; that is owed by
the source project's own spec. The sidebar tree that reaches these pages is
[`../tooling/navigation/`](../tooling/navigation/README.md).

## Use Cases

*To be authored in explore.* Entry points to name — each as trigger / inputs / outcome, named to its
implementation surface:

- a reader requests a page slug
- a page embeds an interactive component (`MarketplaceSearch`, `TavernStorefront`, `Mermaid`)
- the build validates the collection's frontmatter schema
- a page links to another page, relative to the base path

## Control Flow

*To be authored in explore — **drawn from the source**, not stopped at Use Cases.* Read
`src/content/docs/**` and Starlight's collection handling, then draw the CFG as a Mermaid graph.

## Scenario map

*To be authored in explore.* One row per scenario, grouped by use case, 1:1 with the suite.

| Edge | Path (Given) | Scenario |
|---|---|---|
