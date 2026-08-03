---
spec-type: behavioral
concept: [marketplace]
---

# tavern-storefront — browse the crew storefront

> **Stub.** `## Use Cases` is named, not authored. No `.feature` yet.

## What

`TavernStorefront.astro` presents every cataloged **crew** as a card. It reads the catalog at build
time via `readCrewPlugins()` from `cyberplace/tavern` and renders, per crew: the name, a `crew`
badge, counts of what it contains (skills, agents, commands), the description, tags, the recruit
command (`cyberplace add <name>`), and a source link.

Its testable surface is the card's composition — which chips appear for which counts, how the counts
pluralize, and what shows when no crews are cataloged.

**Non-goals** — searching or filtering (the storefront presents; the marketplace filters, see
[`../marketplace-search/`](../marketplace-search/README.md)) and the catalog's contents, which belong
to the `cyberplace` package spec.

## Use Cases

*To be authored in explore.* Entry points to name:

- the page renders the crew list
- a crew has zero of one contained kind (its chip is suppressed)
- a crew has exactly one of a kind (singular vs plural wording)
- the page renders with an empty catalog

## Control Flow

*To be authored in explore — drawn from `src/components/TavernStorefront.astro` (144 lines; note
`countChips` is the only branching logic).*

## Scenario map

*To be authored in explore.*

| Edge | Path (Given) | Scenario |
|---|---|---|
