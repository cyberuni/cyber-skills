---
cr-ref: github-437
target-project: sdd
blast: medium
hitl: true
leash: auto-spec
tier: opus
todos:
  - content: "intake — plan scaffolded; target sdd; ledger leash line written"
    status: done
  - content: "explore — definition restored; one duty per bar in its own domain; 16 additive scenarios"
    status: done
  - content: "spec gate — R1 oracle+builder FAIL, remediated; R2 ALIGNED true 3/3, self-asserted in leash"
    status: done
  - content: "deliver — rebased onto main; changeset added; verify 29/29"
    status: done
  - content: "impl gate — R1 blocked on a closed-set contradiction; R2 PASS 16/16, no regression"
    status: done
  - content: "handoff — 6 follow-ups filed (#438-#443); PR against main, Closes #437"
    status: done
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

Landed. The `## Use Cases` definition carries actor, goal, and extensions, and every element a
capability exposes traces to a use case that needs it. Each of the three bars took a duty in its own
domain. 16 additive scenarios on the producer suite; the 85-node corpus is untouched by design.

Both gates passed on their second round, each after a real block: the spec gate caught the CR
failing to apply its own bar to the one behavioral node it revised, and the impl gate caught the
producer procedure re-listing the extension kinds as a closed set in the very step that warns
against hardcoded lists.

Nothing remains for this CR. The six follow-ups are filed as #438-#443; #436 carries the corpus
backfill.
