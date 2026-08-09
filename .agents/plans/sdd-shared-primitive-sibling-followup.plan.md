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
  - id: retract-r2
    status: completed
    note: Commit bf9310bb. Withdrew the 11 R2 scenarios, their map section, the R2-shaped CFG branch, and the R2 prose. Needed as its own commit because align-spec diffs the working tree against HEAD, and HEAD carried this CR's own unratified draft — so any removal reads as a Clearance narrowing until it lands. Not a real narrowing: main has none of the 11.
  - id: author-spec-c
    status: completed
    note: Commit d224512a. 8 scenarios, closed form stated before the CFG was drawn, each conjunct its own decision node. All three open questions closed and all four carried defects cleared — see "Resolved decisions". check:spec + pnpm verify green; align-spec reports no drift (additive, self-clears).
  - id: spec-gate-c
    status: in_progress
    note: Cold sdd-spec-judge. Pre-flight declared: spec-producer, suite-format, spec-format, oracle-spec, builder-spec, architect-spec, lifecycle, combat-log, resolve-governances.
---

# CR-6 — a shared-primitive CR files a sibling followup

Ratified doctrine KEEP from the full-backlog retro (parent plan
`doctrine-strategy-keep-or-cut.plan.md`, todo `queued-ratification-backlog`, row **CR-6**).
Source: cyberlegion ledger shard `strategy.dae416.jsonl` seq:1 (Scanner, `ratified: false`).

Do **not** re-litigate the keep, and do **not** re-open the `D` question — Council ruled it
(below). Codify it narrow, and route it through the **existing** followup channel.

## NEXT — resume here

**Next action:** run the **cold `sdd-spec-judge`** over the C spec + suite. The spec is authored and
committed (`bf9310bb` retraction, `d224512a` the C derivation); nothing is frozen beyond the
pre-existing file freeze, no gate line is written, and no verdict is self-asserted.

If the judge blocks: this is **round 3 on the node but round 1 on the C rule** — the R2 loop's
regression stop does not carry over, because the rule under test changed. Remediate under
`remediation-governance` as a fresh loop.

**The C rule as shipped, closed form:**

> `D` = { node `N` : `N`'s suite carries a term the primitive declares it owns, **and** `N` is
> outside the mission's touched set, **and** `N`'s suite is `@frozen` }

One follow-up per primitive when `D` is non-empty; none when empty. Each conjunct is its own
decision node, so each mutation of the rule breaks a distinct scenario.

**Pre-flight, discharged.** Round 1 flagged six undeclared governances, round 2 two. The set was
resolved mechanically this time (`resolve-governances --artifact-type spec`) rather than
hand-enumerated, and loaded before a line was written: `spec-producer-governance`,
`suite-format-governance`, `spec-format-governance`, `oracle-spec-governance`,
`builder-spec-governance`, `architect-spec-governance`, `lifecycle-governance`,
`combat-log-governance`. `gate-validation-governance` was loaded at the round-2 stop and is what
established that **no gate line may be written here**.

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

### The three open questions — closed while authoring

1. **Is `derived` observable? — the question dissolves.** The word is not asserted anywhere. Once
   handoff identifies a sibling follow-up it **is** an identified follow-up; record, classify,
   propose and drain draw no distinction, so the `followup` line needs **no origin field** and
   `combat-log-governance` is untouched. The negatives assert *"no followup line naming the
   primitive is appended"*, with a `Given` that pins the mission's own identified follow-up to an
   unrelated subject — observable, and no schema widening.
2. **Where the declared vocabulary lives — out of scope, deliberately.** The terms reach handoff as
   an **input**, beside the touched set and the identified follow-ups. Naming a concrete registry
   path would either fail `check-spec-state`'s referenced-artifact check (the file does not exist)
   or drag the engine in. Recorded in the node's prose as an out-of-scope question belonging with
   the engine — **not** an `<!-- open: -->` marker, which would block the gate.
3. **The sweep engine ships in a sibling CR.** This node specifies the *decision*; the matcher that
   walks tracked suites is a separate capability on CR-5's shipped pattern. Keeps `blast: low` /
   `auto-spec` intact, exactly as the leash derivation anticipated.

### The four carried defects — cleared

- **Subject** now says handoff carries the mission's follow-ups *and the one class it identifies
  itself*, rather than only the identified ones.
- **The unfrozen guard** keys on the suite file's `@frozen` tag. The prose says so outright: a
  capability node carries no lifecycle status of its own, the project has one lifecycle on the root
  `spec.md`. The illegal `draft`/`deprecated` per-node reading is gone.
- **The absorption is gone with the rule.** Location never enters the C rule, so the
  "own folder vs unrelated folder" convergence scenario and its verbatim README twin both went.
  Checked: the new `Given` apparatus (a rate-limit primitive owning `token-bucket`) appears
  nowhere in the README.
- **The same-channel scenario** no longer asserts a drain outcome under a non-drain `When`. It is
  now a classification-convergence scenario: `When handoff classifies the follow-ups`.

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
