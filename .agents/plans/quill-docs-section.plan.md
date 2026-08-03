---
cr-ref: quill-docs-section
project: website
project-path: apps/website
status: in-progress
todos:
  - content: "Explore: scaffold 6 page nodes + docs/quill grouping under website spec"
    status: completed
  - content: "Explore: grill + author spec.md/README + .feature per page (quill-spec-writer)"
    status: completed
  - content: "Explore r2: resolve judged-tier boundary collision (doc-eval-model vs builder-impl)"
    status: completed
  - content: "Explore r3: producers load oracle/architect/builder-sdd forward bars, declare truthfully"
    status: completed
  - content: "Spec gate: re-dispatch cold sdd-spec-judge x6 with real relay, freeze, status write-back"
    status: completed
  - content: "Deliver: quill-doc-writer writes 6 pages against frozen suites"
    status: completed
  - content: "Deliver: add 4 new sidebar entries in astro.config.mjs"
    status: completed
  - content: "Impl gate: quill-judge runs acceptance checks per frozen scenario"
    status: completed
  - content: "Handoff: pnpm verify, branch + PR, ledger + follow-ups"
    status: in_progress
---

# CR quill-docs-section — document the whole Quill plugin on the website

**Request:** use Quill to dogfood itself — fill the documentation of the whole plugin into
`apps/website/src/content/docs/quill/`.

**Target project spec:** `apps/website/.agents/spec/` (`website`, `status: draft`,
`project-path: apps/website`). Strategy `mirror-source`; one page = one behavioral leaf at
`content/docs/<section>/<page>/`.

**Dogfood:** full production chain — Quill's squad is registered for `documentation` in
`.agents/universal-plugin.json`, so `quill-spec-writer` → spec gate → `quill-doc-writer` →
`quill-judge` runs for real on this CR.

## Page set (6)

| Page | Kind | Note |
|---|---|---|
| `overview.md` | revise | **stale**: claims all bar governances are `null` (registry binds `quill-builder-spec` / `quill-builder-impl`); documents only the 4 scenario checks, missing the document-scoped integrity check and the whole judged tier |
| `doc-eval-model.md` | new | the two instruments — inspection (4 scenario-scoped + 1 document-scoped) vs judgment (defect catalog, blind two-pass, deliberate violation, calibration) |
| `production-chain.md` | new | `quill-spec-writer` / `quill-doc-writer` / `quill-judge` — who writes vs who runs, the independence anchor |
| `init-quill.md` | revise | governance slots are no longer all `null` |
| `quill-builder-spec.md` | new | the spec-gate Builder bar — what a doc spec must contain |
| `quill-builder-impl.md` | new | the impl-gate Builder bar — the document-scoped rule + the judged defect catalog |

## Sources (repo-relative)

- `plugins/quill/readme.md`, `plugins/quill/skills/*/SKILL.md`, `plugins/quill/agents/*.md`
- `.agents/specs/quill/spec.md`, `.agents/specs/quill/design/doc-eval-model.md`,
  `.agents/specs/quill/glossary.md`, `.agents/specs/quill/sdd-roles/*/README.md`
- `.agents/universal-plugin.json` — the live squad binding (the authority on role/bar slots)
- Exemplar node quality bar: `apps/website/.agents/spec/content/docs/motive-model/overview/README.md`

## Out of scope

- Backfilling the other 70 unspecified website pages.
- Changing Quill itself — this CR documents it. A defect found in Quill is a follow-up, not a fix here.

## Blocking finding — the dogfood's main result so far

All six cold spec-judges blocked at **governance pre-flight**, independently and on the same set.
Root cause is upstream of this CR: **all three Quill agents replace the SDD producer's governance
load list instead of extending it.** `quill-spec-writer` names its own Builder bar plus the two
format bars and the ownership matrix, and stops — while `sdd:spec-producer-governance` requires the
resolved **oracle**, **builder**, and **architect** actor bars loaded forward face, so the producer
self-aligns to the lens set it is graded against backward. `quill-doc-writer` and `quill-judge` carry
the same omission on the impl side.

Swept: the sibling plugin's agents name the full set, so the correct shape exists in the corpus and
this is a Quill defect, not a gate defect. Recorded as a **blocking** follow-up.

A conductor error compounded it: the governance provenance relay was composed by the conductor from
the agent definition rather than requested from the producers. The relay must forward the producer's
own declaration verbatim, empty set included. Both are recorded in the combat log.

**Not fixed in this CR** — changing Quill is out of scope here. The producers were re-dispatched to
load the missing bars for this mission and declare truthfully. Loading them was not paperwork: the
Oracle bar's *name the outcome without "and"* test caught a double-barreled outcome the `overview`
spec had stated in its own words, and the Builder bar closed an unscenario'd CFG edge.

## Gate state

**Both gates cleared.** Spec gate: 6 of 6 cold `sdd-spec-judge`s return `{oracle, builder,
architect}` all PASS with ALIGNED true, each having re-derived counts, set equality and namespace
disjointness independently rather than accepting the producers' reports. Impl gate: 125 of 125
frozen scenarios pass across the six suites under a cold `quill-judge` per node, plus a
document-scoped enumeration pass and a blind reader simulation; all judged findings advisory, none
blocking. Both `approve` lines are in the ledger shard, and the root spec is `status: implemented`
with the impl approval recorded.

## Convergence — measured, because the loop inverted once

| Gate round | Verdicts | Findings | Provenance |
|---|---|---|---|
| 1 | 0/6 graded | 0 — all blocked at governance pre-flight | — |
| 2 | 1 pass, 5 fail | 8 | all pre-existing |
| 3 | 2 pass, 4 fail | 5 | **all 5 introduced by the round-2 remediation** |
| 4 | 3 pass, 3 fail | 3 | 1 pre-existing, 2 self-inflicted |
| 5 | 6 pass, 0 fail | 0 | — |

Round 3 was the inversion — count falling but provenance flipped entirely to self-inflicted, the
documented stop-for-re-plan trigger. Round 4 recovered: count still falling **and** provenance
partially back to pre-existing, with one node clearing outright.

## The sharpened rule — what the pilot earned

The re-plan's first instruction ("reconcile referencing passages") was too vague to act on. Piloting
it on one node before spending it on four turned it into two checkable rules:

1. **A universal or summary claim must hold for every member it quantifies over.** Check every
   quantifier — *every*, *all*, *each*, *both*, *either*, bare counts — and especially **ID ranges**,
   where a member can hide inside the range. On one node, checking `K1–K14` against its members
   exposed a scenario tracing to **no coverage row at all**; on another, a completeness argument was
   spending 8 of 22 rows; on a third, a preamble and north star claimed a near-miss for "each
   criterion" when one of the ten criteria has none.
2. **A node's identifiers share one namespace.** Coverage rows, use-case groups, and CFG nodes may
   not reuse a token, and enumerated items are referenced by name, never by an invented index. Four
   nodes shipped collisions, three of them found only by this check.

**A sweep is not self-certifying.** The piloted node caught five of six targeted items plus four
unprompted defects and still left one claim false. The sweep reduces rounds; it does not replace the
cold judge.

**Diagnosis.** Three of the four regressions are one defect class: the producer changed the claim at
the site the finding named and did not reconcile the passages elsewhere in its own node that
reference that claim — a narrowed scenario left a completeness argument asserting the old wider
closure; a reworded step left the `.feature` preamble carrying the original wording; a rewritten
completeness argument stopped spending one coverage row. The fourth is an identifier collision
introduced by a rewrite (`B1` meaning both a coverage row and a catalog entry).

**The re-plan is an instruction change, not another round.** The briefs asked for a site fix and got
exactly that. Round 4 asks each producer to run an **intra-node reconciliation sweep** — every
passage referencing anything it changed, every identifier checked for one meaning, the `.feature`
preamble and section comments included, each sweep item reported with its result **including
"nothing"** — because an unreported sweep is indistinguishable from an unrun one.

## NEXT

Handoff only. Done: `pnpm verify` green at the repo root; both gate lines and all follow-ups
written to the ledger shard; root spec `status: implemented`.

**Remaining, and it needs a call:** branch + PR. The work sits on `sdd/380-partial-skill-classifier`
— a long-lived stack now 86 commits ahead of `origin/main` and 63 ahead of its own remote, carrying
several unrelated CRs (`quill-writing-quality`, `website-target-doc-spec`) that have *not* cleared
their gates. This CR cannot be PR'd alone without first splitting it off the stack. Do not push or
open a PR until that scope is decided.

The blocking follow-up this mission produced is already opened as its own CR brief at
[`quill-producer-bars.plan.md`](quill-producer-bars.plan.md) — item 1 there (all three Quill agents
replace the SDD load list instead of extending it) is the one that changes what every future Quill
spec is graded against.
