# decisions — the ADR log

Append-only, descriptive, **ungated** record of decisions made about the `website` project and the
reasoning behind each. The project-scope sibling of a unit's `<unit>.solution.md`.

Empty at scaffold.

One file per decision, named `NNNN-short-slug.md`. Each states the context, the decision, the
alternatives weighed, and the consequences accepted. Append; do not rewrite history — a decision that
is later reversed gets a **new** entry that supersedes the old one, and the old entry stays.

**Do not organize a node as an ADR body.** An ADR records *why* a choice was made; the contract it
produced belongs in the node it governs.

Decisions this project has already made, worth writing up when someone has the context:

- why the sidebar is hand-declared in `astro.config.mjs` rather than derived from the file tree
- why this spec declares **mirror-source** over a layer-organized `src/`, and what would trigger the
  move to capability-first
- why the corpus is one behavioral leaf rather than a node per documentation section
