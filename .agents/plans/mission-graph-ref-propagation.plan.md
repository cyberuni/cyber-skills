---
cr-ref: mission-graph-ref-propagation
target-project: sdd
blast: medium
hitl: true
leash: auto-spec
tier: opus
todos:
  - content: "intake — plan scaffolded; target sdd; node mission-graph; ledger leash line written"
    status: done
  - content: "explore — spike verified 8 git facts; sync contract + scenarios; README/SKILL/ADR/RUNBOOK reconciled"
    status: done
  - content: "spec gate — R1..R8 FAIL; install-refspec cut (R5); migrate seed-retirement added (R8 fixpoint); R9 pending"
    status: in_progress
  - content: "deliver — engine sync verb + migrate seed-retirement + tests; pnpm verify GREEN"
    status: pending
  - content: "impl gate — cold impl-judge, one verification per frozen scenario"
    status: pending
  - content: "handoff — PR against main; no source issue to close"
    status: pending
  - content: "handoff — file `followup` ledger line: re-home the opt-in fetch refspec to sdd:init (separate CR)"
    status: pending
  - content: "handoff — file `followup`: node lacks ## What / ## Control Flow / ## Scenario map (incomplete-node); cost hit twice at gate"
    status: pending
---

# CR mission-graph-ref-propagation — the orphan ref never leaves the machine

CR link: none (direct user request via Pod brief).
Node: `.agents/specs/sdd/mission-graph/` (behavioral, concept `orchestration`).

## The defect — prose/impl contradiction

`refs/sdd/mission-graph` lives outside `refs/heads/*`, and the default refspec is
`+refs/heads/*:refs/remotes/origin/*`. So the ref is **never fetched and never pushed**. Three
tracked artifacts claim otherwise:

- `.agents/specs/sdd/mission-graph/README.md:68,326` — "shared by every working copy of the repo"
- `.agents/specs/sdd/mission-graph/README.md:340` — "a branch-independent home once a fleet runs"
- `artifacts/adr/0026-mission-graph-store.md:161` — "clones, worktrees, and PRs carry the plan"

What actually holds today: shared across **worktrees of one clone** (they share `.git`), and
**nothing** across clones or machines. The fleet's current topology is worktrees of one clone, so
this has not bitten yet — it bites the moment a ship runs on a second machine or a fresh clone.

## Verified git facts (build-to-learn spike, throwaway repo)

| # | Fact | Result |
|---|---|---|
| 1 | `git config --add remote.X.fetch 'refs/sdd/*:refs/sdd/*'` | additive — branch refspec preserved |
| 6 | **forced** `+refs/sdd/*:refs/sdd/*` on a diverged ref | plain `git fetch` prints `(forced update)`, **exits 0**, local append **DESTROYED** |
| 7 | **non-forced** `refs/sdd/*:refs/sdd/*` on a diverged ref | prints `! [rejected] (non-fast-forward)`, **exits 1**, local ref preserved |
| 8 | non-forced push, diverged | rejected, exit 1, remote unchanged |
| 2 | plain `git push` sends `refs/sdd/*` after a fetch refspec is added | **no** — fetch refspec does not affect push |
| 3 | a fresh `git clone` carries the ref | **no** |
| 4 | refspec installed + `git fetch` → ref present, content readable | yes |
| 5 | `remote.X.push` set to the sdd refspec | **hijacks plain `git push`** — printed "Everything up-to-date" while silently NOT pushing the branch commit |

Facts 5 and 6 are decisive, and they are **two separate silent-data-loss traps** — one on each side of
the transport. Both are rejected options, not design choices, and both are barred by a scenario:

- **Fact 5 (push side):** configuring `remote.<remote>.push` hijacks a plain `git push`.
- **Fact 6 (fetch side):** the leading `+` on the fetch refspec means *force*. Installing the forced
  form makes an ordinary `git fetch` destroy a diverged local store ref at exit 0 — defeating the very
  fast-forward-only guarantee this CR specifies. **The non-forced form is the one written, always.**

## Design frozen at explore (revised after spec-gate round 4)

**One verb, one rule, no exceptions.** `install-refspec` was cut — see *Why* below.

1. **`sync` names the ref explicitly on the command line**, both directions:
   `git fetch|push <remote> refs/sdd/mission-graph:refs/sdd/mission-graph`. It therefore needs **no
   git configuration and writes none** (verified: a fresh clone with only the default refspec fetches
   the ref fine when it is given as an argument).
2. **No forced (`+`-prefixed) refspec, ever** (facts 6/7). **`remote.<remote>.push` never written**
   (fact 5). Both are barred by scenarios.
3. **Fast-forward only; diverged is refused, never merged.** The case-by-case behavior is a total
   partition of `(local ref, remote ref)` — **not restated here.** Normative in the node README's
   sync table, mirrored in `SKILL.md` (which must be self-contained at runtime per skill-design).
   This brief is transient; restating the partition here is what made it drift in R3 and again in R6.
4. **Sync is explicit, never implicit on read.** Reads stay local and offline-safe.
5. **A remote it cannot reach is a loud failure**, never reported as "no list there" — conflating the
   two would recreate the exact silent-empty defect this CR exists to remove.
6. **Docs state what actually holds** — README, `SKILL.md`, ADR-0026 Amendment, RUNBOOK.

### Where each fact is normative (one home each, after R6)

| Fact | Normative home | Why not elsewhere |
|---|---|---|
| the 7-case sync partition | node README (contract) + `SKILL.md` (runtime, must be self-contained) | ADR + this brief now *reference* it; 4 copies drifted 4 rounds running |
| *why* refusal beats merging | ADR-0026 Amendment | the decision record's job |
| the operator procedure | RUNBOOK | consumes both, restates neither |

### Why `install-refspec` was cut (spec-gate rounds 2–4)

It wrote a persistent fetch refspec so an *ordinary* `git fetch` would also collect the ref. It added
**no capability** (`sync` already transfers, explicitly and on demand) and carried three costs: it was
the engine's only mutation of a user's git config; once installed, a diverged store ref makes
*unrelated* `git fetch` calls exit 1; and it directly contradicted this node's own central rule that
reach is never implicit. That contradiction is why the reach rule drifted in a **different file each
round** — SKILL.md (R2), this brief (R3), RUNBOOK.md (R4) — a defect the judge classified as
REGRESSING, not converging. Removing it collapses the rule to one statement with no exceptions.

**It is not abandoned:** the opt-in refspec belongs on `sdd:init`, which already exists to onboard
"optional, repo-scoped conveniences" and already asks consent before writing operational config —
giving the CI cost a place to be disclosed at the point of choice. Filed as a `followup` at handoff;
a separate CR, deliberately not bolted onto this one.

Out of scope (settled with the user before intake): the combat log stays in-tree; no store rename to
`sdd/missions`; no third backend; no combined ref.

## The migrate fixpoint (found at spec-gate R8, verified by repro)

`migrate` copied the in-tree seed into the ref but left the seed **tracked**. A tracked seed travels to
every clone, where `resolveBackend` prefers it over the never-fetched ref — so a fresh clone reads a
**stale list that looks valid** and no `sync` can dislodge it (the seed is what stops the clone
consulting the ref). Repro output:

```
upstream: migrate → orphan-ref, seed still TRACKED
fresh clone: orphan ref NONE, seed present → resolveBackend = in-tree, readEvents = 1 stale event
FIXPOINT: CONFIRMED
```

This repo escaped it only because commit `71cd97ec` deleted the seed **by hand** — specified nowhere.
Fix (user's call, in this CR): `migrate` retires the seed as its final act, guarded — never retiring a
seed whose lines the ref does not already carry, and repairing a pre-fix project on a re-run. Deletion
is **staged, not committed**; the migration does not reach other clones until that commit lands.

## NEXT — resume here

**Do this first:** re-run the cold spec-judge (round 9) over the current tree — spawn
`sdd:sdd-spec-judge` scoped to the 5 tracked modifications in `git diff HEAD`. R9 was attempted three
times and died on API 529 each time; nothing about the tree is known-bad. Everything R8 raised is fixed
and pre-verified (below), so R9 is a confirmation round, not a fix round.

On a PASS: freeze the suite (`@frozen` already sits on the file — it never unfroze), write the
`approval.spec` block + the `gate` ledger line to shard
`.agents/specs/sdd/ledger/mission-graph-ref-propagation.4a9e55.jsonl`, set root `spec.md`
`status: approved`, then start **deliver**.

**Deliver is untouched and is the larger half.** `plugins/sdd/skills/mission-graph/scripts/mission-graph.mts`
needs two new behaviors, neither written yet:
1. a `sync` verb (fetch+push by explicit refspec, fast-forward only, the 7-case partition, the two
   prechecks in order: backend then reachability);
2. `migrate` retiring its in-tree seed (guarded — never retire a seed whose lines the ref lacks).
Then tests for all 17 new scenarios, then `pnpm verify` (typecheck+lint+test+test:audit) green, run
from **this worktree**.

### No blocking decisions are open

All three forks were settled with the user and are recorded above — do not relitigate:
- `install-refspec` **cut** and re-homed to `sdd:init` as a separate CR (see *Why `install-refspec` was cut*).
- `migrate` **retires** its seed, in this CR (see *The migrate fixpoint*).
- Out of scope, settled pre-intake: combat log stays in-tree; no store rename; no third backend.

There are no `<!-- open: -->` markers anywhere in the node.

### Verified state at pause — do not re-derive

- Suite edit class: `addOnly: true`, **17 added / 0 modified / 0 removed** ⇒ self-clears, stays
  `@frozen`, **no Clearance owed**. Re-check with `npx gherkin-cli@0.0.2 diff --base HEAD <feature>`.
- The three frozen `migrate` scenarios assert only *ref* outcomes; none says the seed survives — which
  is why seed retirement is additive rather than a narrowing. This was checked against `git show HEAD:`,
  not inferred.
- `check-spec-state --root .` → **0 findings under `.agents/specs/sdd`**. Its 43 findings are all
  pre-existing `artifacts/specs/*` (historical CR-era specs), outside this CR.
- `check-suite.mts` **cannot run in this repo** — it imports `gherkin-cli`, which is not installed
  (npx-only). All coverage assurance so far is judged, not linted. Do not read a green check as coverage.

### Findings the diff will not show

- **The R8 fixpoint was real and reproduced, not argued.** `migrate` copied the seed but left it
  *tracked*; a fresh clone then resolves in-tree and reads a **stale list that looks valid**. It stayed
  invisible for seven judge rounds because this repo escaped it only via commit `71cd97ec`, an
  undocumented hand deletion. Any project migrating without the fix hits it.
- **The gate loop regressed while patching at named sites.** R2→R4 each fixed the reach rule in one file
  and drifted in the next. What broke the cycle was removing the clause that could not be stated
  consistently (`install-refspec`), then reducing the partition from 4 prose copies to 2 (node README +
  `SKILL.md`; the ADR and this brief now reference, never restate). **Keep that allocation** — restating
  the partition here is exactly what drifted in R3 and again in R6.
- **Two judge findings traced back to a missing CFG.** The node has no `## Control Flow` / `## Scenario
  map`, so a 7-state partition shipped as a 6-row table twice. Deferring the backfill is still right
  (re-deriving the whole suite from a CFG is a *rewrite* ⇒ unfreezes ⇒ fires Clearance), but the cost is
  now measured, hence the filed follow-up.

### Working method already settled — do not relearn

The empirically verified git facts are in *Verified git facts* above (8 of them, throwaway repos);
the frozen design is in *Design frozen at explore*; the normative-home allocation is in *Where each fact
is normative*. Spike scripts were scratch-only and are not in the repo — the facts table is the record.
