---
cr-ref: sdd-shared-primitive-sibling-followup
status: ratified
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
    status: completed
    note: PASSED. Cold sdd-spec-judge, ALIGNED true, oracle/builder/architect all PASS, no blocker, no failing scenario, no content gap. Round 1 on the ruled rule (the two prior rounds' rules were struck). Self-asserted by:agent within the auto-spec leash; durable gate line at ledger seq:2; status NOT written. First dispatch blocked at pre-flight over a missing gate-validation-governance declaration — logged as a judge-iteration correction (combat log seq:5, off-enum cause flagged cause-candidate).
  - id: council-ratification
    status: completed
    note: RATIFIED by unional, in-session, positionally. approval.spec rewritten by:agent -> by:unional (cause + why retained, matching CR-5's ratified record in the same file); ratified gate line appended at ledger seq:3, append-only, leaving the provisional seq:2 standing. status deliberately NOT written — see "Resolved decisions". check:spec 6/6.
---

# CR-6 — a shared-primitive CR files a sibling followup

Ratified doctrine KEEP from the full-backlog retro (parent plan
`doctrine-strategy-keep-or-cut.plan.md`, todo `queued-ratification-backlog`, row **CR-6**).
Source: cyberlegion ledger shard `strategy.dae416.jsonl` seq:1 (Scanner, `ratified: false`).

Do **not** re-litigate the keep, and do **not** re-open the `D` question — Council ruled it
(below). Codify it narrow, and route it through the **existing** followup channel.

## NEXT — resume here

**This dispatch is complete.** The spec gate passed (cold `sdd-spec-judge`, ALIGNED true, all three
lenses PASS) and was **ratified by unional in-session**. The contract is agreed and `@frozen`.

**Next action: land it, then open the deliver mission.** Handoff for this dispatch is the branch
`cyberlegion/unit-c1932c3b4794a682` -> a PR. Nothing else here is owed.

**What is owed NEXT, as separate missions — none of it in this dispatch's scope:**

1. **The deliver phase for this rule.** The contract is frozen but nothing enacts it: the shipped
   `start-mission` SKILL.md step 4 and the `automaton` agent do not identify the sibling follow-up.
   This is the direct follow-on and should be filed first.
2. **The sweep engine.** The matcher that walks tracked suites for declared terms. CR-5's
   `check-retired-terms` (declared registry + corpus-wide sweep over tracked files) is the shape.
   Run its guards against the **tracked** tree — CR-5 self-fired twice on exactly that.
3. **Where the declared vocabulary is stored.** Settled with the engine, not before. A durable
   registry keyed on the primitive beats a per-CR declaration (declare once, no per-mission
   forgetting), but that is a recommendation, not a ruling.
4. **Splitting the node.** `mission/handoff/` is ~52 scenarios against a 40 threshold. The judge
   flagged it, and `.research/cfg-derivation-direction/` independently found 6 consensus coverage
   holes a backfilled scenario map could not surface. Pre-existing; do not fold into CR-6.

**The C rule as shipped, closed form:**

> `D` = { node `N` : `N`'s suite carries a term the primitive declares it owns, **and** `N` is
> outside the mission's touched set, **and** `N`'s suite is `@frozen` }

One follow-up per primitive when `D` is non-empty; none when empty. Each conjunct is its own
decision node, so each mutation of the rule breaks a distinct scenario.

**Pre-flight — round 3's declared set.** Round 1 flagged six undeclared governances, round 2 two,
round 3 **one**. The set was resolved mechanically this time
(`resolve-governances --artifact-type spec`) rather than hand-enumerated:

`spec-producer-governance`, `suite-format-governance`, `spec-format-governance`,
`oracle-spec-governance`, `builder-spec-governance`, `architect-spec-governance`,
`lifecycle-governance`, `combat-log-governance`, **`gate-validation-governance`**.

All but the last were loaded **before** a line was written. `gate-validation-governance` was
**not** — the producer reasoned that loading it at the round-2 stop carried over. It does not: the
judge's pre-flight is `expected ⊆ declared` on **this round's** declaration, and it is deliberately
mechanical, because a producer who skipped pre-flight and one who ran it look identical from the
output. Round 3's first judge dispatch blocked on exactly that, before any lens ran.

Loaded at the gate, and the artifact re-checked against it: **nothing to fix**. Its per-node
`spec-type` checks pass (the node is `behavioral` and has `## Use Cases`; its frontmatter is
`spec-type` + `concept` only, so it carries no root-only lifecycle field), and its legal-state
tuples bind the root `spec.md`, which this CR does not touch. The miss cost a judge dispatch, not a
correction.

**Carry this forward:** the pre-flight is a *per-round* declaration. A governance loaded in an
earlier round of the same CR does not count toward a later one.

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

### Why the gate did not write `status`

`spec-gate`'s verb table says an `approve` writes `status: approved`. It was **not** written here,
deliberately, and the plan's leash said so from the start.

The transition that verb encodes is **Draft -> Approved**. This spec is `status: implemented`, and
this CR never took it to `draft`: the change is **additive** to an already-`implemented` node's
`@frozen` suite, which `lifecycle-governance` says **self-clears** — it widens the contract, cannot
break existing implementation, and folds in under the conductor's authority. There was no
Draft -> Approved transition to perform.

Writing `approved` would have **regressed** the project's lifecycle state, discarding the recorded
fact that the impl gate has passed. `check-spec-state` confirms the tuple is legal as left: status
`implemented`, `approval.spec` ratified, `approval.impl` still carrying CR-5's ratification, and a
durable spec `gate` line in the ledger.

Read the verb table as governing the transition it names, not as an unconditional write.

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
