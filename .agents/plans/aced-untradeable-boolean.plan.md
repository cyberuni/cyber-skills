---
cr-ref: aced-untradeable-boolean
project: aced
project-path: plugins/aced
status: complete
source: doctrine retro (doctrine-strategy-keep-or-cut.plan.md), CR-7 of the 7-CR KEEP queue
ledger-shard: .agents/specs/aced/ledger/aced-untradeable-boolean.ad573b.jsonl
todos:
  - id: intake
    content: "open CR against aced spec; scaffold plan + leash"
    status: complete
  - id: explore
    content: "resolve-governances; add whole-output entry point to aced-builder-spec Selection bar + additive scenarios on scenario-writer (+ spec-validator judge face); grill w/ cold spec-judge to ALIGNED"
    status: complete
  - id: spec-gate
    content: "spec-judge ALIGNED; additive/self-clearing; self-assert approve by:agent to shard; STOP (no by:name, no status)"
    status: complete
  - id: deliver
    content: "author bar SKILL.md criterion + aced-scenario-writer/aced-spec-validator agent instructions to pass frozen suite; pnpm verify; rebase onto main"
    status: complete
  - id: impl-gate
    content: "cold impl-judge synchronous; every frozen scenario verified; self-assert approve by:agent to shard; STOP"
    status: complete
  - id: handoff
    content: "record followups to shard; report verdict packet up relay; NO PR/merge/ratify"
    status: complete
---

# CR: ACED untradeable-boolean (CR-7)

A **whole-output untradeable** behavior is authored as **one boolean `@quality` scenario**, never as a
`@rubric` dimension. The gate requires every scenario to pass, so the boolean is **strictly stronger**:
a dimension can be zeroed and bought back on unrelated points.

Source: `.agents/specs/sdd/ledger/strategy.2d9bbc.jsonl` seq2, item 2 (residual — item 1 was the frozen-
rubric DocString hole, out of scope). Distilled from `263-op6-m4-persona-voice-dimension`, where the
defect recurred to **fourth order across five judge rounds**. Council KEEP (retro plan, CR-7 row).

## The gap (why the standing bars do not already catch it)

`aced-builder-spec`'s **Selection** bullet already bans an untradeable criterion from the compensatory
sum, but its ACED discriminator is **same-object**: "Fail a dimension **only** when a boolean scenario in
the same suite decides that exact property." In the persona-voice case **no boolean twin existed** — the
author's choice was dimension-vs-author-a-new-boolean, so the same-object test cannot fire and the `only`
actively licenses the defect. The generic substitutability clause mis-routes too: voice is a *graded*
property, and "graded ⇒ `@rubric` dimension" is the reasoning that failed five times. The missing piece is
the **form**: a graded property can be a **boolean `@quality` scenario** — `@quality` names the axis, and
`@rubric` (the assertion form) is orthogonal and optional (`sdd:suite-format-governance`, tag set).

## The rule to codify

When the graded criterion spans **the whole of what the subject produces** (its voice, its verdict, the
artifact as a whole) rather than one attribute among several, it is **untradeable by construction** —
there is no "rest of the output" left to trade against. Author it as **one boolean `@quality` scenario**;
never as a dimension in a `@rubric`.

**Must not reintroduce the #280 twin-scan.** The new test is a property of a **single dimension** (does its
criterion span the whole output?), not a comparison between two dimensions. It is a **second, disjoint**
entry point to Selection, sitting beside same-object — not a replacement for it.

## Target & placement (to confirm in explore)

- **Bar** `plugins/aced/skills/aced-builder-spec/SKILL.md` — Selection gains the whole-output entry point
  and the `only` is re-scoped to same-object. Reference node, no `.feature`.
- **Producer** `.agents/specs/aced/sdd-roles/scenario-writer/` — additive scenario(s): route a whole-output
  graded criterion to a boolean `@quality` scenario.
- **Judge** `.agents/specs/aced/sdd-roles/spec-validator/` — additive scenario(s): a whole-output dimension
  fails selection **with no boolean twin present**; a per-attribute dimension still passes.
  **Scope note for Council:** the brief names two targets (bar + scenario-writer). The judge node is added
  because the corpus pattern for every existing Selection criterion is producer-scenario + judge-scenario,
  and the bar's `only` clause is the actively-licensing text. Flag at the gate; drop on Council's word.

## Harness discipline (this run)

In-session conductor. Every judge dispatched **cold, synchronous, self-observed**; **no verdict relayed**.
Gates self-asserted `by: agent` to the ledger shard, then **STOP** — the Council ratifies (`by: <name>`).
Never write root `status` / `approval` frontmatter. `pnpm verify` before any commit.

## Producer observations routed here (not acted on)

Both `architect`-typed, surfaced by the round-2 cold spec-judge. Recorded, not silently absorbed; neither
grew a scenario in this CR.

1. **The mixed case is resolved only by CFG edge order.** A whole-output criterion authored *alongside*
   per-attribute siblings — the shape the persona-voice defect actually took — is adjudicated by the CFG
   testing the span question **before** the substitutability branch, so whole-output wins. No scenario
   states it. If the deliver-phase bar text is written non-sequentially, this is where the recurrence
   returns. **Carry into deliver as a bar-text ordering constraint**, not a new scenario.
2. **Producer/judge scoping asymmetry.** Producer `B` carries the "no boolean twin" clause in its `Given`;
   judge `D` omits it and reason-scopes its `Then` instead. Both sound, divergence unexplained — it will
   read as an oversight to the impl-producer. **Note it in the deliver brief.**

## Open follow-ups (record at handoff; not this CR's scope)

- **`@quality` is a tagged scenario, and ACED's boolean-form check is scoped to *untagged* scenarios.** This
  CR makes `@quality` the destination form for untradeable criteria, so a `@quality` scenario carrying an
  embedded threshold would clear the boolean-form check. Pre-existing scoping, newly load-bearing. For the
  Strategist — widening it here would exceed the CR.
- **No boundary scenario for whole-output-*sounding* names** ("coherence", "clarity", "overall quality" on a
  multi-attribute artifact). A judge that over-fires only on those passes all four added scenarios. The
  disambiguator — *can you name an attribute of the output the criterion does not touch?* — lands in the
  deliver-phase bar text; a dedicated boundary scenario is a follow-up, not a widening.

## NEXT

**Landed.** Both gates Council-ratified in-session (`by: unional`), impl gate ratified on an explicit
confirmation rather than an inferred acknowledgement. Judges cold, synchronous and self-observed
throughout; no verdict relayed at any point.

Commits on `cyberlegion/unit-bcb2e09a2fba63bc`: spec+suite, deliver, impl-gate record. `pnpm verify`
35/35, `check-spec-structure` no blocking findings, both suites ADDITIVE and self-clearing.

Nothing left in this CR. The three `followup` lines on the ledger shard are **recorded but not
drained** — no issues filed, since outward filing was not authorized. A later drain re-derives what is
outstanding by dedupe against the forge, so the retry is idempotent.
