---
spec-type: behavioral
concept: [marketplace]
---

# marketplace-search — browse and filter the plugin marketplace

> **Stub.** `## Use Cases` is named, not authored. No `.feature` yet.

## What

`MarketplaceSearch.astro` lists every cataloged plugin and lets a reader narrow the list by free-text
search or by tag. It reads the catalog at **build time** via `readMarketplacePlugins()` from the
`cyberplace/tavern` entry point, renders each listing (name, description, tags, crew flag, source
link, install command) as static HTML, and filters client-side — there is no server.

Its testable surface is the filtering behavior and the empty state: what a query matches, how tag
filters combine with the search box, and what shows when the catalog is empty.

**Non-goals** — the catalog's *contents* and the shape `readMarketplacePlugins()` returns; those
belong to the `cyberplace` package spec. Crew-specific presentation is
[`../tavern-storefront/`](../tavern-storefront/README.md).

## Use Cases

*To be authored in explore.* Entry points to name:

- a reader types into the search box
- a reader activates a tag filter (and combines it with a search term)
- the page renders with an empty catalog
- a reader copies a listing's install command or follows its source link

## Control Flow

*To be authored in explore — drawn from `src/components/MarketplaceSearch.astro` (312 lines: build-time
read, then a client script over `data-marketplace*` hooks).*

## Scenario map

*To be authored in explore.*

| Edge | Path (Given) | Scenario |
|---|---|---|
