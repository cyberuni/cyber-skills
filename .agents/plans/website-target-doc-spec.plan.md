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

- **Granularity: one page, one node** — `content/docs/<section>/<page>/`. `content/`,
  `content/docs/`, and each section folder are descriptive groupings; the **page** is the behavioral
  leaf. *(Corrected mid-mission: a first pass specified the section's navigation. The user's intent
  is a per-document content contract — north star, required coverage, reader routing — which is
  quill's own model. The section-level `.feature` was removed.)*
- **A page node freezes** what the document must land: its north star, its required coverage, and the
  reader questions it must route. It freezes neither section order nor wording.
- **Depth departure declared** in the root `spec.md` (`### Depth: this project mirrors past two
  levels`) — now **four** levels. Not linted — `check-spec-structure` enforces no depth rule
  (breadth-vs-depth is Warden judgment) — so a formation Warden pass may contest it; that section is
  the standing answer. The argument strengthened under per-page nodes: a page is the finest *true*
  unit of change in a corpus, so node↔unit alignment is sharper than the cap would give.
- **Node authored:** `content/docs/agent-configuration/instruction-target/` —
  `spec-type: behavioral`, `concept: [docs, composition]`, 14 required-coverage topics (T1–T14),
  **two audiences**, 5 use-cases, reader-decision CFG, 19 boolean scenarios, scenario map 1:1. All
  six `check:spec` checks green; root `pnpm verify` 35/35.
- **The article's reason to exist is composition.** Target is the seam config splits on: an author
  separates config into single-target units; a user combines them freely, because contradictory
  values coexist when they govern different outputs. Same thesis as the sibling Purpose article
  (separate cleanly to compose freely) — Purpose splits by *what a block is for*, Target by *who
  reads it*.
- **Two audiences named, and the CFG branches on them first:** `agent config author` (splitting —
  use-cases A1–A3) and `agent config user` (combining — C1–C2).

## Conforms to quill-builder-spec

The spec was brought up to the Quill Builder bar (`quill:quill-builder-spec`, added in a sibling CR)
after that bar was defined. All seven required `## What` elements present and verified: audience
table, **doc type (explanation)**, north star + failure mode, why it exists, key points, non-goals
**with forwarding addresses**, **prerequisites**. Added by that pass: the doc-type declaration (with
the decay warning that this article's likely failure is drifting toward reference as harnesses
accumulate), the prerequisites element (only the section entry page; Purpose is complementary, not
prerequisite), and a 20th scenario asserting self-containment as a convergence shape.

## The contract does not yet hold — 4 of 20 scenarios fail

Measured against the live article, not assumed. The **entire config-user audience is unserved**:
`compose` occurs once in the whole document (a link label), and `reusable`, `independently`,
`install`, `combine` occur zero times. Same-target conflict is never discussed.

| Scenario | Group | Why it fails |
|---|---|---|
| `the article names separation by target as the seam that splits config` | A1 | the article scopes instructions but never says separation makes units **reusable independently** — it stops at "reach nothing else" |
| `the article addresses the user combining units, not only the author writing them` | C1 | written author-first throughout; no guidance for someone enabling existing config |
| `two units on different targets are shown coexisting` | C1 | the targets table names `article-writer-voice` and `i-have-adhd` separately, but never pairs them as simultaneously in force |
| `two units on the same target are named a real conflict` | C1 | the coexistence claim has no stated boundary — same-target contradiction is not addressed |

These are **impl** work (revise the article), owed to deliver, not explore. They are the payoff of
specifying: the gap was invisible while reading the article, because what is missing is an audience,
not a sentence.

## Findings parked (unowned — no node covers them)

Two real defects surfaced while specifying. Both are **cross-page**, so no single page's contract
catches them; they are recorded in the section grouping README until `overview` is specified, since
the hub is the page that owns the relationship:

1. **`overview.md` never links the Target page.** Its instruction-topics table lists Purpose (linked)
   plus five inline topics, and predates Target existing — so the sidebar is the only in-site route
   to Target.
2. **`overview.md` links `../instructions.md`, which does not exist.** It is also the section's only
   relative-path internal link; every other one uses route form.

## NEXT

Spec gate (todo 5). **Blocked on authorization**, not on work: the gate needs a cold `sdd-spec-judge`
for grader independence (ADR-0016), and the conductor session may not spawn subagents unless the user
asks. Nothing is frozen and `status` stays `draft` until it runs.

Also unresolved before freezing: the target article had **uncommitted structural edits** during
explore. The contract was written at behavior level to survive that churn, but confirm the article
has settled before the gate freezes the suite.
