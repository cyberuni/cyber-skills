---
cr-ref: github-387-metaphor-free-check
project: cyberlegion
node: packages/cyberlegion/.agents/spec/metaphor-free
status: in-progress
todos:
  - content: "Intake: read #387, locate cyberlegion spec, scaffold plan, branch sdd/387-metaphor-free-check"
    status: completed
  - content: "Explore: derive the canonical banned-term set + scan scope + allow-list from the 3 recurrences and the metaphor-boundary doctrine"
    status: completed
  - content: "Author: metaphor-free/ node (README + .feature) specifying the mechanical guard's behavior"
    status: completed
  - content: "Author: add the metaphor-free row to the root spec.md capabilities table"
    status: completed
  - content: "Spec gate: self-grill, check-spec-state, five cold sdd-spec-judge rounds to convergence"
    status: completed
  - content: "STOP: emit spec-gate verdict packet (pause) for Council ratification (no human ratification headless)"
    status: completed
  - content: "[Council decision — RATIFIED, relayed] drop bare 'seat'; capitalized-proper-noun-backstop scope; placement stays; markers resolved, spec-gate approve by:agent"
    status: completed
  - content: "Regenerate root spec.md '## By concept' block via project-spec/concept-index (machine-generated; metaphor-free/ facet added)"
    status: completed
  - content: "Deliver: build check:metaphor-free to the frozen suite (sonnet builder); wire a live-tree enforcement test; pnpm verify 35/35 green"
    status: completed
  - content: "Impl gate: cold sdd-impl-judge IMPLEMENTATION_PASS true (8/8 mutation-backstopped); impl-gate approve by:agent"
    status: completed
  - content: "STOP: emit impl-gate verdict packet for Council ratification; commit + prepare PR referencing #387 (do NOT self-ratify or merge)"
    status: in-progress
---

# CR github-387 — mechanize the cyberlegion metaphor-free guard

Source: GitHub issue #387 (cyberuni/cyberplace), filed by the SDD doctrine-loop Scanner from a
recurring-pattern pass. Branch `sdd/387-metaphor-free-check`. **Headless mission — spec gate only.**

## Change request

`packages/cyberlegion` is chartered metaphor-free (root `spec.md`: "carries **no** fleet metaphor and
**no** SDD knowledge; the CLI is pure mechanism"). That boundary has leaked and been caught **three**
times, each time only by a cold spec-judge's manual "metaphor grep" at gate time, never by a
mechanical check:

- **#159 `doorbell-bunker`** — "Bunker" (a cyberfleet place name) leaked into a `mail bunker` command,
  `resolveBunker`, and persona prose. Full revert.
- **#212 `standing-council-inbox`** — the literal word "seat" leaked twice into README non-goals prose
  while writing the very boundary meant to exclude it.
- **#172 `doorbell-focus-gate`** — a "Council" persona-name leak into the doorbell README + `.feature`,
  logged round-1 as "same class as Bunker #159".

A manual grep is not a durable guard — it depends on a judge remembering to look, and it has already
missed three times. Turn the judge's grep step into a mechanical, gate-time check.

## Settled during explore (do not re-derive)

**The metaphor-boundary doctrine** (`reference_cyber_layer_metaphor_boundaries`, charter in root
`spec.md`): the **package** carries ZERO metaphor — generic terms only (`--owner <handle>`, "main
pane", "unit", "pane", "doorbell"), never a persona/place name. `plugins/cyberlegion` owns the
**Legate** routing brain; `plugins/cyberfleet` owns the **fleet personas** (Operator, Council, Pod)
and the **Bunker** place. Persona/place naming belongs in the plugins, never the package.

**Canonical banned-term set — derived, NOT invented** (from the 3 recurrences + the doctrine's own
named personas/places): `Bunker`, `Council`, `Operator`, `Pod`, `seat`. Specified as a **maintained**
list seeded from the corpus's own non-goals sections + the doctrine — extensible, not a manufactured
taxonomy. (Two list-shape questions carried to Council: see the verdict packet.)

**Scan scope**: tracked files under `packages/cyberlegion/` — package `src/` **and** the `.agents/spec/`
doc tree (README + `.feature`) — since the three leaks span code (#159) and docs (#212, #172).
**Excluded**: the ledger (`.agents/spec/ledger/`) and the spec-node frontmatter gate-history/approval
prose, which record past leaks verbatim ("metaphor grep clean", "same class as Bunker #159") as
provenance, not live vocabulary; and the allow-list definition itself.

**Allow-list (sanctioned boundary references)**: the check flags only **unsanctioned** occurrences. A
handful of legitimate occurrences are sanctioned — the charter sentence naming the cyberfleet layer to
declare the boundary, non-goals lines that hand a persona to the plugins, and an outward-caller
reference ("the Legate routing brain composes this"). Adding a sanctioned reference is an explicit,
reviewable edit — the mechanism, not the site, is specified.

## Node placement

`packages/cyberlegion/.agents/spec/metaphor-free/` — a behavioral node specifying the guard's behavior,
placed in the cyberlegion tree per the mission brief. It specifies an **enforcement invariant** of the
package, not a runtime CLI capability like its siblings — flagged to Council in the verdict packet.

## Spec-gate outcome — PAUSED for Council (verdict packet emitted)

Converged over five cold spec-judge rounds (see ledger shard `github-387-metaphor-free-check.b4e91c.jsonl`
seq 2). Final: oracle PASS, architect PASS, builder content-PASS; ALIGNED false **only** on the two
reserved `<!-- open: council-decision -->` markers. No status advanced, no human ratification written
(headless). Root `spec.md` frontmatter untouched (its `implemented`/#339 approval preserved).

### Council must ratify (both block Draft → Approved; markers in metaphor-free/README.md)
1. **Drop bare "seat"** from the mechanical banned-term list. The #212 recurrence leaked lowercase
   "seat"; the capitalized-proper-noun design cannot catch it. Recommend **accept** — "Council" catches
   the "Council seat" construction, and banning bare "seat" floods on generic English. Residual: a
   "seat" leak with no adjacent "Council" stays a review-time catch. (Note: the issue #387 text lists
   "seat" as banned-term material, so dropping it is a deliberate narrowing reserved to Council.)
2. **Ratify the guard as a capitalized-proper-noun BACKSTOP**, not a total metaphor detector. All three
   recurrences were capitalized names; a lowercase prose-sense metaphor stays review-time judgment.
   Alternative: a broader case-insensitive + baseline-allow-list design (higher false-positive + churn).

### Non-blocking observation for Council (architect)
**Node placement.** `metaphor-free/` specifies an enforcement invariant, not a runtime CLI verb like
its siblings. Placed in the cyberlegion tree per the mission brief. Council may confirm, or relocate the
guard's spec to cyberplace repo tooling / a project-spec check.

## Deliver + impl-gate outcome — DONE (impl-gate approve by:agent; ledger seq 4)
Council's decisions were relayed and applied (markers resolved, spec-gate approve by:agent, seq 3).
Built `check:metaphor-free` (a sonnet impl-producer): `src/metaphor-free.ts` (matcher + scan + banned
list + two whole-file exclusions + per-term allow-list), `src/check-metaphor-free.ts` (CLI), and
`src/metaphor-free.test.ts` (8 scenario-bound tests + an 11-case matcher truth table + a **live-tree
enforcement test** that runs the guard over the real package on every `pnpm test`). Regenerated the
By-concept block. Cold sdd-impl-judge: IMPLEMENTATION_PASS true, 8/8 mutation-backstopped, no
absorption, scope clean. Root `pnpm verify` 35/35 green.

## Follow-ups (recorded)
- **By-concept regeneration** — DONE this session (`metaphor-free/` facet added by the concept-index
  engine, not hand-edited).
- **CI wiring location** — the live-tree enforcement now runs the guard in `pnpm test` → `verify` → CI.
  The frozen spec left the exact slot unpinned; Council may relocate it (e.g. a standalone `check:ci`
  step) if preferred. Recorded here; a headless automaton cannot file a forge issue.

## NEXT

The human impl gate: Council ratifies the impl at the PR (this agent wrote `by: agent` only — the
`by: <human>` ratification and the merge are the channel-holding position's, not forgeable from a
relay). PR referencing #387 is prepared (not merged). On merge, root `spec.md` stays `implemented`
and this node's contract + guard are live.
