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
  - content: "re-gate — spec gate R5 and impl gate R3 on the amended tree; prior passes do not carry"
    status: pending
  - content: "handoff — update PR #444 body to the folded scope; push"
    status: pending
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

**Not landed. Awaiting an owner decision on shape, then a re-gate.**

State: 14 commits, 26 files, 22 additive scenarios on the producer suite (`addOnly` confirmed
structurally; suite 66 -> 88). `check:spec` 6/6, `pnpm verify` 29/29. PR #444 is open but its body
still describes the pre-fold scope. 5 commits unpushed.

Gate history — the earlier passes **do not carry**, because the owner folded two changes in after
them: the CFG amendment (Clearance granted in session, recorded before the edit) and actor-first
discovery.

| Round | Verdict |
|---|---|
| spec R1 | oracle+builder FAIL — the CR failed to apply its own bar to the one behavioral node it revised |
| spec R2 | ALIGNED true |
| impl R1 | blocked — the producer re-listed the extension kinds as a closed set |
| impl R2 | PASS 16/16 |
| *scope folded* | CFG amendment + actor-first discovery |
| spec R3 | architect+builder FAIL — 3 missed sweep sites (one wrap-hidden), one scenario inert |
| spec R4 | **REGRESSION** — a finding on the paragraph R3 edited; loop halted |

Root cause of the R3/R4 pattern, named by the owner: a skill folder's members are one unit and
nothing says so. Measured — **5 of the 6 touched skill folders had an unmoved `README.md`**.
Propagation is now finished across all three layers (shipped skill, spec-corpus node, public docs),
swept wrap-safe. Investigation filed as #453.

**Open decision before re-gating:** finish as one CR, or split — land the restored definition + CFG
routing (which passed both gates cleanly at R2) and give actor-first discovery its own CR and its
own gates. Discovery is the part that kept failing the miss test.

Follow-ups filed: #436 (corpus backfill), #438-#443, #453.
