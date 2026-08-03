# tooling — configuration, build, and packaging

Descriptive index. The **tooling/project home** the spec envelope requires: build, packaging, deps,
and the configuration that is not part of `src/`.

Under mirror-source the source tree supplies `content/`, `components/`, and `styles/`; everything
outside `src/` lands here. `astro.config.mjs` is one file but carries **two genuinely different
testable surfaces**, so it mirrors to the unit boundary as two leaves:

| Node | Surface |
|---|---|
| [`site-config/`](./site-config/README.md) | integrations, base path, Vite/Tailwind wiring, the build |
| [`navigation/`](./navigation/README.md) | the hand-declared sidebar tree |

Also homed here (fold into `site-config/` unless one earns its own leaf): `package.json` scripts and
dependencies, `tsconfig.json`, and `public/` static assets (the favicons).

Splitting one config file across two nodes is a visible seam, and it is the accepted cost of
mirror-source over a layer-organized source — see the cost statement in
[`../spec.md`](../spec.md#the-cost-of-mirror-source-here--declared-not-hidden).
