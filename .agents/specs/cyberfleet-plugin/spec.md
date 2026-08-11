---
status: implemented
project-path: plugins/cyberfleet
approval:
  spec:
    verdict: approve
    by: agent
    cause: dimension
    why:
      floor: none
      blast: low — one persona skill (plugins/cyberfleet/skills/operator/) plus its spec node. No CLI, no sibling package, no other persona touched. The mechanism it binds to is already shipped and specified in the sibling cyberlegion project.
      novelty: low — the capability adds no mechanism. standing owners, `unit claim` presence, and the durable-vs-best-effort doorbell all already exist and are frozen in packages/cyberlegion/.agents/spec; this CR only binds Operator's decisions OVER them (which verb, unconditional or not, fail-soft or fail-loud, when to ack).
      confidence: high — three cold ACED spec-judge rounds, converging: R1 ALIGNED false (builder + architect), R2 ALIGNED false (builder), R3 ALIGNED true on all three lenses with no blocker. Every mechanism claim independently verified against packages/cyberlegion/src/identity.ts and src/console/doorbell.ts by the judge, not taken from the producer. Edit class `addOnly` (12 added / 0 modified / 0 removed) so no frozen scenario was narrowed — Clearance never fired. All six `check:spec` checks green; root `pnpm verify` 29/29.
      leash: auto-all — user-set in-session. Self-asserted under leash; no hard floor engaged.
      cr: operator-bunker-call-in
  impl:
    verdict: approve
    by: agent
    cause: dimension
    why:
      floor: none
      blast: low — two documentation files (plugins/cyberfleet/skills/operator/SKILL.md + README.md). No code, no CLI, no other persona.
      novelty: low — the body binds Operator's decisions over mechanisms that already ship; it introduces no new mechanic.
      confidence: high — cold ACED impl-judge IMPLEMENTATION_PASS true, blocker null, over ALL 41 frozen scenarios (12 CR-added + 29 pre-existing), each run as a blind two-pass case-judge whose simulating context never saw the .feature, the Then, or the rubric. No neighbour regression: seat 3/3, @trigger outline 9/9 rows (accuracy 1.0), spawn 3/3, lifecycle loop 8/8, merge backstop 7/7. Voice unregressed (@quality PASS; @rubric 9/9 vs threshold 7) despite the new block being the longest in Decisions. Root `pnpm verify` 29/29. One CR-introduced cross-file contradiction the judge surfaced — the skill README had collapsed the fail-soft no-multiplexer guard and the fail-loud missing-owner guard into one clause — was fixed after the verdict; it touched README only, not SKILL.md (the judged subject), so no scenario verdict rests on the edit. Five further contradictions (four pre-existing, one cross-plugin) were recorded as follow-ups rather than folded in.
      leash: auto-all — user-set in-session. Self-asserted under leash; no hard floor engaged.
      cr: operator-bunker-call-in
---

# cyberfleet-plugin — the fleet & crew personas (agent behavior)

> Root project spec — the **descriptive** top index for the `cyberfleet` **plugin** (the marketplace
> distribution at `plugins/cyberfleet`). Behaviors live in the capability folders below. This
> project was split out of the combined `cyberfleet` project by the `split-cyberfleet-spec` change,
> so the spec maps one-to-one onto the plugin. The deterministic engine — the `cyberfleet` CLI —
> lives in the sibling `cyberfleet` project (`../../packages/cyberfleet/.agents/spec`, source
> `packages/cyberfleet`).

## What this is

The `cyberfleet` plugin ships the **persona layer** of the fleet: the agent-behavior that decides
*when* and *how* an agent reaches for the fleet, recruits or discharges a crew, and builds or
re-tunes an automaton. Every node here is a per-situation persona gateway skill (ACED carries all four
eval layers — activation and judgment). Each persona offloads its mechanics to a CLI — `cyberlegion`
for identity, mail, and spawn; `cyberfleet` for missions — and keeps its voice only in what it says
around them. Where a mechanic belongs to neither (the merge backstop's `gh`/git/CI), it is offloaded
to that tool, never re-implemented.

The persona nodes depend on their CLIs by **intent** — register / send / spawn / inbox (the
`cyberlegion` CLI) and the missions view (the `cyberfleet` CLI) for the fleet personas, and the
Tavern query / define-agent / manage-model-runners for the crew personas — never by an exact command
slug (ADR-0021). The dependency is one-way: neither CLI knows anything of these personas.

## Why this is its own project

The `cyberfleet` plugin and the `cyberfleet` CLI are **two packages that deploy differently** — the
plugin ships to the marketplace, the CLI ships to npm — and the plugin carries genuine agentic
behavior (spawn judgment, message etiquette, persona voice, crew recruitment/tuning) the CLI cannot.
Three axes agree on the same cut: artifact-type (agent-behavior vs deterministic script), deploy
target (marketplace vs npm), and package (`plugins/cyberfleet` vs `packages/cyberfleet`). This
project holds the four agent-behavior nodes; the four deterministic CLI nodes are the sibling
`cyberfleet` project. The plugin spec stays **central** (`.agents/specs/`) rather than co-located
under `plugins/cyberfleet` so it is not carried inside the distributed marketplace artifact.

## Capability map

| Folder | Type | What |
|---|---|---|
| [`pod/`](./pod/README.md) | behavioral | the **Pod** persona — the ship's bridge: greet, clear inbox, run the mission, hail crew, HAL tell; no precondition, no probe; never spawns |
| [`operator/`](./operator/README.md) | behavioral | the **Operator** persona — the command-center dispatcher: any spawn, list the fleet, route messages, prune dead ships |
| [`recruitment/`](./recruitment/README.md) | behavioral | the **Crimp** persona — recruit/discharge crew types from the Tavern (browse, install, register; uninstall, retire) |
| [`mechanic/`](./mechanic/README.md) | behavioral | the **Mechanic** persona — build a new automaton or adjust an existing one's program (governance/model/effort/leash), re-chip its loadout, hot-swap the unit |

## Placement map

Where a new concept lives — slot here, do not invent placement:

- **a new bridge behavior** (mission entry, inbox etiquette, hailing crew, the HAL tell — anything
  Pod does while working a ship) → `pod/` (the Pod persona).
- **a new fleet-level dispatch behavior** (**any** spawn, list the fleet, route between ships, prune
  — anything the Council calls Operator for) → `operator/` (the Operator persona).
- **a "which persona am I" concern** → **nowhere — there is no such concern.** Neither persona probes
  its folder. Operator's seat is asserted by invocation; Pod is reached by the Council's ask. The ship
  marker and `cyberfleet mode` were deleted (#225) because the marker gated no capability and its only
  reader was the command that reported it. Do not reintroduce a location check in either node.
- **a new crew-acquisition persona behavior** (recruit/discharge a crew type — browse the Tavern,
  install/register, uninstall/retire) → `recruitment/` (the Crimp persona).
- **a new automaton-workshop persona behavior** (build a new automaton, or adjust an existing one's
  program — governance/model/effort/leash — re-chip its loadout, hot-swap the unit) → `mechanic/`
  (the Mechanic persona).
- **a new identity / message-queue / peer-launch / hook-injection CLI operation** → **not here** —
  that is the `cyberlegion` CLI project (`packages/cyberlegion`). A new mission-view / gate CLI
  operation is the `cyberfleet` CLI project (`packages/cyberfleet`).
- **a cross-capability persona e2e** (spans ≥2 persona nodes) → this project's own e2e; a future
  `acceptance/` node may formalize it.

The nesting rule: capabilities at the top; any layering nests *inside* a capability, never as a
top-level folder. A node is `<capability>` and never nested. Two cross-cutting concerns run through
this project (see the by-concept index below): `fleet` (the session-coordination personas — pod and
operator) and `crew-ops` (the crew-operations personas that recruit and tune **crew** — recruitment (Crimp)
and build+tune (Mechanic)). Note the distinction: a **crew** is a recruited specialist automaton (what
Crimp signs on from the Tavern); `crew-ops` is the concern of *operating on* crew, not the crew
itself.

<!-- BEGIN generated: by-concept (project-spec/concept-index) -->

## By concept

> Generated from `concept:` frontmatter by `project-spec/concept-index` — do not edit by hand.

| Concept | Facets |
|---|---|
| `crew-ops` | `mechanic/` (behavior) · `recruitment/` (behavior) |
| `fleet` | `operator/` (behavior) · `pod/` (behavior) |

<!-- END generated: by-concept -->
