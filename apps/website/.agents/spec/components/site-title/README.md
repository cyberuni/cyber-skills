---
spec-type: behavioral
concept: [navigation, theming]
---

# site-title — the branded header and top navigation

> **Stub.** `## Use Cases` is named, not authored. No `.feature` yet.

## What

`SiteTitle.astro` replaces Starlight's built-in site title (wired through the `components` map in
`astro.config.mjs`). It renders two things: the site name linking home, and a **top navigation bar**
carrying Docs / Marketplace / Tavern with the current section marked active.

That top nav is load-bearing for the site's information architecture: it is the **only** way to reach
the Marketplace and Tavern pages, which are deliberately absent from the sidebar. The IA is therefore
two-tier — top nav across destinations, sidebar within the docs.

Two behaviors carry real logic. Starlight keys its `title` **by locale** (`{ en: 'cyberplace' }`), so
the component resolves it for the current route, falling back to the first entry and then to a
literal. And active-link detection is a **prefix match with a guard**: paths are normalized with a
trailing slash so the base path does not match — and highlight — every route.

**Non-goals** — the sidebar tree ([`../../tooling/navigation/`](../../tooling/navigation/README.md))
and the header's visual styling ([`../../styles/`](../../styles/README.md)).

## Use Cases

*To be authored in explore.* Entry points to name:

- the header renders on a route under one of the nav destinations (that link is active)
- the header renders at the site root (the guard prevents every link from matching)
- the header renders on a route under none of them (no link is active)
- Starlight's `title` is a plain string, a locale map matching the current locale, or a locale map
  that does not (each fallback rung)

## Control Flow

*To be authored in explore — drawn from `src/components/SiteTitle.astro` (103 lines; the title
fallback chain and `isActive` carry the branching).*

## Scenario map

*To be authored in explore.*

| Edge | Path (Given) | Scenario |
|---|---|---|
