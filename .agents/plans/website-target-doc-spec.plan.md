---
cr-ref: website-target-doc-spec
project-spec: apps/website/.agents/spec
status: implemented
todos:
  - content: Settle docs-corpus granularity — content/ as one leaf vs a per-section node
    status: completed
  - content: Place + classify the node; declare spec-type and concept tag
    status: completed
  - content: Author spec.md — What / Use Cases / Control Flow / Scenario map
    status: completed
  - content: Author the .feature — boolean scenarios, quill static-inspection
    status: completed
  - content: Strike the unsupported quantifier clause from the suite before the gate freezes it
    status: completed
  - content: Spec gate — cold spec-judge, freeze, ledger gate line
    status: completed
  - content: Handoff — Warden placement pass, commit, follow-up drain
    status: completed
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

## The contract now holds — the 4 gaps are closed

The spec found 4 failures against the live article; all four were the composition payoff, and three
of them were the **config-user audience being entirely unserved** (`compose` occurred once in the
whole document, as a link label). Closed in deliver by revising the article:

| Scenario | Group | Fix |
|---|---|---|
| `the article names separation by target as the seam that splits config` | A1 | new `## Composing configuration` states that a mixed-target skill *has to be adopted whole*, and that split by target *each half can be adopted on its own* — the reuse claim the article previously stopped short of |
| `the article addresses the user combining units, not only the author writing them` | C1 | same section splits on *if you **write** it* / *if you **install** it*, giving the installer a decision table keyed on whether two units govern the same target |
| `two units on different targets are shown coexisting` | C1 | names the concrete pair the targets table already carried — `article-writer-voice` (Artifact) and `i-have-adhd` (User) — and states both may be in force at once |
| `two units on the same target are named a real conflict` | C1 | the lead's coexistence claim is now bounded (*two governing the same output are in genuine conflict, and naming the target does not resolve it*), and the decision table carries the same row |

Verified clause-by-clause against the article, not assumed. Written in the repo's
`article-writer-voice` Docs register (declarative, table over paragraph, bold marks vocabulary), and
kept inside the declared doc type: the decision table supports a *decision*, which is what an
explanation owes, rather than becoming a procedure.

## Findings parked (unowned — no node covers them)

Two real defects surfaced while specifying. Both are **cross-page**, so no single page's contract
catches them; they are recorded in the section grouping README until `overview` is specified, since
the hub is the page that owns the relationship:

1. **`overview.md` never links the Target page.** Its instruction-topics table lists Purpose (linked)
   plus five inline topics, and predates Target existing — so the sidebar is the only in-site route
   to Target.
2. **`overview.md` links `../instructions.md`, which does not exist.** It is also the section's only
   relative-path internal link; every other one uses route form.

## Correction: the mixed-target file does not belong to prose matching

Caught by the user, post-`## The contract now holds`. The article routed a **mixed-target file** to
prose matching, and the spec encoded the same error in four places (T10, A1's outcome, CFG node
`K1`, and the `a mixed-target file routes to splitting or prose matching` scenario).

It is wrong because **description matching matches the agent's situation, not the file's path** —
which the article itself states one paragraph earlier ("Description matching reaches what a path
cannot") and then forgets. Writing a TypeScript block inside an MDX page is a recognizable
situation, so a TypeScript convention loads there without any path being involved.

The corrected discriminator, now in the CFG as a decision node rather than a single outcome:
**would splitting copy more than it separates?** No → split into single-target units, each loaded by
description matching. Yes → one file, branched by prose matching (the `article-writer-voice` case:
six shared rules, two registers). File granularity is an argument against the *glob*, never an
argument for prose matching.

Both sides corrected together; `pnpm verify` 35/35. Note this landed **after** the 20/20 inline
check above, so that count no longer describes the current pair — another reason the gate's cold
re-derivation is owed.

## Cold `quill-judge` round — the first live run of the integrity bar

Dispatched cold with the user's authorization; it read no prior verdict. **20/20 scenarios PASS**
with a located passage named for each, and `IMPLEMENTATION_PASS: false` on one integrity `BLOCKER`.

- **BLOCKER (fixed)** — the coexistence/conflict rule landed twice: L8 (`one of them has to win`)
  and the installer decision table (`a real conflict — one has to win`), the second re-narrating
  rather than referring back. This is the **third** recurrence of that claim duplicating; `00887022`
  removed an earlier one. Fixed by anaphora — the section now applies *the rule from the opening* and
  the table reads as a lookup — since deleting the table would strand scenarios 17 and 18.
- **Second finding (fixed, ranked PLAUSIBLE)** — the Artifact section's trailing clause re-narrated
  the path-cannot-resolve claim from the mechanisms section. Now a back-reference.
- **Two content gaps (fixed)** — `Tone` was relied on at L68 before being glossed; the
  glob-capable → file type matching route existed only as the *complement* of description matching's
  four-case list, so an edit to that list would have silently broken it. Both now affirmative.
- **Architect observation (acted on)** — the suite itself invited the duplication: one scenario binds
  the coexistence claim to the opening while three bind assertions to "the article's treatment of
  coexistence", and nothing forced those to be one passage. The claim is now quantified in the
  contract (`in exactly one place, later passages referring back`), which moves it off the bar and
  into the frozen suite where it belongs.
- **Architect observation (open, not acted on)** — **T11** (the limit of specifying: isolation beats
  scoping) and **T7**'s "the only target that can answer back" are delivered by the article but
  covered by no scenario, so a revision could drop either silently. Adding scenarios is spec work the
  spec gate should judge; left for that gate.

The judge also recorded two rejected term-drift candidates (`carry`, `reach`) with its reasoning, so
the negatives are auditable rather than merely absent.

## CFG errors (three, found by the user)

1. **Use case C2 was unrouted** — `R:combining` led only to `Z` (predicting a clash). Nothing in the
   graph reached "an enabled config is shaping output I did not intend", so the CFG spent 4 of the 5
   enumerated entry points. Caught by the completeness rule added to `quill-builder-spec` this
   session (*the coverage table enumerates, the CFG must spend it*) — its first catch on a real spec.
   Fixed by forking the combining branch: `W{predicting a clash, or diagnosing one?}`, with
   `V{which target does the unit actually govern?}` → drifting / never scoped.
2. **`C1`/`C2` denoted two different things** — CFG nodes (*lead defines* / *lead motivates*) and
   use cases (*predict a clash* / *diagnose over-reach*), with the A1 scenario map referencing
   `B:no → C1` two screens under a `### C1 —` heading meaning the other one. Nodes renamed `L1`/`L2`.
3. **`A` was a decision node with one edge** — *"does the article require prior reading?"* had only a
   `no` branch, and asked about the article rather than about the reader. Now a plain convergence
   node.

Also: the A2 map keyed *"an author comparing the three mechanisms"* to `K` (does one file mix
targets?) rather than `M`, the node where the mechanism is actually chosen.

**Open** — `V1`/`V2` are new outcomes with no scenario. C2 still has a single scenario, so the
diagnose path is routed but only thinly frozen; the spec gate should decide whether it earns its own.

## NEXT — resume here

**Todo 5 is done** — the clause was struck in `ee2666fa`, before this brief was last written.
Verified by search across the whole suite and both quill bars: no recurrence phrasing survives here
in any of its four wordings. **This CR is now decoupled from `quill-writing-quality`** and its gate
can run independently.

**The spec gate (todo 6) is the only remaining work, and it is blocked on authorization, not on
drafting:** it needs a cold `sdd-spec-judge` for grader independence (ADR-0016), and this session may
not spawn subagents unless the user asks. Nothing is frozen and `status` stays `draft` until it runs.

**One thing changed underneath this CR:** the root website spec is now `status: implemented` (written
by `quill-docs-section`, which landed six page nodes under a new `content/docs/quill/` grouping).
This node still sits at `draft`, so this CR moves the root spec off `implemented` when it gates —
expected, but the gate should say so rather than let the status flip silently.

### Blocking decision left for the gate

- **V1/V2 have no scenario.** The diagnose path added to the CFG routes use case C2 but freezes
  nothing. Either add a scenario or accept the path as unenforced — a spec-gate call, not a drafting
  one.

### Findings the commits will not show

- **The cold judge round already ran** (d308d63c reconciles what it found). 20/20 scenarios PASS with
  a located passage named for each; the one `BLOCKER` was an integrity finding, now fixed. Do not
  re-run it as if the article were unjudged — re-run it to confirm the BLOCKER cleared.
- **That judge finding was half a false positive**, and the lesson is load-bearing for this CR: the
  two passages sat on different CFG branches, so a reader arriving at *Composing configuration* from
  the sidebar had never read the lead. The prescribed anaphora fix made the article worse for that
  reader. The article now restates rather than points.
- **T11 and part of T7 are delivered but uncovered** by any scenario — a revision could drop either
  silently. Flagged by the judge as an architect observation.
- **Two cross-page defects remain parked and unowned** (`overview.md` never links Target; it links a
  nonexistent `../instructions.md`). Recorded in the section grouping README until `overview` is
  specified.

### Do not relearn

`## Settled (explore)` holds the granularity decision, the depth departure, and the node's shape.
`## Correction: the mixed-target file does not belong to prose matching` and `## CFG errors` hold
corrections already applied — they are history, not open work.

