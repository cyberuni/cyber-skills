---
cr-ref: github-339
target-project: cyberlegion
blast: medium
hitl: true
leash: auto-spec
tier: opus
todos:
  - content: "intake — plan scaffolded; target project cyberlegion; ledger leash line written"
    status: done
  - content: "explore — retargeted spec+suite to CYBER_MUX; spiked cyber-mux 0.3.0; added What/CFG/scenario map"
    status: done
  - content: "spec gate — 4 cold judge rounds, R4 ALIGNED true; Clearance granted live; gate seq 2"
    status: done
  - content: "deliver — add cyber-mux dep, retarget 14 import sites, delete src/console except doorbell"
    status: pending
  - content: "impl gate — per-scenario verification + a REAL tmux spawn round-trip"
    status: pending
  - content: "handoff — PR against main, Closes #339"
    status: pending
---

# CR github-339 — cyberlegion consumes cyber-mux instead of forking it

CR link: https://github.com/cyberuni/cyberplace/issues/339
Node: `packages/cyberlegion/.agents/spec/mux/` (behavioral, concept `cyberlegion`).

## Scope — this CR is #339's M3 + M4 only

#339 plans four missions. **M1 and M2 already landed upstream**: `cyber-mux@0.3.0` ships the
library barrel, the multi-entry `exports` map (`.`, `./worktree`, `./template`), `dts`, and
`envPrefix` on `probeMultiplexer`. Nothing upstream blocks this CR.

- **M3** — add the dep, retarget every import site, delete the forked `src/console/`.
- **M4** — retire the env-namespace drift (`CYBERLEGION_MUX*` → `CYBER_MUX*`).

**Out of scope, filed as follow-ups:** widening `PaneMux` to wezterm/zellij (#339 open question 3 —
`AgentRecord.pane.mux` is a persisted union, so widening is its own CR); the template engine
(#339 open question 4).

## The two load-bearing decisions — ratified live by the owner

1. **Migrate to the `CYBER_MUX` namespace** (not `envPrefix` compat). Chosen over keeping
   `CYBERLEGION_MUX` with `envPrefix`, and over blocking on a further upstream change. The owner
   selected the option whose statement named the frozen-scenario rewrite and the Clearance floor —
   that selection **is** the pre-authorization.
2. **No new issue filed** — #339 already covers this exactly.

### What decision 1 costs

`mux/README.md` and `mux.feature` name `$CYBERLEGION_MUX` / `$CYBERLEGION_MUX_PANE` as observable
behavior (`mux doctor` prints the pin hint; `unit spawn` propagates the vars). Retargeting them is a
**rewriting edit to frozen scenarios** — classify structurally with `gherkin-cli diff`, take the
re-open, record the Clearance grant.

**Live panes already carry the old vars** (#339 M4 names this). A transitional read-both normalizes
`CYBERLEGION_MUX*` → `CYBER_MUX*` when only the old pair is set, so a session spawned before this
lands keeps its identity. Transitional and separately deletable.

## The seam — measured

`src/console/` is a stale fork; cyber-mux is a strict superset. Mapping:

| cyberlegion | cyber-mux |
|---|---|
| `SessionAdapter` / `SessionTarget` / `SessionPlacement` | `MuxAdapter` / `MuxTarget` / `MuxPlacement` |
| `selectSessionAdapter` | `resolveMuxAdapter` (+ `resolveMux`, exec pre-bound) |
| `session.tmux.ts` / `session.herdr.ts` | `mux.tmux.ts` / `mux.herdr.ts` |
| `adapter.send` | `adapter.sendText` |
| `adapter.openInNewWorktree?` | `adapter.worktree?.createInWorkspace` |
| `mux-probe.ts` / `nudge.ts` / `worktree.ts` | same names, same shapes |

`Exec` is structurally identical — adopt cyber-mux's outright (#339 M3: "preferred: one seam").

**Stays in cyberlegion:** `src/console/doorbell.ts` — mail/brief/turn-taking semantics, not mux
semantics. #339 §2 and cyber-mux's own boundary statement both exclude it.

### Free fix this buys

cyber-mux's tmux `split-window` passes `-t <caller pane>`; the fork does not, so a `--at pane:right`
spawn today splits the session's *active* pane rather than the calling one. Pass
`from: callerPane(...)` on adoption.

## Consumers to retarget

`src/cli.ts`, `src/session.ts`, `src/identity.ts`, `src/decommission.ts`, `src/paths.ts`,
`src/runtime/inject-inbox.ts`, `src/console/doorbell.ts`, and the public façade `src/index.ts`
(`cyberfleet` is the in-repo consumer — it must still typecheck).

## Controls that must survive

- A **real** tmux open/send/read/close round-trip — the fleet runs live units against this seam.
- Deleted files' tests are **accounted for**, not dropped: each has a cyber-mux equivalent or moves.
- `pnpm verify` (typecheck + lint + test + test:audit) green before any commit.

## Spec gate — passed (round 4 ALIGNED true)

Four cold judge rounds. What they cost, so the next mission does not repeat them:

1. **Pre-flight miss** — declared 1 of 7 governance bars; judge short-circuited without grading.
2. **Precedence-tier contradiction** — adding the legacy tier to a first-match-wins chain without
   re-auditing the lower-tier siblings' `Given`s produced a constructible state on which three
   scenarios disagreed. *Rule: a new tier obliges re-auditing every sibling below it.*
3. **Duplicated sibling fact** — restated `unit/registry`'s storable set instead of referencing it.
4. **Section order** — remediation 3 appended the new sections after a pre-existing one, wedging an
   unsanctioned section into the mandated order.

The node gained `## What`, `## Control Flow` (a Mermaid CFG of the precedence chain), and a 1:1
`## Scenario map` over all 26 scenarios — accepted from the judge's argument that the missing map is
what let defect 2 hide. The map check is **ablation-verified binding**: dropping a row fails
`scenario is not on the scenario map`; duplicating an edge+path fails `duplicate map pair`.

Also retargeted three prose lines on `unit/registry/README.md` so the corpus does not document two
different current namespaces (prose only — that node's `.feature` never named the vars).

## Deliver — the implementation contract now frozen against

- Add `cyber-mux` (pinned) to `packages/cyberlegion/package.json`.
- Normalize env ONCE at the boundary: map `CYBERLEGION_MUX*` → `CYBER_MUX*` when only the legacy pair
  is set. Spiked and confirmed necessary — the package's `probeMultiplexer` takes an `envPrefix` but
  its `currentPane` does not, so one normalization seam covers both uniformly.
- Retarget the ~14 import sites; adopt the package's own `Exec` seam (#339 M3: "preferred: one seam").
- Guard the selector: refuse a detected backend outside `{tmux, herdr}` naming it, BEFORE opening —
  the package detects four and `AgentRecord.pane.mux` stores two.
- Pass `from: callerPane(...)` on `pane:*` placements.
- Delete `src/console/` except `doorbell.ts`; account for every deleted test rather than dropping it.

## NEXT

Deliver. Verify a REAL tmux spawn round-trips before the impl gate — unit tests alone do not
discharge the "the fleet runs live units against this seam" control.
