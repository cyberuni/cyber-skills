---
cr-ref: operator-command-center-vocab
status: active
project-spec: .agents/specs/cyberfleet-plugin
todos:
  - content: Intake — locate spec, scaffold plan, set leash
    status: completed
  - content: Get ratified re-open for the frozen operator.feature (rewrite class)
    status: completed
  - content: Load spec-gate bars (oracle/builder/architect) before authoring
    status: completed
  - content: Rewrite operator node README + operator.feature to the connect vocabulary
    status: completed
  - content: Update Pod counterpart line and cyberfleet-plugin spec.md
    status: completed
  - content: Companion shard — packages/cyberfleet spec.md command-center sentence
    status: completed
  - content: Spec gate — cold spec-judge, freeze, ledger gate line
    status: completed
  - content: Deliver — skill SKILL.md/README, manifests, website cyberfleet docs
    status: completed
  - content: Impl gate — cold impl-judge over frozen scenarios
    status: completed
  - content: Handoff — PR, follow-up records for the out-of-scope senses
    status: completed
---

# operator-command-center-vocab

Retire the **seat** framing and the duplicate place-nouns from the cyberfleet **Operator** persona.

## Why

Operator is a **singleton at the command center**. "Seat/seated" reads as though the Operator lives
in whichever session loaded the skill; the reality is the session **connects to** a durable identity
(`standing owner operator`) that outlives every session. The corpus also carries two place-nouns for
one place ("bunker" and "command center") plus "desk" for the presence binding — three words, one
mechanism, and an agent has to reconcile them before it can act.

**Vocabulary-only. No mechanism changes.** `cyberlegion unit register` (own handle) +
`cyberlegion unit claim operator` stay exactly as they are.

## Vocabulary

| Retired | Replacement | Note |
|---|---|---|
| seat / seated / seating | **connect to the command center** / on connecting | the session connects; it does not carry the role |
| bunker (the place) | **the command center** | one place-noun |
| bunker (the record) | **the standing `operator` owner** | it was a mailbox, not a place |
| desk | **the claim** | names `unit claim operator` / the presence binding |

Unchanged and load-bearing: `hub` (cyberlegion's state root), `ship`, `pod`, `Council`, `fleet`.
`connect` is unused across cyberfleet + cyberlegion today — no collision.

## Invariant that must survive

ADR-0022 **amendment decision 3**: invocation asserts it, **never a probe**; nothing about the
working folder can take it away. "Seat" was carrying this rule — the replacement must carry it
just as explicitly.

Also corrected here: the operator node README cites ADR-0022 "decision 8" for seating; the
amendment puts it in **decision 3** (decision 8 was the retired mode switch).

## Touched specs

- `.agents/specs/cyberfleet-plugin/` — `operator/` (node README + frozen suite), `pod/` counterpart
  line, `spec.md`
- `packages/cyberfleet/.agents/spec/spec.md` — companion shard, the "Command-center survives only
  as the Operator persona's seat" sentence
- `apps/website/.agents/spec` — cyberfleet docs (documentation squad)

## Out of scope — file as follow-ups

- **SDD's separate "Bunker"** — the doctrine altitude where the Scanner sits. Different referent,
  different project; collapsing it is not this CR's call.
- **cyberlegion-plugin's separate "seat"** — attended-vs-headless channel ("do I have a seat?").
  Unrelated sense, worth its own de-dup.
- **cyberlegion `BANNED_TERMS`** — still needs `Bunker` while the SDD sense lives.

## Hard floor

The frozen `operator.feature` was **rewritten**, not extended — 13 scenarios reworded.

Both floors fired, and the first read of this was wrong. Substantively the rewrite preserves
meaning, so nothing was narrowed. But `align-spec`'s scenario-diff is **title-keyed**, so it cannot
tell a rename from a deletion: all 13 renamed titles read to it as removals and it classified the CR
`narrowing (clearance)`. **Clearance is what gates, not the substantive read.** It was pre-authorized
by unional, scoped to meaning-preserving renames only, on top of the separately ratified freeze
re-open.

The voice tightening is **not** covered by that Clearance and was never claimed to be — it is a real
behavior change (a run performing the NieR human character was arguably conforming before and now
fails), authorized separately by unional's instruction that Operator read as an AI agent. Two grants,
deliberately not blurred.

## NEXT

Landed. Spec gate and impl gate both ratified by unional; 41/41 frozen scenarios pass with
@trigger accuracy 9/9. Nothing to resume.

Six follow-ups are recorded in the ledger shard and drain to issues at handoff. One is classed
**blocking**: the ACED impl-judge cannot collect its own case-judge results in this configuration —
all 15 children completed correctly but none could address the parent, so the judge can never reach
a verdict through its own harness. This CR reached its gate only by substituting an inline judge
that does not fan out. That affects every CR whose artifact-type resolves to the ACED squad, not
just this one.
