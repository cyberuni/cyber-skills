# Grill verdict — the 7-claim defect list against `cyberfleet/skills/operator`

**Date:** 2026-08-11
**Subject:** `plugins/cyberfleet/skills/operator/SKILL.md` (+ `README.md`)
**Method:** the `grilling` skill's substance — every asserted fact re-derived from the hub and the
`cyberlegion` source before any claim was scored. (Its interview *form* does not apply: this is a
headless verdict mission with no interlocutor, and the brief asks for a verdict, not a shared
understanding. Every question that would have been put to a human was answerable from the
filesystem, which is what the skill says to do with facts.)

**Bottom line:** the list is mostly operator error dressed as skill defect. **The incident is not a
failure.** The mail was delivered, durably, to the correct mailbox. What failed was the
*opportunistic doorbell*, which `cyberlegion` documents in source as unable to fail a send — and it
failed against a pane the Operator session neither chose nor named. Claim 1, the claimed root
defect, is refuted at the mechanism level, and its proposed fix is actively harmful. Two real
defects exist; neither is on the list.

---

## Facts, re-verified

Probes run against the live hub via the built CLI (the worktree has no `dist/`, so
`~/code/cyberuni/cyberplace/packages/cyberlegion/bin/cyberlegion.mjs` was used; hub state is shared
and all probes were read-only — no `attach`, no `register`, no `prune`, no `ack`).

| Brief's claim | Verified | Verdict |
| --- | --- | --- |
| `attach --show` → `mainPane: w3:p4` | `mainPane: w3:p4` | ✅ |
| `w3:p4` is dead since 2026-07-13 | `eab474eaf6def942`, handle `operator`, pane `w3:p4`, **exited**, `lastSeen 2026-07-13T08:02:56Z` | ✅ |
| whoami resolved to `4ea6038427c9d769` / `pod-op6-m5`, exited, created 2026-07-14 | exact match — **but its pane is `w3:pV`, not `w3:p4`** | ⚠️ **amended** |
| Handle `operator` → 3 units | **5 units**: `eab474eaf6def942` (exited), `a652da6e5c7a8baa` (exited, missed by the list — it predates the incident), `standing-operator` (standing, active), `3d88d55ff4d8c35b` (exited), `1273088954f69a33` (**active**, cyber-figma, `wBR:p3`, created today) | ⚠️ **understated** |
| `unit who --all` → 161 | **166** (124 exited / 26 active / 16 `spawning`) | drift |
| `unit who` → 37 | **42** | drift |

The amendment on row 3 is decisive, and the list missed it. **The Operator session's own pane was
`w3:pV`. The pane named in the doorbell error was `w3:p4`.** Those are different panes. Nothing the
Operator session did could have produced `w3:p4` — that string comes from exactly one place in the
hub, the `attach` main-pane binding.

## What actually happened — the mechanism, from source

`packages/cyberlegion/src/identity.ts` and `src/console/doorbell.ts`:

1. **`mail send --to operator` resolved correctly and the message landed.**
   `resolveRecipient` → `matchHandle` → `preferStanding`. `matchHandle` **excludes exited units by
   construction** (`live: matched.filter(a => a.status !== 'exited')`), with the rationale written
   into the source comment: *"a name must never resolve to one — a handle is reusable across units,
   and the dead holders of it outnumber the live one over time."* `preferStanding` then returns the
   `kind === 'standing'` match. So `operator` resolved to **`standing-operator`**, live, durable.
   The corpse at `w3:p4` was never a candidate.

2. **The doorbell then rang a pane nobody addressed.** `wakeRecipient`: for a `kind === 'standing'`
   recipient with no live bound presence, `pane = store.getMainPane()` — the `attach` binding —
   `w3:p4`, dead since 2026-07-13. The nudge failed there and was swallowed into a warning.

3. **That warning is not a failure.** The function's own contract: *"Durable delivery already
   happened; the ring is opportunistic on top… This never throws — it can never fail the send."*

**Empirical confirmation:** `mail inbox --owner operator` → **36 messages, 36 unread, 0 ever
acked**, spanning 2026-07-14 to today, including this morning's pod reports. Mail to `operator` has
been landing successfully and continuously for a month. Delivery was never broken.

---

## The 7 claims

### 1. "Operator dispatches with a return address it never registers" — **FALLS**

Refuted three ways, any one sufficient:

- **The address resolved.** `operator` → `standing-operator`, live, deterministically. The message
  is in that inbox. There was no misroute and no bounce.
- **The proposed fix does not change the outcome.** Had the Operator session run
  `unit register --handle operator`, `preferStanding` would *still* have selected
  `standing-operator` over it — standing wins by construction. Routing is identical. The fix is
  addressed at a symptom it cannot move.
- **The pane in the error is not the Operator's pane.** `w3:pV` ≠ `w3:p4`. The failing ring came
  from the hub's `attach` binding, which is the Council's to set (`init-cyberlegion`, on an explicit
  human yes) and which no Operator action touches.

This is the excuse the brief predicted. The incident session read an explicitly-swallowed
best-effort warning as a delivery failure, then reasoned backward to a skill defect. The skill told
it nothing of the kind; `cyberlegion`'s own help text and source say the opposite.

**One correction to the brief's own guard.** The brief hypothesizes that "Operator registers itself
on seating" contradicts ADR-0022's "probes nothing". It does not. ADR-0022's amendment (ruling 3)
retires *folder/marker probing to decide which persona is seated*; ruling 2 explicitly endorses
`unit register` as the fleet-membership mechanism and notes **Pod already registers on entry**.
Registering an identity is orthogonal to probing a location. The fix is not harmful for the reason
the brief guessed. It is harmful for two better reasons — see *Harmful fixes* below.

### 2. "'Always by handle, never a raw id' carries no uniqueness invariant" — **MISFILED → `cyberlegion`**, and the skill's rule is *correct*

The rule is not the misroute mechanism; there was no misroute. Worse for the claim, the rule is
aligned with `cyberlegion`'s designed rationale, stated in `matchHandle`'s comment: a handle can
never resolve to a corpse, whereas *"an explicit id still resolves either way… unlike reaching for
a handle and silently landing on a corpse."* Handle-preference is the liveness-safe choice. The
skill got this right.

There *is* a residual ambiguity, but it belongs to the CLI and is not what the list described:
`preferStanding` falls through to `matches[0]` — arbitrary registry order — when two or more
**live, non-standing** units share a handle. That is live right now: `operator` has two active
records (`standing-operator` and `1273088954f69a33`). Today `standing` disambiguates it; a handle
with two plain live holders resolves arbitrarily. File against `cyberlegion`
(`identity.ts:197`), not against a persona skill.

### 3. "Hygiene is reactive" — **FALLS** (as a defect; survives only as a preference)

Rot is real — 124 exited and **16 units stuck in `spawning` with no pane** out of 166 — but it is
causally inert. Exited units are excluded from handle resolution by construction, so accumulation
cannot misroute anything. And the skill already puts staleness in Operator's standing remit
("who's active, **who's stale**, what needs the Council's hands" — Output). "Sweep when asked"
versus "sweep proactively" is a policy preference about a destructive verb, not a defect. Making a
state-mutating sweep unprompted is the more questionable default.

*(The 16 stranded `spawning` records are a genuine `cyberlegion` question — whether `prune` reaps a
never-activated spawn — but that is not this list's claim and not this skill's artifact.)*

### 4. "Spawn does not close the loop" — **FALLS**

The loop is already closed in the mechanism, not left to the persona: `cli.ts:289` emits
`first-turn doorbell not confirmed (peer still spawned; nudge it manually)` when the spawn
doorbell does not land. The CLI reports its own delivery uncertainty. Adding a persona-level
"verify after spawn" step duplicates a check the tool already performs and states.

The claim would have force only if a spawn could silently produce an unreachable peer. It cannot —
it says so.

### 5. "The verb list is a partial cover presented as complete" — **STANDS, narrowed and re-aimed**

The premise holds. `Delegation` enumerates six verbs in a closed-list voice ("Every mechanic is a
`cyberlegion` CLI call — unit spawn, unit who, mail send, mail inbox, mail read, unit prune"), and
the CLI carries `whoami`, `register`, `claim`, `close`, `focus`, `nudge`, `read`, `clear`, `await`,
`watch`, `ack`, `delete`, `attach`, `admin`, `init`, `agent`, `mux`.

But the list picked the wrong three as load-bearing:

- **`attach`** — not Operator's. It binds the *human owner's* presence and is `init-cyberlegion`'s,
  gated on an explicit user yes. **Misfiled.**
- **`whoami`** — not load-bearing, and actively hazardous from a reused pane (below).
- **`close`** — arguably Operator's, but `headless-operator` already routes teardown through
  `prune`; a gap in precision, not in capability.

The verbs whose absence is genuinely load-bearing are the ones the list did not name:
**`mail ack`** (and `mail read --ack`) and **`unit claim`**. Without `ack`, the verbs given cannot
drain an inbox — `mail read` only peeks. That omission is directly visible in the evidence: 36
messages, 0 acked, ever.

**Invariant violated:** *a persona that is enumerated a closed verb list must be given every verb
its own stated responsibilities require* — Operator is told to route mail and to tear down ships,
and is given neither the verb that consumes mail nor the verb that binds it as an addressee.

### 6. "Headless Operator has a wider remit while claiming it is not a separate role" — **FALLS**

There is no concealment to expose. The skill states the widening in the same sentence as the
identity claim: *"It is not a separate role: it realizes this same out-of-ship dispatch seat, with
Operator's remit widened from spawn/list/route to the full lifecycle loop."* The
`headless-operator` agent definition repeats it verbatim and justifies it — the widening is driven
by `ready` replacing a live Council request, and the seat's boundaries (Pod never spawns; no
in-ship persona rule invoked) are held explicitly in both documents.

Role and remit are distinct axes, and the skill uses them distinctly and openly. The claim reads a
contradiction into a stated scoping.

### 7. "Budget skew — a third governs tone" — **FALLS**

Measured against the actual file: `Output` (voice) is ~9 of 78 lines, ~12%. `Decisions` +
`Delegation` + `Headless` (mechanics) are ~35 lines, ~45%. "Roughly a third" is not the document.

And the underlying premise is wrong for this artifact class. This is a **persona** skill
(`metadata.persona: "true"`) whose reason for existing, per ADR-0022, is that *"warmth belongs on
the persona the user delegates to; the CLI and its state store stay cold and mechanical."* Voice is
the persona layer's payload, not overhead on it. Length is not the right budget unit here — the
mechanics are one line each because `cyberlegion` owns them, which is the intended division.

---

## Score

| # | Claim | Verdict |
| --- | --- | --- |
| 1 | Unregistered return address (claimed root defect) | **FALLS** — refuted at the mechanism; message delivered |
| 2 | No uniqueness invariant on handles | **MISFILED** → `cyberlegion` (`identity.ts:197`); skill's rule is correct |
| 3 | Hygiene is reactive | **FALLS** — causally inert; staleness already in remit |
| 4 | Spawn does not close the loop | **FALLS** — the CLI already reports unconfirmed doorbells |
| 5 | Verb list is a partial cover | **STANDS** — but on `mail ack` / `unit claim`, not `whoami`/`attach`/`close` |
| 6 | Headless remit widened while denying it | **FALLS** — the widening is stated, scoped, and justified |
| 7 | Budget skew toward tone | **FALLS** — ~12%, not a third; voice is the persona's payload |

**1 of 7 stands, and only after being re-aimed. 1 misfiled. 5 fall.**

---

## What the list missed

The failing session was blind to the same thing twice: it looked at *addressing* and never at
*reading*.

### A. Operator is an addressee that never reads its own mail — **the real defect**

`standing-operator` holds **36 messages, 36 unread, none ever acked**, from 2026-07-14 to today —
CR gate packets awaiting ratification, blocked missions, publish reports. Every Operator-spawned
pod is briefed to report to `operator`. Every one of those reports landed. None was ever read.

The skill's only mail decision is transit-shaped — *"When a message needs to cross ships"* — and
lists `mail inbox` / `mail read` as verbs for **routing between other ships**. There is no decision
for *Operator is itself the standing addressee of the handle it writes into every brief, and must
drain that mailbox*. No `ack`. No inbox-check-on-seating.

**Invariant violated:** *a persona that writes its own handle into a cold brief as a return address
owns the obligation to read what arrives there.* Dispatch without collection is a write-only
mailbox — which is precisely what the hub shows.

This, not addressing, is what actually broke: the pod's report *did* arrive and nobody was ever
going to read it. The list inverted the defect.

### B. The skill never implements its own stated mental model — nobody ever calls in to the bunker

Operator is a **singleton at the bunker**: sessions and worktrees come and go, and invoking the
skill is a call *in* to a seat that outlives any of them. That model is already built in
`cyberlegion`, in two objects:

- **The bunker** — `standing-operator`, `kind: standing`. Never exits, session-independent, holds
  the durable mailbox. Alive since 2026-07-14. It never died; there is nothing to resurrect.
- **The desk** — `AgentRecord.presence`, bound by `unit claim <handle>`. `claimPresence` resolves
  the standing record **by role handle**, then points it at the calling session. *"Last claim wins:
  a plain overwrite, no merge."* `presenceOf` reads a presence whose unit has exited as **no
  presence** — the desk is simply empty again, and mail still lands in the bunker.

That is the singleton, exactly: one durable seat, a transient occupant, newest caller takes the
desk, an empty desk degrades gracefully instead of erroring.

**Nobody has ever called in.** Verified:

```
unit claim operator --show  →  presence: none
unit claim homa     --show  →  presence: none
```

With no presence bound, `wakeRecipient` falls back to `store.getMainPane()` — the stale `w3:p4`.
That is the entire doorbell story, and it recurs on *every* send to a standing owner regardless of
addressee (reproduced live while filing this verdict: a send to `homa` printed the identical
`pane w3:p4 no longer exists` alongside `sent:`).

The Operator skill names neither object. It never mentions `claim`, never mentions the standing
record it writes into every brief as a return address, and never drains that mailbox. The bunker,
the desk, and the call-in are all built; Operator is never told to pick up the phone.

**Invariant violated:** *a persona seated as a singleton must bind itself to the durable record
that represents that seat — claim the desk on seating, and read what the seat took while it was
empty.* This is the correct, non-contradictory version of what claim 1 was groping at — and the
verb is `claim`, not `register`.

**The call-in sequence:**

```bash
cyberlegion unit register                          # a session identity — as ITSELF, never --handle operator
cyberlegion unit claim operator                    # take the desk; last claim wins
cyberlegion mail inbox --owner operator --unread   # read what the bunker took while nobody was in
```

### C. The Operator skill has no spec node

`packages/cyberfleet/.agents/spec/` carries no Operator node. The persona's obligations are prose
in a SKILL body with nothing frozen behind them, which is why a defect list can be argued against
it without any bar to test the claims against. Findings A and B would each be one scenario.

---

## Harmful fixes — do not adopt

### "Operator registers itself on seating" (claim 1's remedy) — **wrong verb, right instinct**

The instinct is correct and is the project's actual model: Operator is a **singleton at the
bunker**, and a session invoking the skill is calling in to a seat that outlives it. Identity
*should* persist across sessions and worktrees. The objection is not to persistence — it is to what
`register` keys persistence **on**.

- **`claim` keys on the role handle.** `resolveStandingOwner(handle)` finds the one standing record
  by name. Singleton by construction: there is exactly one standing `operator`, and it cannot be
  confused with anything else.
- **`register` keys on the pane.** `resolveSelfId` reads the **pane index**, and `register()`
  honors it: `id = existing?.id ?? existingId ?? randomId()`. Continuity is bound to wherever the
  terminal happens to be, not to the role.

Both directions of that go wrong, and both are already visible in the hub:

1. **Same pane → inherit whatever else died there.** The incident session sat in a pane whose index
   still pointed at the exited `pod-op6-m5` — not a former Operator, a **pod**, with its own
   `brief` and `spawnedBy`. `unit register --handle operator` there would have taken over id
   `4ea6038427c9d769`, renamed that pod to `operator`, and flipped it active. Pane-keyed continuity
   cannot tell the bunker from whoever else sat at that terminal.
2. **New pane → mint yet another seat.** Which is exactly what has already happened **five times**:
   five records named `operator`, four dead, across four panes and three repos. A singleton that
   got re-minted per pane instead of persisting once. It also worsens claim 2's ambiguity while
   changing routing not at all, since `preferStanding` still wins.

The verb that gives the intended semantics is **`unit claim operator`** — bind the desk, keyed on
the role, leaving session identity alone. See finding B for the sequence. Note the one step to
avoid: a calling-in session registers **as itself**, never `--handle operator`; registering under
the role handle is what manufactures the collisions.

### "Verify after spawn" (claim 4's remedy) — redundant

`cli.ts:289` already surfaces an unconfirmed first-turn doorbell. A persona-level re-check
duplicates a tool-level report and trains the reflex the incident already got wrong: treating a
best-effort ring as a delivery gate.

### "Prune proactively" (claim 3's remedy) — mild but wrong-directioned

Makes a destructive sweep unprompted to address rot that provably cannot misroute anything, in an
artifact whose stated boundary is to defer state changes to the Council's ask.

---

## If anything is to change in the skill

One `Decisions` entry, from findings the list did not make: **seating is calling in to the bunker.**
Operator is a singleton; the session is the occupant, not the seat.

- `unit register` — a session identity, **as itself**, never `--handle operator`.
- `unit claim operator` — take the desk, so the doorbell rings this session instead of falling back
  to the Council's main pane.
- `mail inbox --owner operator --unread` / `mail read <id> --ack` — read what the bunker took while
  nobody was in, because every brief Operator writes names `operator` as the return address.

And one line outside the skill: the stale `attach` binding at `w3:p4` should be re-bound or cleared
by the Council. That is `init-cyberlegion`'s surface, not Operator's — though once a presence is
claimed, the doorbell stops depending on it.
