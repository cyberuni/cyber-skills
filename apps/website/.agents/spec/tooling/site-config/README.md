---
spec-type: behavioral
concept: [build]
---

# site-config — Astro/Starlight configuration, base path, and build

> **Stub.** `## Use Cases` is named, not authored. No `.feature` yet.

## What

Everything in `astro.config.mjs` except the sidebar: the deployment identity (`site:
https://cyberuni.github.io`, `base: /cyberplace/`), the Starlight integration (title, description,
social links, custom CSS, the `SiteTitle` component override), and the Vite layer (the Tailwind
plugin, and file-watch polling for the dev server).

The **base path** is the load-bearing part. GitHub Pages serves the site from a subdirectory, so
every internal URL must be built relative to `import.meta.env.BASE_URL` rather than to `/`. Getting
it wrong produces links that work in dev and 404 in production — a failure no page-level test catches
if the build is not exercised under the real base.

Its testable surface is that the build produces a site correct **under the base path**, and that the
declared component override and custom CSS are actually applied.

**Non-goals** — the sidebar tree ([`../navigation/`](../navigation/README.md)) and the content of the
stylesheet ([`../../styles/`](../../styles/README.md)).

## Use Cases

*To be authored in explore.* Entry points to name:

- `pnpm build` produces `dist/`
- `pnpm dev` serves locally (base path applies here too)
- `pnpm typecheck` (`astro check`) validates the project
- a page or component constructs an internal URL from the base path

## Control Flow

*To be authored in explore — drawn from `astro.config.mjs` and `package.json` scripts.*

## Scenario map

*To be authored in explore.*

| Edge | Path (Given) | Scenario |
|---|---|---|
