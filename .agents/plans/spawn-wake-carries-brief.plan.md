---
cr-ref: spawn-wake-carries-brief
target-project: cyberlegion
blast: high
hitl: true
leash: auto-none
tier: opus
todos:
  - content: "explore — re-spec brief delivery: wake carries the instruction, hook-inject retired"
    status: done
  - content: "spec gate (1st pass) — RATIFIED by owner; ledger seq 2"
    status: done
  - content: "deliver — doorbell/session/inject-inbox change + per-scenario verification"
    status: done
  - content: "impl gate (1st pass) — 13 rounds, all remediated; superseded by the re-cut suites"
    status: done
  - content: "spec conformance — cold re-derivation + both nodes re-cut (35 and 87 scenarios); all 40 holes closed"
    status: done
  - content: "spec gate (2nd pass) — RATIFIED e446192d; 6 rounds, suites frozen at 35 and 87"
    status: done
  - content: "impl conformance — 38 new scenarios bound; tests 467 -> 513, no impl change needed"
    status: done
  - content: "impl gate R1 change (21 verification gaps) — all remediated in 37f9bbde + 74b792fe"
    status: done
  - content: "impl gate R2 — INCOMPLETE, judge died on a session limit; ~30 of 122 graded, re-run the rest"
    status: in_progress
  - content: "handoff — PR; file the 13 follow-ups (ADR-0032 already landed, not owed)"
    status: pending
---

# CR spawn-wake-carries-brief — the spawn wake carries the brief instruction

Source: owner prompt, this session (no forge issue — no closing reference at handoff).
First of a three-CR arc; CR-B (`cyberlegion-plugin` lifecycle abstraction) and CR-C
(`cyberfleet-plugin` Operator adoption) follow and are **out of scope here**.

## Problem

Spawn splits brief delivery into two acts. The payload lands out-of-band on disk and the child
picks it up through its own `SessionStart` hook; the wake is then content-free — it only says the
brief is already loaded. The owner wants the wake itself to carry the instruction, over cyber-mux,
so pickup does not depend on a hook firing in the child.

## Scope

**In.** `packages/cyberlegion` only — the CLI mechanism.
- `src/console/doorbell.ts` — the spawn doorbell message becomes the instruction (read your brief
  at its path, begin), not a notification that context is already populated.
- `src/runtime/inject-inbox.ts` — the `spawning` → `active` brief-injection branch becomes
  redundant; retire it without disturbing the mail/owner-mail/setup-nudge surfacing around it.
- `src/session.ts` — brief still persisted to disk (the instruction points at it); confirm the
  record's `spawning` status still has a reader once injection is gone.
- Spec nodes: `mail/surface`, `unit/lifecycle`. (`mail/doorbell` was in the intake estimate and is NOT touched — see Floor.)

**Out.** The lifecycle abstraction and its frameless-unroutable case (CR-B). Operator's
unconditional spawn and the stale hook prose in the cyberfleet plugin (CR-C). Any `AgentRuntime`
type in `src/` — the CLI stays mechanism-only; routing judgment is the plugin's.

## Floor

**Clearance — granted live by the owner before drafting.** The owner was shown, before ratifying,
that this re-opens frozen scenarios in two nodes and supersedes the ADR that split payload-delivery
from turn-delivery, and selected the option naming both. Record the grant at the spec gate before
any frozen scenario is narrowed.

Frozen scenarios that actually narrow (measured against the files, not estimated):
- `mail/surface:11` — a spawned peer's first hook call injects its pending brief. **Dies.**
- `mail/surface:17` — a later hook call does not re-inject the brief. **Dies with it** (moot once
  nothing injects).
- `unit/lifecycle:180` — the first-turn doorbell "is a wake to act on the **loaded** brief". The
  brief is no longer loaded in context at wake time, so this step is rewritten.
- `unit/lifecycle:11` — spawn pre-registers the peer with `status spawning`. Rewritten to `active`
  per the owner's decision below.

**`spawning` status — owner decision, live, this session.** Retiring the hook's injection branch
removes the only reader of `spawning` and the only transition to `active` (`inject-inbox.ts:40` is
the sole reader; `session.ts:201` the sole writer). Owner chose: **drop `spawning`; spawn registers
as `active`**, rather than keeping a hook alive for bookkeeping or hanging the flip off the
best-effort wake (which would contradict the still-frozen `unit/lifecycle:193-198` — a ring that
never completes must not fail the spawn). Consequences: `AgentStatus` loses `spawning`
(`store/store.ts:20`); the registry loses any "spawned but never took its turn" signal;
`unit/registry`'s suite is unaffected (it never names `spawning`, and already asserts
`status=active` on registration).

Survive untouched — do not edit:
- `unit/lifecycle:27-31` — brief-by-file; the typed launch command carries no brief text. The brief
  is still written to its file and still never typed into the launch command.
- `unit/lifecycle:187-198` — boot-race re-submit, delivered-exactly-once, ring-never-fails-spawn.
- `unit/lifecycle:200-204` — `--no-wake`.
- `mail/doorbell` — **no scenario in the node references the spawn doorbell.** The node is entirely
  `mail send` delivery-ring scoped. Out of the blast; drop it from the touched set.

The new instruction points at the brief's path; it does not re-type the brief body. So
`unit/lifecycle:191` ("never re-typed per retry") and `:183` ("not typed into the pane") stay true
under the new contract — a narrower blast than intake estimated.

Supersedes `artifacts/adr/0027-spawn-delivers-first-turn.md`, which chose the split deliberately.
A superseding ADR is part of this CR, not a follow-up.

## Method

Mechanism already exists — `MuxAdapter.submit` / `nudge`, surfaced as `unit nudge --message`. This
is a re-spec of what the wake says and the retirement of a now-dead pickup path, not new plumbing.
Keep the boot-race budget the doorbell already carries; keep the wake best-effort so a ring failure
never fails a spawn.

## NEXT — resume here

### The next action

**Re-run impl-gate round 2 over the ungraded scenarios only.** Spawn `sdd:sdd-impl-judge` cold and
scope it to what no completed grader covered: `mail/surface` scenarios **19–35**, and all of
`unit/lifecycle` **except** the close family (feature lines 371–471, already graded PASS with every
conjunct severably mutation-killed). That is roughly 92 of 122. Brief it that rounds 1 and 2 found
**no behavioral non-conformance at all** — every finding to date is a verification gap — and hand it
the two traps in *Traps that cost real time* below.

Then handoff: PR, and file the 13 items in `## Follow-ups`. Tree is clean at `84a6c2d7`;
`pnpm verify` 35/35; 513 tests.

**Do not re-run the spec gate.** It is ratified (`e446192d`, ledger seq 3, root spec
`status: approved`) and **no spec artifact has changed since** — every commit after it touches
`src/**` tests only, which is why `align-spec` is green. Re-running re-opens a frozen contract for
nothing.

**Do not "start implementation".** Deliver landed long ago (`17cf8eac`, `c2498ce4`); ADR-0032 exists
and ADR-0027 is marked superseded; conformance is bound at 513 tests. Impl-gate round 1 graded all
122 by hand and found **zero** behavioral non-conformance. The only outstanding work is *judging*.

### Blocking decisions

**None open.** The three owner decisions this mission took — drop `spawning` and register `active`;
close all 40 holes in this CR rather than splitting them out; file the three implementation defects
as follow-ups rather than fixing them here — are settled and recorded in the ledger and below. Do
not relitigate them.

### The cold redo RAN. It found what the retrofit could not. — 2026-08-09

Both nodes were re-derived blind (a cold agent per node, fed only the implementation and the node's
`## What` / `## Use Cases`, never the `.feature` or the existing map), then diffed three ways.
Artifacts, in the session scratchpad — **copy them into the repo or re-run before they age out**:

- `derived-mail-surface.md`, `derived-unit-lifecycle.md` — the blind CFGs + required `(path class, edge)` pairs
- `diff-mail-surface.md`, `diff-unit-lifecycle.md` — the three-way diffs

**Result: 40 coverage holes and ~11 vacuous scenarios across two suites the retrofitted map
reported as 1:1.** That settles the premise — a backward-built map cannot surface a hole, and this
one didn't.

**`mail/surface`** — 10 absent pairs, 7 vacuous scenarios, 3 orphans. The worst is structural: every
one of the 24 frozen scenarios runs `--event SessionStart`, and no scenario asserts the value of the
echoed `hookEventName`. A mutant that hardcodes `hookEventName: 'SessionStart'` and drops
`PostToolUse` from `EVENTS` **passes the entire frozen suite** — half the event contract is
unwitnessed. The vacuity class is one mechanism repeated: a negative of the form "the payload
contains no X" is satisfied trivially when `parts.length === 0` returns `null`, and five Givens
establish nothing else in `parts` (scenarios 12, 14, 20, 21, 23; 16 and 17 at risk).

**`unit/lifecycle`** — 30 holes, 4 vacuous, no whole-scenario orphans. Strong where the authors
argued in prose (the four-verb live-target floor is complete in all eight refusal directions;
ring-warns vs nudge-fails-loud is sound both ways). Weak exactly where the backward map could not
look: **the creation half of spawn**. The entire PC-F create-route compound guard (atomic vs plain,
and the `at` half) is unfrozen; `--worktree-path` has a refusing direction with no admitting
companion; default worktree path, default branch, worktree marker, `--handle`/`spawnedBy` forks all
unasserted. Two ordering promises are pinned only by "it threw": **S2** asserts the primary-checkout
refusal's error and "no session is opened" but never "no worktree created" — the plain route creates
one and still passes; **S36** asserts the removal-failure throw and the surviving record but never
that the pane was spared, which is the half of "aborts before any reap" that makes a retry possible.

### Three implementation defects the cold read found (reported, not fixed)

Not spec defects — real code, found because a cold reader walked the graph without the suite telling
it what to expect:

1. **`findPaneByAgentId` returns a sanitized filename, not a pane id.** `paths.sanitizePane` maps
   every non-`[A-Za-z0-9_-]` char to `_`, and the lookup returns the filename stem — so tmux pane
   `%3` round-trips as `_3`, which is then handed to `adapter.focus`/`nudge`/`read`/`teardown` as a
   real pane id. Only the `rec.pane?.id` route is safe. `removePaneIndex` still works (sanitize is
   idempotent), so the failure is asymmetric. The pane-index resolution route has **no scenario at
   all** — plausibly why this was never caught.
2. **`decommission`'s dirty check reads a failed git as clean.** `isDirty` is `!!exec(...)` and
   `realExec` returns `null` on failure, so a `git status` that errors collapses to "clean" and the
   worktree is removed without `--force`. This is the gate protecting uncommitted work. cyber-mux's
   own `readDirty` distinguishes "git could not answer" deliberately; this local reimplementation
   reaches the same value by accident.
3. **A pane in an unstorable multiplexer auto-registers, then still injects nothing.** `currentPane`
   admits wezterm/zellij; `storablePane` does not — so `register` writes a record with `pane: null`,
   `resolveSelfId` still yields nothing, and a junk record accrues on every hook call. The two
   functions disagree about what "in a pane" means.

Also: `spawnAndWake`'s brief-path guard is unreachable (`spawn` always sets a non-empty path and is
its only caller) despite a comment claiming it "is not defensive padding"; and `decommission`
bypasses `removeWorktreeSafely`, so on herdr the workspace binding is never released.

### SPEC GATE RATIFIED (2nd pass) — `e446192d`. Next action: impl-gate conformance.

Root spec is `status: approved`; both suites frozen at **35** (`mail/surface`) and **87**
(`unit/lifecycle`). Ledger seq 3 carries the gate line under Clearance. Cold judge round 6:
oracle/builder/architect all PASS, ALIGNED true, no findings.

**Six rounds, five of them one migrating defect class** — an absence assertion that could not fail.
Worth carrying, because it cost more than everything else in this mission combined:

- R1/R2 — refusals asserting the throw but not the absence of what the guard prevents. Fixed at the
  sites each verdict named; recurred at new sites both times.
- R3 — a mechanical sweep closed every *absent* absence and **introduced inert ones**. Its predicate
  was syntactic ("an absence Then exists"); existence is not loseability.
- R4 — applied R3's invariant to all 104 absence assertions, closed 10, missed one by using the
  corollary (bind the noun) as the whole rule.
- R5 — one site: an **absence wearing positive syntax** ("the registry holds the same records it
  held before"), which is why five keyword-keyed sweeps walked past it.
- R6 — swept a third axis (state-preservation vocabulary) plus the residual carrying no marker at
  all. Zero findings.

**The invariant, in its complete form:** every absence `Then` must be loseable on its own scenario's
`Given` — name the wrong implementation W *and the concrete artifact it produces*. Binding the noun
is necessary, not sufficient. If no W is representable, **strike the assertion**; do not narrow the
`Given` until it looks bound. (One assertion was struck on exactly that ground: `MuxPlacement` is a
closed four-literal enum carrying no workspace identity, so "the placement does not name the focused
workspace" was unrepresentable, not unbound.)

### Deliver is COMPLETE — verified against the tree, not assumed

- `store/store.ts` — `AgentStatus` is `'active' | 'idle' | 'stale' | 'exited' | 'paused'`; `spawning`
  gone, and the record type is `AgentStatus | (string & {})` so a migrated legacy value round-trips.
- `session.ts` registers `active`; both `inject-inbox.ts` sites removed; `SPAWN_DOORBELL` names the
  brief path; `WakeSpawnInput` threaded.
- **ADR-0032 exists and ADR-0027 is marked superseded by it** — the carried finding that the
  supersession was "absent from the diff" is resolved. 0027 correctly retains turn-delivery and
  overturns only the payload/context split.

### IMPL GATE — round 1 `change` (remediated), round 2 INCOMPLETE. Resume here.

**Round 1 verdict: `change`, `IMPLEMENTATION_PASS: false`.** Headline, and it held up: **no scenario
failed because the implementation is wrong.** Zero behavioral non-conformance across all 122 graded
by hand. All 21 findings were verification gaps — frozen `Then` clauses no test could lose. Rollup
101 fully bound / 20 partially / 1 wholly unbound. Remediated in `37f9bbde` (498 → 511).

**Round 2 DIED on a session limit before emitting a verdict.** Several of its parallel graders
finished first and their results are real and usable — but **~30 of 122 scenarios are covered, not
all.** Do not treat the impl gate as passed.

What the completed graders returned:

- **`unit/lifecycle` close family (12 scenarios, feature lines 371–471): ALL PASS**, every conjunct
  severably mutation-killed. It independently confirmed the round-1 repairs are load-bearing —
  skipping the reap when a sibling is registered now goes red, and the abort-before-teardown
  ordering conjunct dies when the teardown block is moved above the removal block.
- **`mail/surface` scenarios 1–18: 16 PASS, 2 PARTIAL** — a real finding, now fixed in `74b792fe`
  (511 → 513). Both auto-register scenarios froze "And the command exits 0" and neither clause was
  bound: `process.exitCode = 1` on the successful register, or inside its best-effort catch, left
  the entire suite green while every hook call from a real live pane would fail the harness turn.

**Still ungraded by any completed grader:** `mail/surface` 19–35, and `unit/lifecycle` outside the
close family — spawn resolution, worktree/label, `--cwd` and first-turn, and the four live-target
verbs. Round 2 must be re-run over those.

Two carried observations from the round-2 graders, neither blocking:

1. **Both primary-checkout close fixtures are narrow.** They register `worktree.root = '/repo'`,
   which does not exist on disk, so `worktreeExists` is false and the "no worktree removal is
   attempted" conjunct is satisfied by the already-gone arm rather than by the refusal. Deleting the
   guard outright leaves that conjunct green (the throw/record/pane assertions still catch it). A
   fixture whose primary root exists would make it carry its own weight.
2. **`decommission.test.ts:268`** (`existsSync(store.root)`) observes hub creation, not the reap; the
   real conjunct is carried by the bystander test.

### Two traps that cost real time — read before resuming

- **The e2e drives the BUILT `dist/cli.mjs`.** A `src`-only mutation is invisible to it. The
  exits-0 mutation above looked like a survivor until `pnpm build` was included in the loop. Any
  mutation check touching `cli.e2e.test.ts` must rebuild.
- **`detectHarness` tests key PRESENCE for the cursor/codex families**, not value. Blanking a signal
  still detects a harness. This suite runs under a harness, and ambient `CODEX_COMPANION_*` keys were
  enough to make a "register must fail" fixture succeed. `baseEnv` now treats an explicit `undefined`
  as removal; use `withoutHarnessSignals`.

### Impl conformance LANDED (`dcb9026f`) — superseded by the above

Tests **467 → 498**. **No implementation change was required** — every frozen scenario already
conformed, which is what you expect when a re-derivation finds holes in the spec rather than in the
code. Test-only diff; no frozen suite touched (`align-spec` green).

Every non-trivial test was mutation-checked: 26 mutations, 26 kills. Independently reproduced the
load-bearing one: hardcoding `hookEventName` to `SessionStart` and dropping `PostToolUse` from
`EVENTS` passed **all 24 original scenarios and all 467 original tests**, and now dies. That is the
redo's thesis demonstrated end to end.

One mutation initially survived, and the defect was in the new test: the atomic-marker fixture used
a **fixed directory name directly under the shared tmp dir**, so a previous run's marker satisfied
the assertion. Now unique per run. **Several pre-existing `session.test.ts` fixtures share that
pattern** (`atomic-unit`, `default-ws-unit`, `labeled-unit`) — claimed safe only because they assert
call arguments rather than the filesystem. Worth a follow-up regardless; it is a live trap.

Two open items handed to the impl-judge to rule on:

1. **`--task -` (stdin) has no spawn-level binding** — `readFileSync(0)` cannot be driven from vitest
   without a real fd-0 redirect. Bound at the seam; the seam-to-brief-file join is bound by the
   `--brief-file` test; the composition is not.
2. **`copilot` is unspecified but still implemented and tested** — the frozen `clear` Examples table
   dropped the row as unreachable, but `RESET_MAP` still carries it and two tests still assert it.
   Nothing is out of conformance; the mapping is tested while unspecified.

### (superseded) the impl gate is the next action

`pnpm --filter cyberlegion test` is 467/467 green, but that reflects **only the pre-existing suite**.
The 38 scenarios this CR added have no tests. Before spawning the cold `sdd:sdd-impl-judge`:

1. Write conformance for all 38 new scenarios and report, per scenario, whether it needed an
   implementation change or only a test.
2. **`src/runtime/inject-inbox.test.ts:117` constructs `env: {}`** — the bare-environment fixture
   that R5's fix just specified away. The frozen `Given` now requires a detectable harness signal.
   That test must be updated or it is a false green.
3. The impl-judge re-derives each scenario's oracle independently (ADR-0016); the gate is not
   settled by the producer's self-report.

### (superseded) both nodes re-cut — kept for the record

Both suites are re-cut from the derivation and committed (`fd2f0a5a` mail/surface 24 → **35**;
`bc432b41` unit/lifecycle 60 → **87**). All 40 holes closed, all vacuous scenarios fixed in place,
the Conflict pair fixed rather than disclosed, both maps rewritten from the derived graphs. All six
`check:spec` checks green — `align-spec` cleared once the narrowing landed in HEAD, as predicted.
`pnpm --filter cyberlegion test` 467/467. The 27 + 11 new scenarios have **no tests yet**; that is
the impl gate's job, and the green 467 reflects only the pre-existing suite.

**The next action is the spec gate, and it is a re-judge of two whole nodes, not a delta.** Before
spawning the cold `sdd:sdd-spec-judge`:

1. **Rewrite `approval.spec.why.blast` in `packages/cyberlegion/.agents/spec/spec.md`** — it still
   says `medium` and describes a two-node delta. It is now `high`: two suites roughly doubled.
2. Root `spec.md` is `status: draft`; the gate must re-pass and be **re-ratified by the owner**
   before the impl gate resumes. Leash is `auto-none` — emit the verdict and stop; do not
   self-assert over a Clearance floor.
3. Expect more rounds than a delta review would take.

Then the impl gate (13 rounds already banked, all remediated — but 38 new scenarios now need
conformance), then handoff.

### The scope decision behind this — close all 40 here; blast medium → high

The size concern was put to the owner (40 holes is a node-wide re-spec of two nodes, most of it
pre-existing and off this CR's subject) and the owner **reaffirmed the grant as given: close every
hole in both nodes, fix the vacuous scenarios in place.** That is now the scope. Consequences:

- **Blast is `high`, not `medium`.** The ratified `approval.spec.why.blast` in the root `spec.md`
  says medium and must be rewritten before the gate re-passes; the spec-judge re-judges two nodes
  end to end, not a two-node delta.
- **Clearance covers the in-place fixes.** Amending a vacuous Given, sharpening S2/S36/S24, and
  fixing the Conflict pair are all narrowings of already-ratified frozen scenarios. The grant is
  recorded in the combat log ahead of the edits; the durable `floor: clearance` lands on the
  re-ratified gate line.
- **Expect more judge rounds.** Two suites roughly doubling in size is not a delta review.

**The three implementation defects are follow-ups, not this CR** — owner's call. None is on the
spawn/wake/brief path, and each needs its own scenario before a fix can be judged. File all three
at handoff with the evidence in `## Three implementation defects` above; the dirty-check one is a
silent-data-loss class and should be filed first.

### Why — the defect this redo existed to correct

The conformance work (`c6525a22` → `ea4930bb`) **retrofitted** the map: the CFGs were drawn from the
code correctly, but the map was then built by taking each existing scenario and finding an edge for
it. That makes it 1:1 **by construction**, so it cannot surface a coverage hole — which is the one
thing it was added to do.

`sdd:suite-format-governance` and ADR-0029 require the opposite for a backfill: re-derive the whole
scenario set from the CFG's edges; the pre-existing `.feature` is **reference only**, each entry a
claim to verify, never the baseline to patch. Reading the standing suite and filling the gaps a diff
notices is named explicitly as *not* the procedure.

The evidence it was retrofitted: every gap that surfaced (`G -- no`, `CL -- no`, `CLH -- no`) was
found by a *judge walking the graph*, not by the derivation. A cold derivation would have produced
them before any judge ran. So `check-suite` green means **binding verified, adequacy not**.

### Blocking decisions — for the owner, do not guess past

1. **A `Conflict`-floor contradiction sits in the already-ratified frozen suite.** In `mail/surface`,
   `a registered, active caller with an empty inbox injects nothing` contradicts `an unbound root
   pane gets a Legion setup nudge`, and `a SessionStart hook auto-registers a live-pane session that
   has no identity yet` contradicts `a non-multiplexer root session with no standing owner gets the
   setup nudge`. Each pair shares its `When` and admits a snapshot satisfying both `Given`s while
   demanding opposite verdicts; they cross on orthogonal axes, so neither is a specialization. Three
   fixtures already work around it with comments saying so. **Currently disclosed, not fixed** —
   fixing narrows a frozen scenario and fires **Clearance**. Options: (a) leave disclosed, (b) grant
   Clearance and fix the `Given`s in this CR, (c) split into its own CR.
2. **The cold redo may find more holes in the frozen suites.** Closing a hole is *additive* and
   self-clears; changing an existing scenario is a narrowing and fires Clearance. Decide which the
   redo is authorized to do before it runs.
3. **Two declared gaps are unclosed**: `CL -- no` (default harness binary) and `CLH -- no`
   (`unit spawn` with neither `--harness` nor a resolving def — a real throw with **no coverage
   anywhere in the corpus**). Both closable additively.

### Findings the commits will not show

- **Thirteen impl-gate rounds never found the implementation wrong.** Every finding was a check that
  passed while the behavior it named stayed mutable. The root cause was structural: `check-suite`
  *skips* a spec with no `## Scenario map` rather than failing it, so the map-binding lint had never
  run on either node, and coverage was hand-judged one sibling at a time.
- **The CFG earned its keep despite being retrofitted** — it found a real implementation defect
  (`c2498ce4`: the primary-checkout guard ran after the worktree was created, and on the atomic
  branch after a session was opened, so the frozen *"no session is opened"* was false on herdr), a
  self-contradicting ordering claim inherited from the retired ADR-0027 design, and the contradiction
  in decision 1 above.
- **The producer failure mode across rounds 3–4 was closed-world claims** — "it is the only one",
  "the happy-path pass-throughs", "it never builds one" — each asserted without checking against the
  artifact, each false. `ea4930bb` struck the quantifiers instead of re-verifying them, and doing so
  immediately surfaced `CLH -- no`. Keep lists open when resuming.
- **Eight of twelve behavioral nodes still lack the four sections** (`admin`, `agent`, `attach`,
  `init`, `mail/core`, `mail/doorbell`, `mail/wait`, `unit/registry`), so `check-suite`'s map lint is
  still silently skipped on them — the same blind spot, live. Separate corpus-wide CR.

### Working method — do not relearn

Resolved decisions are in `## Resolved decisions` and the sections below; the impl-gate remediation
history is in the commit messages on this branch (24 commits ahead of `origin/main`). Two standing
rules earned this mission, both load-bearing on resume:

- **Calibrate every bar in both directions** — the mutant must die *and* a contract-satisfying reword
  must survive. Rounds 7–10 each traded one defect for another by only checking the first half.
- **Fix the class, not the named site** — findings recurred for five rounds because each round bound
  one verb and left its siblings. Sweep the axes as a matrix in one commit.

### State

Branch is rebased onto current `origin/main`; `pnpm verify` green (35/35, 467 tests); all six
`check:spec` checks ok. Root `spec.md` is **`status: draft`** — deliberately re-opened for this
conformance work, so the spec gate must re-pass and be re-ratified before the impl gate resumes.
Impl-gate round 13's findings are all remediated and committed; no impl round is outstanding.

### Deliver — what has to land

Against the now-frozen suites. Nothing here is settled by the gate; the impl-judge re-derives each
scenario's oracle independently.

- `store/store.ts:20` — `AgentStatus` loses `spawning`. **But see the read-tolerance requirement
  below — do not just delete the union member.**
- `session.ts:201` — spawn registers `status: active` (was `spawning`).
- `runtime/inject-inbox.ts` — **both** sites removed (the `:40` injection branch and its status
  flip). Do not disturb the mail / owner-mail / setup-nudge surfacing around it, nor the
  auto-register branch (`unit/registry/README.md:119`'s "hook-failed pane" still refers to it).
- `console/doorbell.ts` — `SPAWN_DOORBELL` rewritten to instruct "read the brief at <path> and
  begin", naming the path and not carrying the body.
- `WakeSpawnInput` threaded with the brief path — `wakeSpawn` takes no brief today.
- `session.test.ts`, `inject-inbox.test.ts` updated.
- **The superseding ADR for `artifacts/adr/0027-spawn-delivers-first-turn.md`** — the ledger grant
  binds it to *this* CR, not a follow-up. Both judge rounds flagged it; the impl gate must not waive
  it.

### The load-bearing impl constraint (from the chosen F1 remedy)

`surface.feature`'s legacy scenario asserts *"the peer's record still carries the status it was
migrated with"*. Once `spawning` leaves `AgentStatus`, the store must **round-trip an off-enum status
value** — a read that coerces, validates against the union, or normalizes an unknown status will fail
that scenario. `admin migrate` carries agent records from older hubs, so the fixture is real, not
hypothetical. This is the price of freezing the retirement; it was the owner's call and it is now
frozen contract.

### Environment note — correcting a stale carry

`check-suite` **does** run in this repo. Invoke it through the package entrypoint
(`pnpm --filter cyberlegion check:spec`, i.e. `sdd-check-specs`), which reports "suite checks OK".
Only invoking `spec-gate/scripts/check-suite.mts` directly with `node` fails
(`ERR_MODULE_NOT_FOUND` — that path's engine resolution is npx-only). Earlier rounds of this mission
recorded "check-suite cannot run here" and judged suite form by hand; that was wrong, and the linted
result is green either way.

`align-spec` compares against **HEAD**, so an uncommitted narrowing shows as a `check:spec` FAIL
("escalate a Clearance CR, do not silently rewrite"). That is the guard working; it clears once the
gate commit lands. Expect it again during deliver only if scenarios move.

### Defects fixed and verified held

- R1 finding #2 — the `mail/surface` negative rode on an empty-payload `Given` (vacuous). Now
  asserts suppression inside a *non-empty* payload. **Held** (but see F1 — insufficient alone).
- `suite-format` "one condition per step" + "present, not absent" — the `Given` was absence-defined
  and conjunctive. Split into two present-state steps. **Held.**
- This session, `suite-format` trace rule: `surface.feature:18` asserted "brief file left on disk,
  **unread by the hook**" — a non-act with no readable artifact, plus two conditions in one step.
  Now "still exists with its contents unchanged"; README behavior-table row mirrored.

### Carried findings (not blockers)

- **ADR-0027 supersession is still absent from the diff.** The ledger grant binds the superseding ADR
  to *this* CR, not a follow-up. Not a spec-gate blocker (the gate's artifact set is `spec.md` +
  `.feature`) — but the impl gate must not waive it.
- Neither node README carries `## Control Flow` / `## Scenario map`. Judge verified **pre-existing
  corpus-wide** — 10 of 11 behavioral nodes use the legacy table, only `mux/` has the new sections;
  `check-suite` *skips* a spec with no scenario map rather than failing it. Not attributed to this CR.
- Architect observation: dropping `spawning` also removes the only signal distinguishing "spawned,
  never woken" from "working" — `unit list` filters only `exited` and the ring is best-effort, so a
  peer whose wake silently never landed now reports `active`. Matches the follow-up already recorded
  below.
- **Impl-gate risk (R3, architect).** `surface.feature:31` now requires the store to **round-trip an
  off-enum status value** once `spawning` leaves `AgentStatus` — a read that coerces or validates
  against the union would fail "still carries the status it was migrated with". `store/store.ts:20`
  declares that union. This is the load-bearing consequence of remedy 1; do not delete `spawning`
  from the type without checking the read path tolerates an unknown value.
- Architect observation: `--no-wake` changed meaning without changing text — previously "no turn,
  brief auto-loaded"; now "no turn **and** brief unread on disk". Caller-side, relevant to CR-C.

(A carried claim that `check-suite` cannot run here has been struck — it was wrong. See
**Environment note** above: it runs via `pnpm --filter cyberlegion check:spec`. `check-spec-state.mts`
also runs and reports clean.)

Deliver (after the gate, not before) still has to land: `store/store.ts` `AgentStatus` loses
`spawning`; `session.ts` registers `active`; both `runtime/inject-inbox.ts` sites removed;
`console/doorbell.ts` `SPAWN_DOORBELL` rewritten to name the brief path; `WakeSpawnInput` threaded
with that path (`wakeSpawn` takes no brief today); the store's read path made tolerant of a legacy
`spawning` value (see the impl-gate risk above); `session.test.ts` and `inject-inbox.test.ts`
updated. Plus the superseding ADR for 0027 — in this CR, not a follow-up.

## Follow-ups to file at handoff (none yet filed)

1. **`decommission`'s dirty check reads a failed git as clean** — silent data loss; file first.
   `isDirty` is `!!exec(...)` and `realExec` returns `null` on failure, so a `git status` that errors
   collapses to "clean" and the worktree is removed without `--force`. No scenario freezes this, so
   nothing blesses it.
2. **`findPaneByAgentId` returns a sanitized filename, not a pane id** — tmux `%3` round-trips as
   `_3` and is handed to the backend as a real pane id. Only the `rec.pane?.id` route is safe.
3. **A pane in an unstorable multiplexer accrues a junk record per hook call** — `currentPane` admits
   wezterm/zellij, `storablePane` refuses them; the two disagree about "in a pane".
4. **Scenario relocations blocked by node scope**: the legacy-status round-trip assertion belongs to
   `unit/registry`, and `only the dedicated mail hook command produces the payload` belongs to
   `init/`. Coverage is kept in `mail/surface` meanwhile — relocate, don't duplicate.
5. **`cli.e2e.test.ts:490`** still carries a Conflict-workaround comment of the class fixed in
   `inject-inbox.test.ts`; it was outside the producer's edit scope.
6. **`unit/lifecycle`'s `SPBK -- yes` edge** (the post-creation backstop) has no scenario — closing
   it needs a backend fixture that lies about the root it created.
7. **Eight of twelve behavioral nodes still lack the four sections**, so `check-suite`'s map lint is
   silently skipped on them — the same blind spot this CR just proved costly, still live corpus-wide.
8. **`spawning` is gone, and with it the registry's only signal** for "spawned, ring failed, never
   took its turn". Owner accepted this knowingly; if the fleet view later wants to surface stuck
   ships, that signal needs rebuilding.
9. **CR-B** (`cyberlegion-plugin` lifecycle abstraction) and **CR-C** (`cyberfleet-plugin` Operator
   adoption, plus its stale hook prose and `--no-wake`'s changed meaning).

Added by the impl gate (round 1):

10. **The scenario bridge is inert — it binds 0 of 122.**
    `packages/cyberlegion/.agents/sdd/scenario-bridge.toml` exists, but no test carries a
    `describe('spec:cyberlegion/mail/surface')` wrapper, the `unit/lifecycle` wrappers carry title
    suffixes that break the node key, and `check:spec` never runs the bridge at all. The project has
    opted into an instrument that reports nothing. Not a conformance failure — test naming is not
    frozen contract — but it is a second dead coverage instrument in the same package, after the
    backward-built maps this CR spent six rounds repairing. **Fix or remove; do not leave it
    reporting silence.**
11. **The fixed-name tmp fixture trap.** Several `session.test.ts` fixtures (`atomic-unit`,
    `default-ws-unit`, `labeled-unit`) build paths as a fixed name directly under the shared tmp
    dir, so a previous run's artifact can satisfy an assertion. It already produced one false green
    in this CR (the atomic-marker test), caught only because a mutation survived. They are safe
    today **only** because they assert call arguments rather than the filesystem — one filesystem
    assertion added to any of them reintroduces the bug. Make the paths unique per run.
12. **`doorbell.ts`'s success path can return a spurious `warning`** that nothing notices —
    over-permission; no frozen `Then` requires it.
13. **`file-store.test.ts`'s tmux characterization is deliberately absent.** The reverse lookup is
    now bound only on sanitization-invariant (herdr) pane ids, so it stays green through the
    follow-up in item 2. Whoever fixes item 2 should *add* the tmux binding at that point — it was
    left out rather than forgotten.
