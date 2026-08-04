---
cr: scanner-distilled-detection
source: local
project: sdd
status: draft
todos:
  - content: "Intake: locate the Scanner node, confirm the gap (no pre-draft distilled-detection contract)"
    status: completed
  - content: "Explore: author the idempotent-distillation rule + additive scenarios; grill with cold spec-judge"
    status: completed
  - content: "Spec gate: freeze touched .feature (additive self-clear); emit verdict packet, STOP for Council"
    status: completed
  - content: "Deliver: teach doctrine-loop SKILL + sdd-scanner agent to reuse distilledCrRefs; verify per frozen scenario; pnpm verify; rebase onto main"
    status: completed
  - content: "Impl gate: cold impl-judge over the frozen scenarios; commit the CR unit; emit verdict packet, STOP for Council"
    status: completed
---

# scanner-distilled-detection — the Scanner detects an already-distilled mission by PARSING the ledger, never grepping

The doctrine-loop Scanner's Ship/Kill trigger fires at `→ implemented`. Before drafting, it must
detect whether that mission was **already distilled** (a prior `strategy` line with
`distills == <cr-ref>`) so it does not re-draft. In the latest run the Scanner's first-pass
detection used a strict **no-space JSON substring grep** (`"distills":"<cr-ref>"`) which **silently
missed pretty-printed ledger entries** (`"distills": "<cr-ref>"`, space after the colon), nearly
re-drafting two already-distilled findings (`github-263-op6-m1`, `263-op6-m2`). Same defect class as
the standing lesson *grep is blind to wrapped terms*. Tooling-correctness fix, not a strategy call.

## Target (revise)

- `.agents/specs/sdd/doctrine/scanner/README.md` — behavioral node spec; add the idempotent-distillation contract
- `.agents/specs/sdd/doctrine/scanner/scanner.feature` — **@frozen**; new scenarios are **additive** (self-clear, stays frozen)
- (deliver, out of scope this mission) `plugins/sdd/skills/doctrine-loop/SKILL.md` + `plugins/sdd/agents/sdd-scanner.md` — the shipped procedure/agent

## Verified at intake (not asserted)

- The correct JSONL parser **already exists**: `distilledCrRefs()` in
  `plugins/sdd/skills/plan-retirement/scripts/retire-plans.mts` reads each ledger line via
  `JSON.parse`, keys on the structured `distills` field of `kind: strategy` entries, tolerates
  malformed/blank lines, and ignores `evidence`-only cross-refs. It is **only wired into
  `plan-retirement`'s DELETE sweep**, not the Scanner's pre-draft check.
- The `plan-retirement-distill-gate` CR (ledger shard) built that `distills` field + engine gate, and
  added scanner.feature scenarios for **recording** `distills` on Ship/Kill — but **specified no
  pre-draft distilled-DETECTION** and no parse-method contract. So the gap is genuinely open: the
  Scanner's idempotency check is unspecified, which is exactly where the free-hand grep crept in.

## Fix classification

**Procedure-doc change** (the doctrine-loop procedure + sdd-scanner agent + this node's contract).
**No engine correctness change**: the JSONL parser already exists and is already correct; the Scanner
must be made to **reuse that parse contract** (ideally the `distilledCrRefs` engine) rather than
hand-roll a substring grep. A deliver-phase engine touch to expose `distilledCrRefs` as a standalone
affordance the Scanner invokes is optional, not a correctness fix.

## NEXT

**STOPPED at the impl gate for Council ratification** (headless automaton — not merged, not
self-ratified). Both gates passed the cold judges; the two accountable human writes are OWED to the
in-session channel-holder (a relayed ratification is not written by a headless agent):

1. **Spec gate** — `by:<council>` ratification of the queued `by:agent` self-assert (ledger `seq:2`),
   and advance `status` past draft. (The Council RATIFY was relayed by the coordinator; recorded as a
   `report` in the combat log, not transcribed into a `by:<name>` line.)
2. **Impl gate** — `by:<council>` ratification of the queued `by:agent` verdict (ledger `seq:4`), then
   `status: implemented` and **merge** the CR commit.

Provenance — ledger shard `.agents/specs/sdd/ledger/scanner-distilled-detection.a20c41.jsonl`:
`leash` (auto-spec), spec `gate seq:2` (by:agent), backlog `followup seq:3`, impl `gate seq:4`
(by:agent). Corrections + relay report in `scanner-distilled-detection.log.jsonl`.

**Delivered (doc-only, no engine correctness change):** `plugins/sdd/skills/doctrine-loop/SKILL.md`
and `plugins/sdd/agents/sdd-scanner.md` now teach the Scanner to run the pre-draft distilled-detection
by reusing `plan-retirement`'s `distilledCrRefs` (JSONL parse), never a substring grep. Committed as one
unit on top of `main` (b68a4fa6). Cold impl-judge IMPLEMENTATION_PASS (mutation-backstopped), root
`pnpm verify` 35/35.

**Pre-merge items for the channel-holder:** (a) a changeset may be owed for the `plugins/sdd` version
bump (18 pending; not added here — deferred to the merge decision); (b) push the branch + open the PR
(no GitHub issue — local-sourced CR; reference the doctrine-loop provenance).

**Open (non-blocking) followup:** add a blank-line-tolerance scenario (ledger `seq:3`).
