---
cr-ref: operator-bunker-call-in
target-project: cyberfleet-plugin
blast: small
hitl: false
leash: auto-all
tier: opus
todos:
  - content: "explore — author the call-in seating contract into the operator node + additive scenarios"
    status: done
  - content: "spec gate — 3 cold judge rounds, R3 ALIGNED true; addOnly, suite stays @frozen"
    status: done
  - content: "deliver — SKILL.md + README.md conform to the new frozen scenarios"
    status: done
  - content: "impl gate — aced-impl-judge IMPLEMENTATION_PASS true over all 41 frozen scenarios"
    status: done
  - content: "handoff — committed on branch; PR awaiting owner go-ahead"
    status: done
---

# CR operator-bunker-call-in — Operator calls in to the bunker

CR link: none (owner prompt, in-session).
Evidence: `.research/operator-skill-grill/conclusion.md` — findings A and B, and the
"harmful fixes" section (why the verb is `claim`, not `register`).

Node: `.agents/specs/cyberfleet-plugin/operator/` (revise — node exists, suite `@frozen`).
Touches: `plugins/cyberfleet/skills/operator/SKILL.md`, `.../operator/README.md`.

## The model

Operator is a **singleton at the bunker**. Worktrees and sessions come and go; invoking the skill
is a **call in** to a seat that outlives them. `cyberlegion` already implements this in two objects:

- **the bunker** — `standing-operator` (`kind: standing`): never exits, session-independent, holds
  the durable mailbox.
- **the desk** — `AgentRecord.presence`, bound by `unit claim <handle>`, keyed on the **role
  handle**. Last claim wins; an exited occupant reads as an empty desk.

The skill names neither. It never mentions `claim`, never names the standing record it writes into
every brief as a return address, and never drains that mailbox.

## Scope

Additive only — no frozen scenario is narrowed or rewritten, so the suite self-clears and stays
`@frozen` (verify with `classify-edit-class.mts` at the gate).

- **`operator/README.md`** — a new `## Use Cases` subject bullet: seating is calling in to the
  bunker (register as itself → `unit claim operator` → drain `mail inbox --owner operator`), plus
  its row in the behavior-to-scenario table.
- **`operator/operator.feature`** — a new `# ── The seat's identity ──` block of additive
  `@behavior` scenarios.
- **`plugins/cyberfleet/skills/operator/SKILL.md`** — a `Decisions` entry implementing it.
- **`plugins/cyberfleet/skills/operator/README.md`** — the matching "what it does" line.

## Held out of scope (follow-ups, not this CR)

- `preferStanding` falls through to `matches[0]` for two live non-standing units sharing a handle
  (`packages/cyberlegion` — `identity.ts`). A `cyberlegion` defect, different project spec.
- The stale hub `attach` binding at a dead pane — Council/`init-cyberlegion` surface, not a spec
  change.
- The 36-message `standing-operator` backlog — operational, not a spec change.

## NEXT

LANDED. Both gates passed and self-asserted under the owner's `auto-all` leash; the node is
`status: implemented`. Spec gate took 3 cold-judge rounds (R1 builder+architect FAIL, R2 builder
FAIL — the same defect having migrated `Given` → `When`, R3 ALIGNED true). Impl gate passed
IMPLEMENTATION_PASS true over all 41 frozen scenarios with no neighbour regression. Root
`pnpm verify` 29/29.

Nothing remains in this CR. Outstanding work lives on the ledger as `followup` records — one
`blocking` (`init-cyberlegion` hardcodes `--handle legate`, so this CR's missing-bunker route has
no landing site) and six `backlog`. None has been filed as an issue yet: the drain is
permission-gated and was not granted in-session, so the records stand and are re-derivable by
dedupe on a later drain.
