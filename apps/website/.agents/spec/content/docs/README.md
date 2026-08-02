# docs — the documentation collection

Descriptive grouping. Mirrors `src/content/docs/`, the Starlight content collection: 76 authored
pages across 16 sections, plus two root pages.

**One page, one behavioral node.** A section folder mirrors to a **descriptive grouping**; each
document inside it becomes a behavioral leaf carrying its own spec. Pages earn a node one at a time,
as their contract becomes worth freezing — not all at once.

| Section | Grouping | Pages specified |
|---|---|---|
| `agent-configuration/` | [`agent-configuration/`](./agent-configuration/README.md) | 1 of 3 — `instruction-target` |
| the other 15 sections | *not yet specified* — see the backfill gap in [`../../spec.md`](../../spec.md) | 0 of 73 |

**What a page node owns:** the document's **north star** (the understanding a reader leaves with),
its **required coverage** (the claims it is incomplete without), and the **reader questions it must
route**. It freezes what the document must land — never its section order or its wording, which stay
the author's.

**What it does not own:** prose quality and voice (judged by review), frontmatter and routing
(`tooling/site-config/`), and sidebar placement (`tooling/navigation/`).

**Cross-page properties** — one page linking another, a hub reaching all of its axis pages — are
**not** any single page's contract. They belong to the page that owns the relationship (a hub owns
reaching its section's pages), or, where they hold across every section, to
[`../../design/`](../../design/README.md) as a rule, with each page's node carrying the scenarios
that enact it.
