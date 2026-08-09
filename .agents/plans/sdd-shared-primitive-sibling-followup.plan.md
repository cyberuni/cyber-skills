---
cr-ref: sdd-shared-primitive-sibling-followup
status: draft
leash: auto-spec
blast: low
todos:
  - id: intake
    status: completed
    note: CR opened against the sdd project spec; leash derived (auto-spec, ledger seq:1); plan scaffolded.
  - id: confirm-placement
    status: completed
    note: CONFIRMED mission/handoff/. formation/ non-goals exclude a single mission's own scope, and formation structurally cannot do this — its input is what the corpus IS, never what a mission DID. Both cold judges agreed independently.
  - id: author-spec-r1r2
    status: completed
    note: SUPERSEDED by the Option C ruling. Two drafts authored (R1 keyed on "touched"+"depends on", 9 scenarios; R2 on "frozen scenarios assert behavior the artifact realizes", 11 scenarios). Both sit on the branch, unfrozen. Do not patch them — re-derive against the C rule.
  - id: spec-gate-r1r2
    status: completed
    note: Two cold sdd-spec-judge rounds, both blocked, ALIGNED false on all three lenses. Round 2 named two blockers as REGRESSIONS from round 1's remediation, which stopped the loop for a re-plan. Nothing self-asserted; no gate line written (a pause on an already-passed spec gate is an illegal tuple).
  - id: replan-D-decision
    status: completed
    note: RULED by Council in-session — Option C (declared-term sweep). Option B struck on evidence. See "Resolved decisions".
  - id: author-spec-c
    status: pending
    note: Re-derive the rule + suite against the C design. Draw the CFG first; do not start from the R2 scenarios.
  - id: spec-gate-c
    status: pending
    note: Cold sdd-spec-judge. Load the full pre-flight governance set this time — both prior rounds ran short.
---

# CR-6 — a shared-primitive CR files a sibling followup

Ratified doctrine KEEP from the full-backlog retro (parent plan
`doctrine-strategy-keep-or-cut.plan.md`, todo `queued-ratification-backlog`, row **CR-6**).
Source: cyberlegion ledger shard `strategy.dae416.jsonl` seq:1 (Scanner, `ratified: false`).

Do **not** re-litigate the keep, and do **not** re-open the `D` question — Council ruled it
(below). Codify it narrow, and route it through the **existing** followup channel.

## NEXT — resume here

**Next action:** author the rule and suite for **Option C** on
`.agents/specs/sdd/mission/handoff/`, via `start-mission`. Draw the CFG from the C rule **first**,
then derive the scenarios from its edges — do **not** patch the 11 R2 scenarios sitting on the
branch; they encode the superseded R2 rule. Then `pnpm --filter cyber-sdd check:spec` and
`pnpm verify`.

**The C rule, in one line:** a CR that changes a shared primitive **declares the vocabulary that
primitive owns**; a sweep reports every **frozen** `.feature` **outside the mission's touched set**
carrying those terms; that set is `D`, and the followup names it.

**Still open — decide while authoring, do not rediscover:**

1. **Is `derived` observable?** (round-2 blocker, narrowed but not closed). The `followup` line
   schema carries no origin field, so `Then no derived followup line names X` can be settled by no
   artifact. Options: add an origin field (widens the CR into `combat-log-governance`); or scope
   the negative scenarios' `Given` to exclude the case where the mission independently identified
   a follow-up naming X — a `Given`-level fix, untested by any judge.
2. **Where does the declared vocabulary live?** A registry file (CR-5's
   `.agents/sdd/retired-terms.toml` is the precedent) vs. a per-CR declaration in the ledger.
3. **Does the sweep engine ship in this CR or a sibling?** Shipping it makes this an engine CR,
   past `blast: low` / `auto-spec`. Specifying the behavior and deferring the engine keeps the leash.
4. Carried from round 2, unactioned: the node's **Subject** still says handoff carries the
   mission's *identified* follow-ups; the README cell explaining the unfrozen case imports a
   **per-node lifecycle status** that `lifecycle-governance` says no node may carry (the scenario
   is right, the prose is wrong); the convergence scenario's apparatus appears **verbatim** in the
   README prose (absorption); the same-channel scenario asserts a **drain** outcome under a
   non-drain `When`.

**Pre-flight debt.** Round 1 flagged six undeclared governances, round 2 flagged two. Loading
`gate-validation-governance` at the stop is what established that **no gate line may be written
here**. `spec-format-governance` is now loaded and discharged (see "Adjacent work landed").

## Resolved decisions

### The `D` ruling — Option C, Council, in-session

`D` is the at-risk sibling set the followup must name. Three options were costed; Council ruled **C**.

**Option B is STRUCK, on evidence** — it aimed at the wrong relation:

- ADR-0021's cross-reference resolver asserts **named slugs resolve to a live unit**. That solves
  rename drift, not "whose frozen assumption did my behavior change break."
- The relation a realization-index needs is **not in the corpus**: `produced-by` records *which
  agent produced the spec*, not which artifact implements it; only **12 of 39** behavioral nodes
  carry a `## Delivery` pointer; and **zero** cyberlegion spec nodes name a `src/` path.
- Decisive test: a path-keyed lookup run against the incident CR-6 exists to catch returns **∅**.
  It would have caught nothing.

**Option C is RULED, and verified against that same incident:**

- The pre-fix sibling contracts were hard-wired to tmux. Commit `55863653` ("mux-agnostic identity
  + herdr auto-register") removes, from frozen contract text: `tmux pane/window/session`, "inside
  tmux, a pane→id pointer", `tmux has-session`, `$TMUX_PANE`. Those nodes were never touched by
  the probe CR.
- The cost was **not** abstract. The fixing CR's own spec-gate line records `floor: clearance` and
  *"3 frozen scenarios rewritten (2 identity self-recovery generalized to any-mux; 1 surfacing
  narrowed)"* — a mandatory human-ratification stop, one cycle later, in an unrelated mission
  (`packages/cyberlegion/.agents/spec/ledger/herdr-mux-identity.480f64.jsonl` seq:2).
- A sweep for the declared term `tmux` over frozen suites outside the touched set hits
  `unit/registry` (20 mentions), plus identity and surfacing. **True positive on the one case we
  have.**
- It is buildable today on **CR-5's shipped pattern** — `check-retired-terms` is a declared
  registry plus a corpus-wide sweep over tracked files. Same plumbing, different trigger.

**Known limits of C — carry them into the spec rather than discover them later:**

- **False positives are expected, and are the right direction.** `attach.feature` (2 mentions)
  would match and may be noise. The primitive's **own** node matches but sits in the touched set,
  so it is excluded by construction.
- **Recall is partial, and the gap is benign.** `mail/surface/surface.feature` says "a multiplexer
  pane" and matches nothing — but that abstraction is exactly what lets it survive a new adapter.
  The nodes that hardcode the vocabulary are the ones at risk.
- **A primitive with generic vocabulary sweeps badly.** This works because `tmux` is distinctive;
  a ledger field name or a common verb would not be. The rule must say what happens then rather
  than pretend it does not arise.

### Settled, and carried through the re-plan however the details land

- **Containment** — one followup per artifact naming **all** at-risk siblings, never one per sibling.
- **Classification is not overridden** — `backlog` by default; `blocking` only when the sibling
  contradicts a completion claim the mission itself made. No new class, stage, or channel.
- **Handoff does not adjudicate** — it records the risk; it does not verify obsolescence, edit a
  sibling's frozen suite, spawn the Warden, or gate on the result.
- **Placement** — `mission/handoff/` is right; confirmed independently by both cold judges.

### The single-adapter question — considered, does not apply

A constraint that only one multiplexer adapter is live at a time would collapse the adapter case
matrix, and would let sibling specs be written against "the active adapter" instead of `tmux` —
removing the coupling rather than instrumenting it. It does **not** make `D` computable, and it
does not generalize past the adapter family (a ledger schema or a dispatch seam has no such
constraint). Recorded as a sound cyberlegion design move, not a substitute for this CR.

## The gap being closed

A spec gate grades **only its own diff**. A CR that changes a shared cross-cutting primitive can
leave an already-frozen sibling's assumption outrun, structurally invisible to the gate that
approved it. Discovery is otherwise incidental — at a later, unrelated CR, at Clearance cost.

## Scope

- **In:** `.agents/specs/sdd/mission/handoff/README.md` + `handoff.feature` (additive scenarios —
  self-clears, stays `@frozen`).
- **Out:** the shipped `start-mission` SKILL.md and the `automaton` agent (deliver phase); the
  sweep engine itself if open question 3 defers it; anything in `formation/`.

## Adjacent work landed on this branch (not part of the CR)

Both are independent of the `D` ruling and already committed:

- `b54a4f5e` — brought the handoff node to the **four-section spec-format shape** (`## What`,
  `## Control Flow`, `## Scenario map`). The map lint is live for this node and proven so by three
  mutations. **Caveat: that map was backfilled from the suite**, so its coverage claim is circular.
- `8d708e8c` — `.research/cfg-derivation-direction/`, measuring backfilled vs contract-first
  derivation on this node. Two cold blind readers found **6 consensus coverage holes** the
  backfilled map could not have surfaced (single-unit companion; shape-is-a-project-property;
  own-shard/two-pods; the no-follow-ups path; impl-untouched-by-relocation; the outward floor
  *extending* rather than replacing the committed floor), plus 4 contract defects.

**Those holes are a separate concern from CR-6** — do not fold them in. The node is already
oversized (44 scenarios against a 40 threshold; 55 with the R2 draft; 61 if the holes are filled),
which strengthens the case for splitting the follow-up machinery into its own node.

## Leash derivation (ledger shard seq:1)

- floor: none — additive to an already-`implemented` node; no narrowing, no compatibility break.
- blast: low — one behavioral node's prose plus additive scenarios. **Re-derive if open question 3
  puts the sweep engine in this CR** — that would take it past `auto-spec`.
- novelty: low — ratified keep; C reuses a shipped mechanism rather than inventing one.
- confidence: high on the ruling (verified against the motivating incident); medium on the suite,
  which has not survived a judge in any form yet.
- Never write `status`, never a `by: <name>` human ratification, never relay a judge verdict.
