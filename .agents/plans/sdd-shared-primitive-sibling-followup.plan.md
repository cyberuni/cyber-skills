---
cr-ref: sdd-shared-primitive-sibling-followup
status: draft
leash: auto-spec
blast: low
todos:
  - id: intake
    status: completed
    note: CR opened against the sdd project spec; leash derived (auto-spec, ledger seq:1); plan scaffolded. Headless — stop at the spec gate for Council.
  - id: confirm-placement
    status: completed
    note: CONFIRMED mission/handoff/. formation/ non-goals explicitly exclude a single mission's own scope, and formation structurally cannot do this — its input is what the corpus IS, never what a mission DID; the touched set exists only inside the mission. Both cold judges agreed independently.
  - id: author-spec
    status: completed
    note: Two drafts authored. R1 draft — closed-form rule keyed on "touched" + "depends on"; 9 additive scenarios. R2 draft — trigger narrowed to "changed the artifact's behavior", D re-anchored to "frozen scenarios assert behavior the artifact realizes"; 11 additive scenarios. Both drafts are on the branch, unfrozen.
  - id: spec-gate
    status: blocked
    note: TWO cold sdd-spec-judge rounds, both blocked, ALIGNED false on all three lenses both times. Round 2 named two of its blockers as REGRESSIONS from round 1's remediation, which under remediation-governance stops the loop for a re-plan rather than a round 3. NOT self-asserted; no gate line written (a pause on an already-passed spec gate is an illegal tuple). Council owes the re-plan ruling below.
  - id: replan-D-decision
    status: pending
    note: Council must rule Option A / B / C for how D is determined before any round 3. See "Where it stopped".
---

# CR-6 — a shared-primitive CR files a sibling followup

Ratified doctrine KEEP from the full-backlog retro (parent plan
`doctrine-strategy-keep-or-cut.plan.md`, todo `queued-ratification-backlog`, row **CR-6**).
Source: cyberlegion ledger shard `strategy.dae416.jsonl` seq:1 (Scanner, `ratified: false`).

Do **not** re-litigate the keep. Codify it **narrow**, and route it through the **existing**
followup channel — inventing a second channel is the failure this CR exists to avoid.

## NEXT — resume here

**STOPPED at the spec gate, blocked, awaiting a Council design ruling.** Two cold spec-judge rounds
both returned `blocked` / `ALIGNED: false`. Round 2 named two of its blockers as **regressions**
introduced by round 1's own remediation — `remediation-governance` stops the loop for a **re-plan**
at that point rather than another round, so no round 3 was run.

Nothing here is self-asserted and nothing is frozen. The branch carries the round-2 draft
(11 additive scenarios, `0 modified / 0 removed`, suite still `@frozen`, `pnpm verify` 35/35,
`check:spec` 6/6). **Resume by ruling the `D` question below, then re-authoring — do not patch the
current draft.**

## Post-rebase status (rebased onto origin/main, 56 commits)

Rebase was **clean, no conflicts**; `pnpm verify` 35/35, `check:spec` 6/6, suite still
`11 added / 0 modified / 0 removed` against the new base. Three things changed underneath:

- **CR-3 did not collide.** It landed on `mission/conductor` (the execution-state sibling of the
  correction-line finalize backstop), **not** on handoff — `.agents/specs/sdd/mission/handoff/` has
  no commits on main since this CR branched. The scoping caution in this brief was correct but moot.
- **The queue moved: 5 of 7 KEEPs are shipped** (CR-1, CR-2, CR-3, CR-5, CR-7). Only CR-4 (paused at
  its spec gate) and this one remain.
- **Blocker 2 still stands.** The `followup` line schema on main still carries no origin or
  provenance field, so `derived` remains unobservable.

**What this changes for the ruling — a possible Option C′.** CR-5 shipped `check-retired-terms`, a
corpus-wide guard engine wired into the root check chain. That is a live precedent for the
**plumbing** Option B/C needs, and it lowers that half of the cost materially. It does **not** touch
Blocker 1, which is a *definition* problem, not a wiring one: `check-retired-terms` greps for a
**lexical** term, while `D` as specified is a **semantic** relation ("frozen scenarios assert
behavior the artifact realizes") that no grep can compute. The opening it does create is a bounded
lexical proxy — *frozen `.feature` files in this project that name the artifact* — which is
computable today on the shipped pattern, at a precision cost that would have to be accepted
explicitly rather than discovered later. Council's call; recorded here, not adopted.

The ADR-0021 cross-reference resolver Option B depends on is still **unbuilt** — confirmed on the
rebased tree.

## The gap being closed

A spec gate grades **only its own diff**. So a CR that adds or changes a **shared cross-cutting
primitive** can silently outrun an **already-frozen sibling** node's assumption, and that is
structurally invisible to the gate that approved it. Today nothing at handoff derives that risk;
discovery is incidental, at a later unrelated CR.

Recorded evidence (source line): a prior cyberlegion CR added herdr support to the session/wake
primitive and never reconciled the already-frozen tmux-only identity/surfacing suites — the
author's own words, *"CR-4 should have kicked a Warden finding against identity/session and did
not (unfiled Warden follow-ups are a recurring pattern here)"*.

## The rule as it stood at the stop (round-2 draft — NOT frozen, NOT approved)

> At handoff, for each artifact whose **behavior this mission changed**, let `D` be the set of spec
> nodes that are **outside this mission's touched set** and whose **frozen** scenarios assert
> behavior that artifact realizes. Handoff identifies **one** follow-up for that artifact when `D`
> is non-empty; when it is empty, none. The line names the artifact, the sibling nodes, and the
> assumption at risk.

Round 1's formulation (keyed on "touched" + "depends on") is superseded — it fired on a pure `git mv`
and defined `D` by a relation ADR-0021 splits into four kinds. The round-2 formulation above is the
one the judge killed on **computability**, not on shape: see "Where it stopped".

Settled and worth keeping through the re-plan, whichever option Council rules:

- **Containment** — one followup per artifact naming **all** at-risk siblings, never one per sibling.
- **Classification is not overridden** — `backlog` by default, `blocking` only when the sibling
  contradicts a completion claim the mission itself made. No new class, no new stage, no new channel.
- **Handoff does not adjudicate** — it records the risk; it does not verify obsolescence, edit a
  sibling's frozen suite, spawn the Warden, or gate on the result.
- **Placement** — `mission/handoff/` is right, confirmed independently by both judges.

## Scope

- **In:** `.agents/specs/sdd/mission/handoff/README.md` (follow-up subsection) +
  `handoff.feature` (additive scenarios — self-clears, stays `@frozen`).
- **Out:** the shipped `start-mission` SKILL.md and the `automaton` agent (deliver phase);
  any new mechanical check; anything in `formation/`.

## Leash derivation (recorded to ledger shard seq:1)

- floor: none — additive to an already-`implemented` node; no narrowing, no compatibility break,
  no conflict.
- blast: low — one behavioral node's prose plus additive scenarios; removes no behavior.
- novelty: low — ratified keep; reuses an existing channel rather than adding a mechanism.
- confidence: high — the rule is stated closed-form above and the over-fire cells are enumerated.
- Headless: self-assert the spec gate `by: agent`, STOP for Council. Never write `status`, never
  a `by: <name>` human ratification, never relay a judge verdict.

## Where it stopped — the two design blockers

The two rounds converged on one thing: the ratified keep says *"file a followup **naming the
siblings** it may obsolete"*, and **naming the siblings requires computing `D`** — the set of
at-risk sibling nodes. Every formulation of `D` tried so far fails one of two ways.

**Blocker 1 — `D` has no definition procedure.** Round 1 killed `D` = "nodes that *depend on* the
artifact": ADR-0021 rules that "dependency" is **four** distinct relations here, and one of them
(runtime invocation) *"never touches the spec-graph"* — which is precisely the relation the prose's
"consumed from anywhere" was reaching for. Round 2 killed the replacement `D` = "nodes whose frozen
scenarios assert behavior the artifact realizes": it is unbounded (no project boundary, and
explicitly not folder-local), there is no index and no mechanical check, and **every scenario's
`Given` hands the asserting nodes to the fixture already named — so nothing tests discovery**,
neither precision nor recall. Two implementers cannot build the same `D`. It also installs a
corpus-wide semantic search inside the one phase whose own spec says *"a full corpus scan on every
mission landing is costly and noisy"* — the stated reason handoff **nudges** the Warden instead of
spawning it.

**Blocker 2 — `derived` is not observable.** The `followup` line schema
(`sdd:combat-log-governance`) carries `kind / seq / cr / class / contradicts / evidence` and **no
origin or provenance field**; none of the corpus's real `followup` lines carries one. The CR makes
that indistinguishability *deliberate* ("no new stage, no new class, and no second channel"). So the
negative scenarios' `Then no **derived** followup line names that artifact` names no artifact a
verifier can read — and it still collides with the frozen `every identified follow-up is recorded`
scenario on a constructible snapshot. Verified first-hand against the schema, not taken from the judge.

## The ruling Council owes — how is `D` determined?

| Option | Shape | Cost |
|---|---|---|
| **A — nudge-shaped** | handoff records a followup naming the **changed shared artifact and the claim at risk**, and does **not** name siblings; identifying them is left to the formation Warden, which already holds the corpus-wide lens | computable today, dissolves **both** blockers (nothing to discover, nothing to partition — the line is a normal followup), stays inside `blast: low` and handoff's non-adjudicating stance. **Weakens the ratified keep**, which says *naming the siblings* |
| **B — mechanical `D`** | build/consume the **cross-reference resolver** ADR-0021 rule 5 already specifies as the engine that *"enumerates what the Warden must reconcile"* | makes `D` decidable and the scenarios testable — the honest realization of the keep as written. But the resolver is an **unbuilt follow-up CR** in ADR-0021's implementation notes: this becomes a multi-node CR with an engine, far past `blast: low` / `auto-spec` |
| **C — bounded `D`** | keep the derive shape, but bound `D` to **one project spec** and to nodes the mission's own touch-set analysis already surfaces | cheaper than B, and would have caught the source incident (a cyberlegion primitive vs cyberlegion siblings — same project). Still needs a discovery scenario, and silently misses the cross-project case |

Blocker 2 is dissolved outright by A; under B or C it needs its own call — either an **origin field
on the `followup` line** (which widens the CR into `combat-log-governance`) or negative scenarios
rephrased so they never have to partition derived from identified lines.

## Round-2 findings not yet actioned (carry into the re-plan)

- The node's **Subject** (README ~L20-23) still says handoff carries the mission's *identified*
  follow-ups — the new subsection opens by denying exactly that. Amend the Subject and Non-goals.
- The README cell explaining the unfrozen case imports a **per-node lifecycle status** (`draft` /
  `deprecated`); `sdd:lifecycle-governance` says lifecycle frontmatter is **root-`spec.md`-only** and
  a node carries only its `spec-type` marker. The scenario (`has an unfrozen suite`) is right; the
  prose is categorically wrong.
- **Absorption:** the convergence scenario's own-folder/unrelated-folder apparatus appears verbatim
  in the README prose. Each must draw from a domain the other does not probe.
- The same-channel scenario asserts a **drain** outcome under a non-drain `When`, duplicating a
  frozen scenario's edge and carrying two unrelated `Then`s.
- **Step-library fragmentation:** one scenario splits the state into three steps where five others
  bundle the same state into one.
- **Open question for Council, not a finding:** the root `spec.md` is `status: implemented`, and the
  lifecycle has no `implemented → approved` edge. The corpus precedent for an additive CR
  (`sdd-rule1-fold-closed-form`) records a ledger `gate` line and advances **no** status. Confirm
  that is the intended reading before any round 3 records a gate line.

## Pre-flight debt (both rounds)

Round 1 flagged six governances undeclared, round 2 flagged two (`sdd:spec-format-governance`,
`sdd:gate-validation-governance`). Loading `gate-validation-governance` at the stop is what
established that **no `gate` line may be written here** — a `pause` on an already-passed spec gate is
an illegal tuple. `spec-format-governance` is still unloaded; it owns the `## Control Flow` +
`## Scenario map` sections this node lacks, which is why `check-suite`'s map-binding lint is skipped
and a green `check:spec` is **not** coverage evidence for this diff.
