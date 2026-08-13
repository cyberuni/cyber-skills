---
cr-ref: aced-result-provenance
project: aced
project-path: plugins/aced
status: active
todos:
  - content: "intake: resolve project spec, tracking, scaffold plan"
    status: completed
  - content: "explore: seed intent grill on provenance shape + freshness verdict model"
    status: completed
  - content: "explore: place + classify the freshness node under eval-run/"
    status: completed
  - content: "explore: draft run/ provenance scenarios (additive) + freshness node spec + .feature"
    status: completed
  - content: "explore: grill rounds — caller seam, closed world, self-report trust boundary"
    status: completed
  - content: "spec gate r1: cold spec-judge ALIGNED false (F1 non-binding negative, F2 gloss)"
    status: completed
  - content: "re-author both ## Use Cases against the restored actor-first bar"
    status: completed
  - content: "spec gate r2: remediate F1/F2, re-judge, freeze both suites"
    status: completed
  - content: "spec gate r3-r5: 3 cold judges, 2 nodes, ALIGNED true, both suites FROZEN, approved"
    status: completed
  - content: "deliver: run writes provenance; freshness engine reads it"
    status: in_progress
  - content: "impl gate: cold impl-judge per frozen scenario"
    status: pending
  - content: "handoff: PR, follow-up for the judge-trust CR"
    status: pending
---

# CR: eval-result provenance + freshness

## Why

ACED writes eval results but records nothing about **what it evaluated**. Every downstream
consumer that wants to know "is this result still current?" must therefore guess. PR #467 built
that guess — slug guessing, mtime-as-content-change, and a regex over judge prose — and the design
review found all three trace back to the same missing upstream contract.

Fix the producer: `run` records the evaluated subject file set plus content hashes. Freshness then
becomes a deterministic comparison instead of four stacked heuristics.

## Scope

**In:**

1. `run` records the evaluated subject files and their content hashes in the result record.
2. A freshness check compares recorded hashes against the current tree to decide whether a result
   is safe to present as current.

**Out — each its own CR, all recorded as follow-ups at handoff:**

- **The untrusted-pass / unprovable-assertion problem** — **FILED as #477**. A pass resting on an
  assertion a narrated transcript cannot settle. Belongs to the judge protocol and the suite-authoring bars, not to an
  eval-run reader.
- **Consumer wiring for `run` and `improve`** — **FILED as #476**. Cut from this CR at the owner's scope reduction
  after the spec gate found the citing scenario unbindable. Needs two scenarios whose Givens each
  *name* a verdict, in the shape `only a current verdict exits zero` already uses correctly. Until
  it lands, `check-freshness` is specified and tested but consulted by nobody — a deliberate,
  recorded gap, not an oversight.
- **A verified read set** — **FILED as #475** (durable, so the specs' "recorded follow-up" claim
  outlives this brief). `run`'s self-report cannot be audited by any consumer. Closing it needs
  harness-level tool-call telemetry reconciled against the recorded `evaluated` set, which would
  also answer "did the agent do what it says it did" well beyond freshness.

## Nodes

- `.agents/specs/aced/eval-run/run/` — **revise**. New provenance scenarios are **additive** to a
  frozen suite (nothing narrowed), so they self-clear. **Superseded at the gate:** one of the two
  existing persistence scenarios ("persisted as a timestamped record") named the suite-local results
  directory, contradicting its own sibling and the path check-freshness pins — repaired under an
  owner-granted Clearance, since the wrong destination sat in the Then and no additive repair
  existed.
- `.agents/specs/aced/eval-run/<freshness-node>/` — **new behavioral node**. Placement per the
  project spec's placement map: "a new way to run or report on evals → `eval-run/`". Name settled
  in the grill.

## Prior art

PR #467 (`feat/aced-result-freshness-check`) is the un-gated first attempt. Treat it as a **source
of requirements, not of design** — its subject-file resolution rules and its graceful-degradation
cases are worth keeping; its mtime oracle, slug guessing, and prose heuristic are what this CR
exists to remove. Disposition of that PR is the owner's call.

## Settled in explore

- Recorded set is **what `run` actually read**, shape `{path, sha256}` — not a static rule.
- New node `eval-run/check-freshness/`, per the placement map.
- Verdict is **graded** — `current` / `stale` / `incomplete` / `absent` — naming which inputs moved.
- A changed `.feature` with an unchanged subject is **`incomplete`, not `stale`**.
- **Closed world:** a consumed directory listing is recorded as a hashed entry, so growth is caught
  without re-resolving the subject. The residual is pinned by a positive scenario that fails an
  implementation which re-resolves instead.
- **Trust boundary:** `evaluated` is the run's self-report, not a verified trace. Over-reporting has
  a sound oracle; under-reporting does not, except for the mandatory-input case, which the two
  coherence scenarios catch by cross-checking the record against itself.
- ~~`run/` consults the check before citing a recorded result.~~ **CUT at the spec gate** — the
  citing scenario would not bind. Both `run/` and `improve/` wiring are now follow-ups; until they
  land, `check-freshness` is consulted by nobody.

## RESOLVED — the stale-bar block is cleared (2026-08-13)

The `sdd` plugin now resolves from the **local directory marketplace** (`known_marketplaces.json`:
`cyberplace → source: directory`), not from npm. Verified by content, not install metadata:
`diff -rq ~/.claude/plugins/cache/cyberplace/sdd/0.0.0/skills plugins/sdd/skills` differs only in
`*.test.mts` (not packaged), and the loaded `spec-format-governance` is 182 lines carrying the
actor-first bar. Both bar commits (`92e5df32`, `5dec0d5f`) are ancestors of HEAD; only the
`chore: version packages` bump (npm `cyber-sdd@0.2.0`) is not, and it carries no content. No
reinstall or process restart was needed. The section below is kept as the record of what was owed.

## The debt that was owed — authored against a stale spec-format bar

Explore ran four gate rounds against **outdated governance**. The `sdd` plugin is the only
first-party plugin sourced from npm (`cyber-sdd`) rather than `./plugins/sdd`, so repo edits to
`plugins/sdd/` never reached the session. Six SDD skills were stale: `spec-format-governance`
(79 lines), all three judge lenses (`oracle` 13, `builder` 22, `architect` 25), `spec-producer`,
and `start-mission`.

`.changeset/restore-use-case-definition.md` (`cyber-sdd: minor`, unreleased) carries the current
bar, and scopes itself: *"the restored shape applies to new and revised nodes"*. `check-freshness/`
is new and `eval-run/run/` is revised — **both owe it**. This is not corpus-wide drift to conform
to; it targets exactly these two nodes.

**Format debt on both nodes' `## Use Cases`:**

- Enumerate **actor-first**, never by entry point — list actors (including those affected by the
  outcome without invoking it), then their goals, then map goals to entry points. A goal with no
  entry point and an entry point serving no goal are both findings.
- Each use case carries four parts: **actor / goal** (one line each), **entry point**
  (trigger / inputs / outcome — the current 3-column table is only this part), and **extensions**.
- An extension is *any path from the trigger that does not reach the success outcome*, with cause
  and outcome. Write `extensions: none — <why>` explicitly so the claim is contestable.
- Every surface element traces to a use case that needs it; an untraced one is an orphan.
- **Extensions must become CFG paths.** Scenarios derive from the CFG alone, never from the
  extension list — so this may yield new scenarios. `run.feature` must stay additive.

**Not lost:** all 28 scenarios were verified binding in both directions by an independent cold
judge, coverage is 1:1, `absent` fails safe, and the two boundary statements are correct. The suites
largely survive; the debt is the `## Use Cases` sections and whatever CFG paths extensions surface.

## Use Cases re-authored against the restored bar

Both sections are rebuilt actor-first (actors → goals → entry points), each use case carrying
actor / goal / entry point / extensions, plus a surface trace. `check:spec` is green on
`@cyberplace/aced-plugin`.

**What the actor-first ordering surfaced — and it was not cosmetic:**

- **`check-freshness`: the unserved goal is corroborated in code, not just argued.**
  `plugins/aced/skills/improve/SKILL.md:33` already reads *"run `run` first if the latest `results/`
  file is stale or missing"* — the caller carries the goal in prose with no definition of `stale` to
  consult. The cut consumer wiring is therefore a goal with no way in, belonging to `run` and
  `improve`. Recorded in the spec as such rather than omitted.
- **`run`: UC3's actor never invokes `run`.** Provenance is wanted by `check-freshness` and later
  readers — parties downstream of a run they never made. "Who calls each entry point?" cannot return
  it, which is exactly why the pre-restoration section had it as a bare row with no actor. It is now
  a use case with **no entry point of its own**, served by UC1's persisted outcome.
- **Persistence moved from UC1 to UC3.** The author reads the report; nobody but a downstream reader
  needs the record to exist. The scenario-map regroup fell on contiguous row blocks, so suite order
  is unchanged.
- **`extensions: none` written as a claim, once, and it is the honest one.** `run`'s UC3 has no
  markable divergence: over-reporting is bound by a fixture, under-reporting cannot be a branch
  because the only witness is the self-report under test. Stated as a cost, not an absence.

**No new scenarios.** Every extension enumerated already had a CFG path; nothing dangles and nothing
was drawn from the prose list. `run.feature` stayed additive by not being touched at all.

**One question deferred to the owner (not acted on):** `run/README.md` has no `## What` — its
Subject, Non-goals, trust boundary, and `**Fit:**` line all sit under `## Use Cases`, while
`check-freshness/` has a proper `## What`. The bar puts Non-goals in `## What`. That is a
pre-existing divergence across ACED nodes, not this CR's debt, so it was left alone rather than
restructured unilaterally.

## Incidental finding — not this CR's work

`pnpm verify` fails at the root on `cyberfleet#check:spec` and `cyberlegion#check:spec`, and it is
not this CR: `discover-specs` guards its filesystem walk with a name blocklist, so it descends into
nested git checkouts and discovers the whole corpus once per agent-harness worktree (38 spec files
found, 28 of them phantom). Filed as **#472** with the structural fix (skip any directory that is
itself a checkout). Five clean leftover worktrees pruned; two carrying uncommitted work were left
alone, so the two `check:spec` targets still fail until #472 lands or those two are resolved.
`.claude/worktrees/` added to tracked `.gitignore` (`910b004f`) — cosmetic, the walk reads the
filesystem rather than the index.

## NEXT

**Spec gate PASSED and both suites are FROZEN** (`eval-run/run/run.feature`,
`eval-run/check-freshness/check-freshness.feature`); `status: approved`, gate line in the shard,
`by: unional, cause: clearance`. Deliver is the live frontier.

Build against the frozen suites, nothing else:

1. **`run` records the evaluated set** — the skill body writes `{path, sha256}` per input it reports
   consuming. A listed directory needs BOTH a directory entry hashing the returned names AND a
   per-file entry per file it yielded — the round-3 finding: a directory-name hash is invariant under
   a content edit, so a directory-only recorder kills `check-freshness`'s `stale` verdict silently.
2. **`check-freshness` engine** — a deterministic `.mts` + `node:test` (it is recused from ACED
   grading; its suite binds to its own tests). **Share one hashing routine with `run`, do not write a
   second that currently agrees** — the architect finding; a divergence would surface as a permanent
   `stale`, never as an error.
3. **Impl gate** — cold impl-judge per frozen scenario. Bring it to the owner (the leash self-asserts
   the spec gate only).
4. **Handoff** — PR only. All three follow-ups are FILED and durable: **#475** verified read set,
   **#476** consumer wiring for `run` / `improve`, **#477** the untrusted-pass problem. Nothing
   further is owed to the brief on retirement.

Also outstanding: branch is behind `origin/main`; root `pnpm verify` still red on the nested-checkout
bug (#472), unrelated to this CR.
