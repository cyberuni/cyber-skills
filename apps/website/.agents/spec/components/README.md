# components — the interactive surfaces

Descriptive index. Mirrors `src/components/`, one behavioral leaf per `.astro` component.

The components divide into two kinds, and the distinction matters when placing a new one:

| Kind | What it is | Members |
|---|---|---|
| **theme override** | replaces a Starlight built-in, wired through the `components` map in `astro.config.mjs` | [`site-title/`](./site-title/README.md) |
| **content component** | embedded directly by a docs page | [`marketplace-search/`](./marketplace-search/README.md), [`tavern-storefront/`](./tavern-storefront/README.md), [`mermaid/`](./mermaid/README.md) |

A new component gets its **own leaf** here — never a sub-folder under an existing one, which would
breach the two-level cap.

Three of the four read data at **build time** and ship the result as static HTML plus a small client
script; none of them calls a server at runtime, because the site is fully static.
