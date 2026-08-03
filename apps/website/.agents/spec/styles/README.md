---
spec-type: behavioral
concept: [theming]
---

# styles — the visual theme

> **Stub.** `## Use Cases` is named, not authored. No `.feature` yet.

## What

`src/styles/global.css` defines the site's whole visual identity: a Linear-inspired design-token set
covering accent, grays, backgrounds, hairlines, shadows, and typography (Inter Variable), in **both**
a dark default and a light override keyed on `:root[data-theme='light']`.

It also fixes the **cascade order** — an explicit `@layer base, starlight, theme, components,
utilities` — so Starlight's own styles, Tailwind's theme, and this file's component polish land in a
predictable order rather than fighting on specificity. Tailwind arrives through
`@astrojs/starlight-tailwind` plus Tailwind's theme and utility layers.

Its testable surface is **token parity** (every token defined in dark has a light counterpart), the
layer order holding, and the tokens other nodes consume staying present — `mermaid/` reads
`--sl-color-accent`, `--sl-color-accent-low`, and `--sl-color-text` at runtime, so removing or
renaming one silently degrades diagrams to their fallbacks.

**Non-goals** — per-component markup and behavior (each `components/` leaf) and Starlight's own
default stylesheet, which this file overrides rather than owns.

## Use Cases

*To be authored in explore.* Entry points to name:

- the site renders in dark (the default)
- the reader toggles to light
- a consumer node reads a token at runtime (the contract `mermaid/` depends on)
- Tailwind utilities and Starlight defaults apply to the same element (layer order decides)

## Control Flow

*To be authored in explore — drawn from `src/styles/global.css` (144 lines). A stylesheet's "control
flow" is its cascade: draw the layer order and the theme-selector fork.*

## Scenario map

*To be authored in explore.*

| Edge | Path (Given) | Scenario |
|---|---|---|
