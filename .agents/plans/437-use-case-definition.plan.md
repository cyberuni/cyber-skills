---
cr-ref: github-437
target-project: sdd
blast: high
hitl: true
leash: auto-spec
tier: opus
todos:
  - content: "intake — plan scaffolded; target sdd; ledger leash line written"
    status: done
  - content: "explore — definition restored; one duty per bar in its own domain"
    status: done
  - content: "spec gate R1/R2 — R1 oracle+builder FAIL, remediated; R2 ALIGNED true 3/3"
    status: done
  - content: "impl gate R1/R2 — R1 blocked on a closed-set contradiction; R2 PASS 16/16"
    status: done
  - content: "SCOPE FOLDED by owner — CFG amendment (Clearance granted) + actor-first discovery"
    status: done
  - content: "spec gate R3 — architect+builder FAIL (missed sweep sites, inert scenario); remediated"
    status: done
  - content: "spec gate R4 — REGRESSION declared, loop halted for re-plan"
    status: done
  - content: "re-plan — skill folder as a unit; 5 of 6 folders had an unmoved README; propagation finished"
    status: done
  - content: "re-gate — spec gate R5 ALIGNED; impl gate R3/R4 blocked on duty-table drift, R5 PASS 22/22"
    status: done
  - content: "handoff — PR #444 updated to the folded scope; 8 follow-ups filed; awaiting impl ratification"
    status: in_progress
---

# CR github-437 — the `## Use Cases` definition is an invocation signature, not a use case

CR link: https://github.com/cyberuni/cyberplace/issues/437
Refs #436 (the corpus backfill, held out of scope — new and revised nodes only).
Background: `.research/use-case-elicitation/` (`conclusion.md`; note the 2026-08-11 correction in
`changes.md` withdrawing the rename recommendation).

## The finding

`spec-format-governance` defines a use case as an **entry point** — trigger / inputs / outcome,
named to the impl surface. Authored that way from the start (`ba974085`, 2026-06-23; carried into
the governance at `c61ee525`). It never drifted; it was narrow from the origin.

The RE definition is actor + goal + main path + **extensions** (alternate, error, divergence paths).
Extensions is where "what can go wrong for this actor" and "which inputs may be combined" live. A
trigger/inputs/outcome row has no room for it, so per-element justification, failure analysis, and
combination analysis have no home in any spec today.

Measured: **85 behavioral nodes, 0** with actor or situation language in `## Use Cases`. Every one
is a correct entry-point table. **124 CRs** through the spec gate, **2** `.solution.md`
rejected-alternative records — the artifact that would hold design interrogation is optional,
ungated, and out of the judge's view.

## Scope

- **In:** the `## Use Cases` definition in `spec-format-governance`; the producer's duty to author
  it; the Oracle / Builder / Architect grading duties over it (owner: all three play a part).
- **Out:** the 85-node corpus backfill (#436). Renaming the section (withdrawn — the name records
  the intent). Confidence derivation and the "when are the bars invoked" fix (see Follow-ups).

## Method

Keep the name, fix the definition. The restored shape must be **gradable from the document alone** —
the spec gate is a cold judge, so it can only grade what a reviewer can call wrong, never a
facilitation ritual whose value is realized live. That constraint rules out importing event
storming, JTBD interviews, or a BMAD-style elicitation loop as mechanisms.

Entry-point rows stay — they remain correct and useful, they are just no longer the whole section.

## Follow-ups identified (not this CR)

- Derive `confidence` from measurable inputs rather than free prose. Precedent: `blast` already has
  a real engine (`blast-estimate`) that computes it and flags under/over-called; `confidence` is
  self-asserted and unchecked, and it is the dimension that decides self-assert vs. stop.
- Fix **when** the actor bars are invoked — today twice, both over the artifact as it stands, so
  nothing can ask whether an element should exist.
- Provenance on problem claims (`reported:` / `observed:` / `assumed:`), evidenced by the CR-304
  revert and the CR-294 premise correction.
- Compare intake against the `wayfinder` HITL/AFK ticket taxonomy.

## NEXT

**Both gates passed. Awaiting the owner's impl-gate ratification — the leash is `auto-spec`, so the
impl gate is not mine to self-assert.**

Final: 22 additive scenarios (suite 66 -> 88, `addOnly` confirmed structurally), 26 files,
`check:spec` 6/6, `pnpm verify` 29/29, rebased current with main.

| Gate | Rounds | Outcome |
|---|---|---|
| spec | 5 | R1 fail, R2 pass, *scope folded*, R3 fail, R4 **regression -> halt**, R5 ALIGNED true |
| impl | 5 | R1 fail, R2 pass, *scope folded*, R3 fail, R4 fail, R5 **PASS 22/22, no blocker** |

Every block was substantiated and each caught something that would otherwise have shipped: the CR
failing to apply its own bar to the node that defines it; a closed-set contradiction in the very
step warning against hardcoded lists; three missed sweep sites, one hidden by a line wrap; and two
rounds of duty-table drift between a `SKILL.md` and its `README.md`.

That last class recurred four times and is one root cause — a skill folder's members are one unit
and nothing derives the review set. Filed as #453. The mechanical bar-to-table comparison that
finally closed it is about fifteen lines and belongs there.

Follow-ups: #436 (corpus backfill, widened to cover shipped skills), #438-#443, #453.
