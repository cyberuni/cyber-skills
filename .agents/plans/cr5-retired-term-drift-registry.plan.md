---
cr-ref: cr5-retired-term-drift-registry
project: sdd
node: .agents/specs/sdd/corpus/retired-terms
status: in-progress
todos:
  - content: "Intake: read CR-5 from the doctrine backlog + its source ledger entry, locate the sdd spec, scaffold this plan"
    status: completed
  - content: "Explore: pick the owning project (sdd corpus/) and the registry seam; spike the seed term's over-fire rate against the live tree"
    status: completed
  - content: "Author: corpus/retired-terms/ node (README + .feature) specifying the registry format and the verify-time sweep"
    status: completed
  - content: "Author: add the retired-terms row to corpus/README.md's Units table; regenerate the by-concept block"
    status: completed
  - content: "Spec gate: self-grill, run check-spec-state + check-suite, cold sdd-spec-judge rounds to convergence (3 rounds, ALIGNED)"
    status: completed
  - content: "STOP: emit spec-gate verdict packet for Council ratification (gated CR — no self-ratification)"
    status: in_progress
  - content: "[BLOCKED on Council] on ratification: write approval.spec + the durable gate line, freeze the .feature, then deliver the engine + seed the registry"
    status: pending
---

# CR-5 — retired-term drift registry

Source: the doctrine ratification backlog in `.agents/plans/doctrine-strategy-keep-or-cut.plan.md`
("New KEEP queue (7 CRs)", row CR-5), distilled by the Scanner into the aced ledger shard
`strategy.193814` seq 2. **Gated CR — drive to the spec gate and stop.**

## Change request

A design decision that **retires a path, directory, or naming convention** leaves survivors scattered
across the corpus, and nothing mechanical looks for them. The head recurrence: the colocated
project-spec model retired the old suite location `artifacts/specs/<feature-name>/`, and **7 ACED
skills plus a spec README still hardcoded it**. It surfaced only because the owner personally caught
it while ratifying one unrelated node — the node's own cold impl-judge had not covered the stale step
either.

Register the retired term, and let a **verify-time corpus-wide sweep** flag every survivor. Same
spirit as the `referenced-artifact-escalation` guard (broken artifact refs) and the shipped
`check:metaphor-free` guard in `packages/cyberlegion` (PR #390) — generalized from broken links and a
hardcoded banned list to a **declared registry** of retired terms.

## Settled during explore (do not re-derive)

**Owning project: `sdd`, node `corpus/retired-terms/`.** The sweep ranges *across* project-specs and
their skills, which is exactly `corpus/`'s charter ("corpus-level tooling — a corpus-level action
ranges across project-specs"). The intra-spec tier (`project-spec/`) is the wrong altitude. The
engine ships as a `plugins/sdd/skills/` script and joins the root `check:specs` chain, where
`check-plan-safety` and `resolve-tracking` already run repo-wide at verify time.

**Registry: `.agents/sdd/retired-terms.toml`** — sibling to `spec-anchors.toml` and
`artifact-types.toml`, the established home for SDD's declared repo config. Hand-edited (no CRUD
skill in this CR); an array of tables, each entry `term` / `since` / `replacement`, plus optional
`scope` and `allow`. Parsed by the same hand-rolled minimal-TOML approach `discover-specs` already
uses (node ≥23.6, no deps) — which is why `allow` entries are flat strings (`file :: substring`),
never nested inline tables.

**Matching is literal substring, case-sensitive.** The registered things are paths and conventions,
not words; the allow-list is the escape hatch for a false positive. No word-boundary mode, no regex —
a registry the author cannot predict the behavior of is worse than a grep.

**A malformed registry fails loud, non-zero.** Deliberately *unlike* `discover-specs`, which ignores
a corrupt `spec-anchors.toml` and falls back. A guard that silently disables itself on a typo is a
false green, and false-green is the exact defect this CR exists to close.

**Over-fire spike against the live tree (the plan's verification method, step 1).** Sweeping the seed
term `artifacts/specs/` over the 1634 tracked files hits 69 files. Nearly all are legitimate:

| Where | Hits | Verdict |
|---|---|---|
| `artifacts/**` (the legacy tree itself, incl. 2 ADRs) | 43 files | the superseded corpus, kept for history — not a survivor |
| `.agents/specs/*/ledger/**` | 9 files | durable provenance, records past state verbatim |
| `.agents/plans/**` | 5 files | historical mission briefs |
| `apps/website/**` | 6 files | docs describing the legacy tree, which still exists |
| `.agents/specs/sdd/{DESIGN-NOTES,glossary,design/actors-governance}.md` | 3 files | history, plus two references to the **live** `motive-model` project that genuinely lives under `artifacts/specs/` |
| `knip.json`, `.vscode/settings.json` | 2 files | tool config pointing at the legacy tree |
| **`plugins/aced/readme.md`** | **1 file, 3 lines** | **a genuine survivor** — still documents ACED eval suites at `artifacts/specs/<suite-name>/` after they moved to `.agents/specs/aced/`. The guard's first catch; the seeding CR **fixes** it rather than allow-listing it |

Counts re-derived against `git grep -l` (69 files total) after the cold judge caught an arithmetic
error in the first pass of this table — and that recount is what surfaced the `plugins/aced/readme.md`
survivor, which the first pass had silently folded into a bucket.

So the design needs all three narrowing devices, each earned by data rather than guessed: **built-in
exclusions** (ledger shards, plan briefs), a per-entry **`scope`** (include-prefixes, so the seed
entry watches only live instruction surfaces), and a **two-form `allow`** — file-only (a wholly
historical file) and `file :: substring` (one sanctioned line). Without them the guard fires ~69
times on a clean corpus and gets switched off in a week.

## Out of scope (followups, not this CR)

- A CRUD/manage skill over the registry (the `spec-anchors` treatment). Hand-edit is enough until a
  second author needs it.
- Auto-registration at retirement time (the mission that retires a convention registering the term as
  part of handoff).
- Backfilling the registry with terms beyond the one seed entry.

## Spec gate — three cold judge rounds

| Round | Verdict | What it caught |
|---|---|---|
| 1 | `blocked` at pre-flight | the inline producer had loaded 2 of the 7 expected governances; no content graded. Its one observation (the over-fire table miscounted) is what surfaced the `plugins/aced/readme.md` survivor |
| 2 | `{oracle: pass, builder: fail, architect: pass}` | the node's **own spec README** states the seed term repeatedly and sits inside the worked example's scope, so once tracked the guard would report its own definition as drift — a trap the cited `metaphor-free` precedent had already closed and this node had not copied |
| 3 | `ALIGNED: true`, all three lenses pass | — |

Round 2's fix was made as a **rule**, not a patch: the exclusion list is now stated as *"a surface
whose job is to name the retired term is not drift"*, with two kinds (the guard's own definition;
durable provenance) and an explicit narrowing note that a spec README which merely *mentions* a
retired convention is **not** excluded — that is the drift case.

Two non-blocking observations carried to the impl gate: only one of the three "guard's own definition"
sub-cases has a dedicated scenario (mirrors the precedent), and `the registry loads one registered term
per entry` asserts a parsed result rather than a CLI-observable artifact.

## NEXT

**STOPPED at the spec gate awaiting Council ratification.** No `approval` frontmatter was written, no
`.feature` was frozen, and the durable gate line records `verdict: pause` — this is a gated CR, so the
ratification is not the conductor's to write and is not relayable.

On a Council **approve**: write `approval.spec` on the root `spec.md`, append the durable `gate`
approve line, freeze `retired-terms.feature`, then deliver — build
`plugins/sdd/skills/check-retired-terms/`, wire it into the root `check:specs` chain, seed
`.agents/sdd/retired-terms.toml` with the `artifacts/specs/` entry, and **fix** the three survivor
lines in `plugins/aced/readme.md` (do not allow-list them).
