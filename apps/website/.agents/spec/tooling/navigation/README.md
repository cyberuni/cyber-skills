---
spec-type: behavioral
concept: [navigation]
---

# navigation — the sidebar information architecture

> **Stub.** `## Use Cases` is named, not authored. No `.feature` yet.

## What

The sidebar tree, declared **by hand** as the `sidebar` array in `astro.config.mjs`. It is not
derived from the file tree, which is the single most consequential fact about this node: **a new page
is invisible until someone adds it to the sidebar**, and a sidebar entry pointing at a deleted page
is a broken link. Both are silent failures.

The tree currently declares 14 groups (Getting Started, Agent Configuration, The Motive Model, SDD
Workflow, CLI Reference, Governances, Concepts, ACED, Quill, cyberlegion, cyberfleet, Disciplines,
universal-plugin, plus a standalone Glossary). Two groups nest one level deeper — Agent
Configuration's *Instructions*, and Concepts' *Skills*.

The IA is **two-tier by design**: the sidebar covers the docs, while the Marketplace and Tavern
destinations are reached only from the top nav in
[`../../components/site-title/`](../../components/site-title/README.md). Their content pages are
therefore correctly absent here, not missing.

Its testable surface is the **correspondence between the declared tree and the corpus**: every slug
resolves to a page, every page is either reachable or deliberately top-nav-only, and group nesting
stays within the depth Starlight renders.

**Non-goals** — the pages themselves ([`../../content/`](../../content/README.md)) and the rest of
the Astro configuration ([`../site-config/`](../site-config/README.md)).

## Use Cases

*To be authored in explore.* Entry points to name:

- the sidebar renders for a route inside a declared group
- a group nests a sub-group one level deeper
- a page exists in the corpus with no sidebar entry (deliberate, or a defect)
- a sidebar entry names a slug with no page behind it

## Control Flow

*To be authored in explore — drawn from the `sidebar` array in `astro.config.mjs`, reconciled against
`src/content/docs/**`.*

## Scenario map

*To be authored in explore.*

| Edge | Path (Given) | Scenario |
|---|---|---|
