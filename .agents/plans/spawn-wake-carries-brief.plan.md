---
cr-ref: spawn-wake-carries-brief
target-project: cyberlegion
blast: medium
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
  - content: "impl gate — 13 rounds, all remediated; SUSPENDED pending the spec redo below"
    status: in_progress
  - content: "spec conformance — CFG + scenario map on both touched nodes; REDO COLD (was retrofitted)"
    status: in_progress
  - content: "handoff — superseding ADR + PR; file CR-B/CR-C follow-ups"
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

**Re-derive both nodes' scenario sets COLD from their CFGs, then diff against the frozen suites.**
Work in a scratch file, not in the READMEs. For each node in turn — `packages/cyberlegion/.agents/spec/mail/surface/`, then `unit/lifecycle/`:

1. Read only the implementation (`src/runtime/inject-inbox.ts`; `src/session.ts`, `src/cli-input.ts`,
   `src/decommission.ts`, `src/console/doorbell.ts`) and the node's `## What` / `## Use Cases`.
   **Do not open the `.feature` or the existing `## Scenario map` while deriving.**
2. Enumerate every `(path class, edge)` pair the CFG requires — one per pair, every guard paired
   with a positive companion.
3. **Only then** open the frozen suite and diff three ways: pairs with no scenario (coverage holes),
   scenarios with no pair (orphans / co-owned / not-acceptance), pairs whose scenario exists but
   under a different path class than derived.
4. Bring the diff back as the finding. The map is then rewritten from the derivation, not from the
   suite.

### Why — the defect this redo exists to correct

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

Known environment limitation, pre-existing: `check-suite` cannot run in this repo
(`ERR_MODULE_NOT_FOUND` — the engine is npx-only; re-confirmed this session). Suite form here is
judged, not linted; do not treat a missing check-suite run as a gate failure. `check-spec-state.mts`
does run and currently reports clean.

Deliver (after the gate, not before) still has to land: `store/store.ts` `AgentStatus` loses
`spawning`; `session.ts` registers `active`; both `runtime/inject-inbox.ts` sites removed;
`console/doorbell.ts` `SPAWN_DOORBELL` rewritten to name the brief path; `WakeSpawnInput` threaded
with that path (`wakeSpawn` takes no brief today); the store's read path made tolerant of a legacy
`spawning` value (see the impl-gate risk above); `session.test.ts` and `inject-inbox.test.ts`
updated. Plus the superseding ADR for 0027 — in this CR, not a follow-up.

Follow-up to record at handoff (not yet filed): dropping `spawning` loses the registry's only
signal for "spawned, ring failed, never took its turn". Owner accepted this knowingly; if the fleet
view later wants to surface stuck ships, that signal needs rebuilding.
