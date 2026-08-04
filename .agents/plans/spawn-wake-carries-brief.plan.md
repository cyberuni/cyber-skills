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
  - content: "spec gate R3 — ALIGNED true, all 3 lenses PASS; awaiting owner ratification"
    status: in_progress
  - content: "deliver — doorbell/session/inject-inbox change + per-scenario verification"
    status: pending
  - content: "impl gate — sdd-impl-judge PASS; rebase onto main; owner ratifies"
    status: pending
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

## NEXT

**Spec gate R3 returned ALIGNED true — all three lenses PASS. Awaiting owner ratification.**

Pre-flight passed both rounds (judge independently derived the same seven; `expected ⊆ declared`).
R3 lenses: **oracle PASS, builder PASS, architect PASS**. `SCENARIOS_FAILING: []` — 24/24 in
`mail/surface`, 51/51 in `unit/lifecycle`. No blocker, no open questions.

### What R2 found and how R3 closed it

- **F1 (builder FAIL) — barred edge with no firing-direction companion.** The `Given` pinned the
  brief file and an unread message but not the peer's registry status; under the only constructible
  fixture (`active`) the un-retired `inject-inbox.ts:40` branch is inert, so a partial implementer
  passed every `Then`. **Owner chose remedy 1 (freeze the retirement), live this session.** Added
  `surface.feature` "a peer record carrying a legacy spawning status still gets no brief" — a record
  migrated from an older hub, asserting no brief section **and** that the record keeps its migrated
  status. R3 re-ran the miss test: that scenario kills the partial implementer **two independent
  ways** (branch fires and emits `## Your brief`; branch flips the record). The two scenarios are
  legitimate permutation coverage — same edge, different path class, and different `Then` sets
  (`:23` asserts brief-file immutability, `:31` record-status immutability, which `:23` cannot
  assert at all since its peer carries the status spawn now writes).
- **F2 — prose out-claimed the suite.** The call-ordinality claim ("on the first hook call as on
  every later one") lost its backing scenario. Rewritten as a **convergence over record status**
  ("whatever status the peer's record carries", naming the legacy case), which is what the suite now
  covers. R3 confirmed the behavior-table row enumerates exactly the four scenarios in that group.
- **R2 blocker — illegal gate transition.** Root `spec.md` re-opened `implemented → draft` (a legal
  edge; the only in-edge to `approved` is `draft → approved`). The `approval` block was deliberately
  **left in place** — R3 walked the illegal-tuple list by hand and ruled it legal and correct:
  `approval` is the overwritten current-state twin this gate rewrites on approve, the durable record
  is the ledger, and clearing it would be the producer writing a gate-owned field.

Also applied: step-down ordering in the `mail/surface` group (happy path leads, barred follow); a
`Then` asserting "brief file left on disk, **unread by the hook**" (a non-act with no readable
artifact, two conditions in one step) became "still exists with its contents unchanged"; and R3's one
non-blocking `CONTENT_GAP` — `unit/lifecycle/README.md` had dropped the `(mail/surface)` attribution
for "nothing later flips it" — was restored.

### Resume here — the gate's own write, on owner ratification

1. **Owner ratifies the spec gate** (leash `auto-none` over a Clearance floor — not self-assertable,
   not relayable; the write is positional and in-session).
2. Write `approval.spec` (`verdict: approve`, `by: <owner>`, floor `clearance` — granted live before
   drafting) and advance `status: draft → approved`.
3. **Append this CR's own `gate: spec, verdict: approve` ledger line.** R3 flagged this specifically:
   the retained `approval` block and the existing shards both still carry github-339's spec-gate
   line, so once status returns to `approved` the mechanical durable-gate floor **cannot distinguish
   this CR's gate from the prior one**. This gate must not rest on the existing floor.
4. Stage the two `.feature` files with the gate commit (freeze is the gate commit; precedent
   `0ae65ed5` kept `@frozen` in place through a narrowing rewrite).

Then deliver (see below).

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
