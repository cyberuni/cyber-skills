# agent-configuration — the instruction-writing section

Descriptive grouping. Mirrors `src/content/docs/agent-configuration/`. **One page, one behavioral
node** — each document carries its own spec stating its north star, required coverage, and the reader
questions it must route.

| Page | Node | Role |
|---|---|---|
| `overview.md` | *not yet specified* | **entry page** (hub) — what agent configuration is; tables of instruction topics and settings topics |
| `instruction-purpose.md` | *not yet specified* | axis page — what a block of instruction is *for* |
| `instruction-target.md` | [`instruction-target/`](./instruction-target/README.md) | axis page — which of the agent's outputs an instruction governs |

The section teaches instruction writing along two axes, **Purpose** and **Target**, with the overview
routing to both. A page earns a node when its contract is worth freezing; the two unspecified pages
stand in the root spec's backfill gap.

## Section-level findings (unowned — no node covers these)

Two defects surfaced while specifying `instruction-target`. Both are **cross-page** properties, so no
single page's contract catches them, and this grouping owns no suite. They are recorded here so they
are not lost:

1. **`overview.md` never links the Target page.** Its instruction-topics table links Purpose and
   covers five further topics inline; it predates Target existing. The sidebar is currently the only
   route to Target from within the site, so the section hub does not reach one of its own axis pages.
2. **`overview.md` links `../instructions.md`, which does not exist** — a broken link, and the
   section's only relative-path internal link (every other one uses absolute route form).

Whoever specifies `overview.md` should cover both: reachability of every axis page from the hub is
properly the **hub's** contract, since the hub is the page that owns the topic tables.
