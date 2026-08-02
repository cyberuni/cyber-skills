---
spec-type: behavioral
concept: [docs, theming]
---

# mermaid — render diagrams in docs pages

> **Stub.** `## Use Cases` is named, not authored. No `.feature` yet.

## What

`Mermaid.astro` turns a text diagram definition into a rendered picture in the browser, with an
optional caption. It takes `code` (the diagram text) and `caption`, emits a `<figure>` holding the
source, and a client script renders it with the `mermaid` library.

Its distinguishing behavior is **theme integration**: rather than using Mermaid's built-in themes, it
reads Starlight's live CSS custom properties (`--sl-color-accent`, `--sl-color-text`, …) and builds
Mermaid theme variables from them, so a diagram tracks both the light/dark toggle and the site's
accent color. Because Mermaid's color engine cannot parse every CSS color format, each token is
normalized to `rgb()` by resolving it through the browser, with a fallback per token.

Its testable surface is that normalization and fallback path, and re-rendering on a theme change.

**Non-goals** — the correctness of any particular diagram (that is the page's, in
[`../../content/`](../../content/README.md)), and the site's color tokens themselves
([`../../styles/`](../../styles/README.md)).

## Use Cases

*To be authored in explore.* Entry points to name:

- a page embeds a diagram, with and without a caption
- a token resolves to a format Mermaid cannot parse (fallback taken)
- a token is absent or empty (fallback taken)
- the reader toggles light/dark after the diagram has rendered

## Control Flow

*To be authored in explore — drawn from `src/components/Mermaid.astro` (171 lines; `resolveColor` and
`themeVariables` carry the branching).*

## Scenario map

*To be authored in explore.*

| Edge | Path (Given) | Scenario |
|---|---|---|
