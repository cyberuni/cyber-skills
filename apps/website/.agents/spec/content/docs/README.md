# docs — the documentation collection

Descriptive grouping. Mirrors `src/content/docs/`, the Starlight content collection: 76 authored
pages across 16 sections, plus two root pages.

**One section, one behavioral node.** A section folder under `src/content/docs/` becomes a
behavioral leaf here, owning that section's pages and their reader paths. Sections earn a node one at
a time, as their contract becomes worth freezing — not all at once.

| Section | Node | Pages |
|---|---|---|
| `agent-configuration/` | [`agent-configuration/`](./agent-configuration/README.md) | 3 |
| the other 15 sections | *not yet specified* — see the backfill gap in [`../../spec.md`](../../spec.md) | 73 |

**What a section node owns:** reachability within the section and the integrity of its internal
cross-references. **What it does not:** prose quality (the author's), frontmatter and routing
(`tooling/site-config/`), and sidebar placement (`tooling/navigation/`).

Corpus-wide properties that hold across *every* section — a link-checking convention, a frontmatter
rule — are **rules**, so they belong in [`../../design/`](../../design/README.md), with each
section's node carrying the scenarios that enact them.
