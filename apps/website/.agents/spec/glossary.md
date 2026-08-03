# Glossary — website

The project's ubiquitous language. Every load-bearing term is defined **once**, here, in plain
words. Seeded by the scaffold with the terms the spec already commits to; per-unit explore adds the
rest as nodes are authored.

## Site structure

**page** — one document the site publishes, at one URL. Every page comes from one Markdown or MDX
file under `src/content/docs`.

**section** — a top-level folder of pages under `src/content/docs` (`sdd/`, `concepts/`, `aced/`, …).
A section groups related pages; it is a folder convention, not an Astro concept.

**slug** — the URL path a page is reached at, derived from its file path relative to
`src/content/docs` (so `src/content/docs/sdd/overview.md` is served at `/sdd/overview`).

**content collection** — Astro's typed directory of content files. This site has one, `docs`, which
Starlight owns.

**sidebar** — the navigation tree shown beside every page. It is declared **by hand** in
`astro.config.mjs` and does not automatically follow the file tree, so a new page is invisible until
it is added there.

**top nav** — the horizontal navigation in the site header (Docs / Marketplace / Tavern), rendered by
the `SiteTitle` component. It is the **outer** tier of navigation, and the only route to the
Marketplace and Tavern pages.

**two-tier navigation** — this site's information architecture: the **top nav** moves between
destinations, the **sidebar** moves within the docs. A page missing from the sidebar is not
necessarily unreachable.

**base path** — the URL prefix the whole site is served under: `/cyberplace/`. GitHub Pages hosts the
site in a subdirectory rather than at a domain root, so every internal link must account for it.

## The stack

**Astro** — the web framework that builds the site. It renders to static HTML at build time; no
server runs in production.

**Starlight** — the documentation theme built on Astro. It supplies the page layout, sidebar, search,
and light/dark theming that this site configures rather than writes.

**component** — a reusable `.astro` file under `src/components`. Two kinds appear here: **theme
overrides**, which replace a Starlight built-in (`SiteTitle`), and **content components**, which a
docs page embeds directly (`MarketplaceSearch`, `TavernStorefront`, `Mermaid`).

**Tailwind** — the utility-based styling system. It is wired in through a Vite plugin and a Starlight
Tailwind bridge, so Tailwind classes and Starlight's own theme tokens coexist.

**Mermaid** — the text-to-diagram library. A docs page writes a diagram as text in a code fence, and
it renders as a picture in the browser.

## Publishing

**build** — the step that turns source into the static `dist/` directory (`pnpm build`, i.e.
`astro build`).

**deploy** — copying that built `dist/` to GitHub Pages. Nothing from this project is published to
npm; the package is marked `private`.

## Spec vocabulary

**node** — one folder in this spec tree. Three kinds: **behavioral** (owns a `.feature`),
**reference** (a real thing with no testable surface), **descriptive** (prose and indexes).

**stub** — a behavioral node scaffolded with its sections named but not authored. Every node in this
spec is currently a stub.

**mirror-source** — the layout strategy this spec declares: spec nodes track the source tree. See the
placement map in [`spec.md`](./spec.md), including the cost this choice carries.
