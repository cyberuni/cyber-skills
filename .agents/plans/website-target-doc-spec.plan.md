---
cr-ref: website-target-doc-spec
project-spec: apps/website/.agents/spec
status: in-progress
todos:
  - content: Settle docs-corpus granularity — content/ as one leaf vs a per-section node
    status: completed
  - content: Place + classify the node; declare spec-type and concept tag
    status: completed
  - content: Author spec.md — What / Use Cases / Control Flow / Scenario map
    status: completed
  - content: Author the .feature — boolean scenarios, quill static-inspection
    status: completed
  - content: Spec gate — cold spec-judge, freeze, ledger gate line
    status: pending
  - content: Handoff — Warden placement pass, commit, follow-up drain
    status: pending
---

# CR: spec the Target article

Add a spec node covering the **Target** concept article at
`apps/website/src/content/docs/agent-configuration/instruction-target.md`.

Source: a bare prompt (no forge issue) — no closing reference at handoff.

## Context

The website project spec was backfilled immediately before this CR (`status: draft`,
strategy **mirror-source**, 8 stub behavioral nodes). Nothing in it is frozen; there is no
`.feature` anywhere in the project yet.

Squad resolves to **quill** by artifact-type `documentation` (classified by convention —
`resolve-governances` found no tiebreaker entry):

| Role | Agent |
|---|---|
| spec-producer | `quill-spec-writer` |
| spec-judge | `sdd-spec-judge` (SDD default — quill declares none) |
| impl-producer | `quill-doc-writer` |
| impl-judge | `quill-judge` |

## The granularity fork (todo 1)

The committed placement map says `content/` is **one behavioral leaf owning all of
`src/content/docs/**`**, and states "do **not** create a node per doc section". Under
mirror-source the same conclusion follows from "create no node below a behavioral leaf".

So a node for one article contradicts the declared layout unless the layout changes with it.
Three candidate resolutions, to settle in the grill:

1. **Author `content/` itself**, using the Target article as the driving case. Honors the layout;
   one node must then carry a contract covering 76 heterogeneous pages.
2. **Demote `content/` to a descriptive grouping**, promote sections to the behavioral leaves
   (`content/agent-configuration/` covering overview + instruction-purpose + instruction-target).
   Legal at two levels; amends the placement map and the declared backfill gap.
3. **A node per page** (`content/instruction-target/`). Finest grain; implies ~76 eventual nodes
   and contradicts the layout most directly.

The backfill gap already anticipates this: "Splitting them into per-section nodes is a future
change request, to be opened when the corpus contract earns the granularity." This CR is the
occasion to decide whether it has.

## Known risks

- **The target file has uncommitted in-flight edits** — a structural reorganization (the
  three-targets table moved below a new "Specifying a target" section, plus a new "Artifact: the
  only target with a path" section). Four commits in the last stretch touch this file. Specifying
  behavior rather than transcribing prose keeps the spec stable across that churn, but the
  `.feature` should not be frozen against a document still being restructured.
- **Cold-judge dispatch needs the user's say-so.** Not a capability limit: the conductor session
  carries a standing instruction not to spawn subagents unless the user asks for it. Grader
  independence at the spec gate requires a cold judge (ADR-0016), so the gate waits on that
  authorization. Explore proceeds regardless.

## Settled (explore)

- **Granularity:** section-level nodes, mirroring **every** source path segment —
  `content/docs/<section>/`. `content/` and `content/docs/` are descriptive groupings; the section is
  the behavioral leaf. Chosen by the user over the two-level-cap alternative.
- **Depth departure declared** in the root `spec.md` (`### Depth: this project mirrors past two
  levels`). Not linted — `check-spec-structure` enforces no depth rule (breadth-vs-depth is Warden
  judgment) — so a formation Warden pass may contest it; that section is the standing answer.
- **Node authored:** `content/docs/agent-configuration/` — `spec-type: behavioral`,
  `concept: [docs, navigation]`, 3 use-case groups, CFG drawn from source, 8 boolean scenarios,
  scenario map 1:1. All six `check:spec` checks green; root `pnpm verify` 35/35.

## Findings the spec surfaced (not yet fixed — deliberately)

Two real defects in the section, now specified rather than silently carried. Both are **impl** work
against the contract, so they belong to deliver, not to explore:

1. **`overview.md` never links the Target page.** Its instruction-topics table lists Purpose (linked)
   plus five inline topics, and predates Target existing — so the section's only route to Target is
   the sidebar. Scenario: `every axis page is reachable from the hub` (edge `B:no`).
2. **`overview.md` links `../instructions.md`, which does not exist.** It is also the section's only
   relative-path internal link; every other one uses route form. Scenarios: `a relative link whose
   target is missing is broken` (`D:no → E:no`) and `a relative link is flagged even when its target
   exists` (`D:no → E:yes`).

## NEXT

Spec gate (todo 5). **Blocked on authorization**, not on work: the gate needs a cold `sdd-spec-judge`
for grader independence (ADR-0016), and the conductor session may not spawn subagents unless the user
asks. Nothing is frozen and `status` stays `draft` until it runs.

Also unresolved before freezing: the target article had **uncommitted structural edits** during
explore. The contract was written at behavior level to survive that churn, but confirm the article
has settled before the gate freezes the suite.
