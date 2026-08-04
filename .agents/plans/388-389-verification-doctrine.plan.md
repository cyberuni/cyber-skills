---
name: 388-389-verification-doctrine
status: in-progress
todos:
  - content: "intake: open CR vs SDD self-spec (plugins/sdd); leash block to ledger shard a7c3f1; plan brief"
    status: done
  - content: "#388 explore: add axis-vs-capability-boundary sanity-check to the Warden split act — formation.feature scenarios + formation/README.md prose"
    status: done
  - content: "#389 explore: add Clearance-repair fails-pre-repair-draft proof — workflows/gate-verdicts.feature scenarios + workflows/README.md seed E9 + spec-gate/README.md prose reference"
    status: done
  - content: "spec gate: cold sdd-spec-judge reached ALIGNED true in round 3 (r1 pre-flight miss, r2 verb-collision BLOCKER, both remediated); edit class additive/self-clearing confirmed"
    status: done
  - content: "emit spec-gate PAUSE verdict packet + STOP for Council ratification (headless: no human ratification, no status advance, nothing frozen this gate); gate line seq2 in shard a7c3f1"
    status: done
  - content: "deliver: two independently-revertable units — #388 axis check (commit f16420bd: formation-loop SKILL + sdd-warden) and #389 Clearance-repair proof (commit 25f8f413: remediation-governance SKILL 5th rule + spec-gate SKILL pointer); pnpm verify 35/35; rebased onto main b68a4fa6"
    status: done
  - content: "impl gate: cold sdd-impl-judge IMPLEMENTATION_PASS on all 8 frozen scenarios; self-asserted by:agent (ledger seq5); STOPPED for human ratification + merge"
    status: done
  - content: "OWED TO CHANNEL-HOLDER (not the automaton): human ratification (by:<name>), the merge, and any PR/push — the positional act I cannot perform on a relay"
    status: pending
---

# CR 388-389-verification-doctrine — codify two verification-method lessons into SDD doctrine

Target project spec: `plugins/sdd` (the SDD self-spec at `.agents/specs/sdd/`).
Source: GitHub issues #388 + #389 (both filed by the doctrine-loop Scanner). One CR, two
independently-revertable specified behaviors.

Headless automaton, **spec gate only** — author + judge, then emit the verdict packet and STOP for
Council ratification. No deliver, no impl gate, no SKILL.md edits this segment.

## The two lessons (both are *verification methods* that worked once and must not be re-derived)

- **#388** — a formation-pass split should sanity-check its proposed organizing axis against a real
  capability/command boundary before carving. `cyberlegion-identity-presence-split` split an
  oversized `identity/` along a plausible-but-unreal `surfacing`/`wake` (identity-vs-presence) axis;
  it was superseded by a CLI-realignment that split `unit/` into `lifecycle`/`registry` along the
  package's actual command boundary. The killed CR even validated the producer/consumer boundary was
  sound but never checked the *split axis* mapped to a real command boundary. Lesson: an oversized
  node can be a symptom of the **wrong organizing axis**, not just wrong granularity.
  → **Home: `formation/` — the Warden's split act.**

- **#389** — prove a Clearance repair isn't a back-fit by showing it *fails* the pre-repair draft.
  `website-target-doc-spec` hit a Conflict inside its frozen suite, re-opened under Clearance,
  repaired two scenarios; confidence came from both repaired scenarios *failing* the pre-repair draft
  (a back-fit would move toward passing it) and a fifth cold judge confirming against the unrevised
  document. Lesson: a Clearance-gated repair of a frozen scenario is re-approved only when it **fails
  the pre-repair artifact**, not merely passes the post-repair one.
  → **Home: `workflows/gate-verdicts.feature` (Remediation theme E)** + the `remediation-governance`
  skill (impl, deferred). Note: remediation-governance has **no dedicated behavioral node** in the
  self-spec today — its behavior is specified only in `workflows/gate-verdicts.feature` + prose in
  `authoring/spec-gate/README.md`; this CR follows that established placement.

## Both edits are ADDITIVE

New scenarios on frozen features (`formation.feature`, `gate-verdicts.feature`) — nothing narrowed or
removed. Self-clears the frozen-contract guard, `@frozen` never lifted, no Clearance owed. Confirm
structurally at the gate (`gherkin-cli diff` addOnly, or the classify-edit-class engine).

## Ambiguities surfaced for the Council (see verdict packet)

1. **#388 placement/actor** — bar on the *Warden's split verdict* (chosen: catches it earliest,
   before the CR is even emitted) vs the *split mission's explore phase* (the issue's literal
   wording). Chose the Warden.
2. **#389 home** — `workflows/gate-verdicts.feature` (chosen, following the existing remediation
   placement) vs a would-be dedicated `remediation/` node (none exists) vs the `spec-gate` node.
3. **#389 actor** — framed as both a producer duty (demonstrate the pre-repair failure) and a
   gate/judge verification duty (require it before re-approval).

## NEXT

**Both gates self-asserted `by: agent`; STOPPED for the channel-holder's human ratification + merge.**
The Council resolved all three placement forks (all confirming the chosen placements) and settled the
lifecycle question (additive scenarios self-clear; root `status` stays `implemented`; gate verdicts
recorded `by: agent` in the ledger). The coordinator then correctly re-scoped to a within-authority
instruction after its first (erroneous) relay asked for a human-ratification write, which was refused.

**State:** two delivery commits on branch `worktree-agent-ab6645f78cfcdbcef`, rebased onto `main`
(b68a4fa6):
- `f16420bd` — #388 split-axis capability-boundary check.
- `25f8f413` — #389 Clearance-repair pre-repair-draft-failure proof.

Ledger `a7c3f1`: seq3 leash (auto-all re-derivation), seq4 spec-gate `approve by:agent`, seq5
impl-gate `approve by:agent`. Cold judges: spec ALIGNED (round 3), impl IMPLEMENTATION_PASS (all 8
frozen scenarios). `pnpm verify` 35/35.

**Owed to the in-session channel-holder (NOT the automaton — the positional act I cannot perform on a
relay):** the human ratification (`by:<name>`, advancing `status` if desired), the merge, and any
PR/push. The branch is local to this shared repo; no push was performed. The provisional `by: agent`
gate lines sit in the async review queue for ratify-or-kick-back.
