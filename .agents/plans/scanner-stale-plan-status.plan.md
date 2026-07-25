---
name: scanner-stale-plan-status
cr: local-scanner-stale-plan-status
status: active
node: doctrine/scanner
touch-set: sdd/doctrine, sdd/design, sdd/intake
blast: medium
todos:
  - content: "Intake: CR opened, plan scaffolded, leash recorded"
    status: completed
  - content: "Validate CR premise against current code (#376 doctrine) — REFUTED, see Findings"
    status: completed
  - content: "HALT: needs-input on which realization to spec (three options below)"
    status: completed
  - content: "Explore: freeze the chosen stale-plan detection contract in doctrine/scanner/scanner.feature (additive)"
    status: completed
  - content: "Spec gate — cold spec-judge; freeze; gate line"
    status: completed
  - content: "Deliver: wire into doctrine-loop SKILL.md + sdd-scanner.md (+ plan-retirement if option C)"
    status: in_progress
  - content: "Impl gate — cold impl-judge; pnpm verify green"
    status: pending
  - content: "Handoff — PR, followups, warm-unit reset"
    status: pending
---

# scanner-stale-plan-status — Scanner detects plan frontmatter that lags reality

## Request

During a Scanner pass, for each brief under `.agents/plans/`, cross-check its frontmatter
`status:` against (a) whether all `todos[].status` are done, and (b) whether its declared
`source` is closed/merged (queried natively, as `plan-retirement`'s clearance check describes).

- **Both signals agree terminal, frontmatter still says active** → correct it before the
  existing distill step runs.
- **Signals disagree** (source closed, own todos still open) → do **not** autofix; surface a
  flagged finding.

Motivating evidence: 5 briefs hand-fixed in `dd1e14ac` (`at-default-tab`, `github-158`,
`github-161`, `github-172` → terminal; `cyberlegion-identity-presence-split` → superseded).
`github-159-doorbell-bunker` deliberately held back — its own last todo is still in progress
despite a closed source issue, which is exactly the disagreement case.

## Findings — the CR's premise is refuted against current code

Validated per this repo's own `#376` doctrine (*a plan is a hypothesis, not present truth*).

1. **No consumer reads a plan's `status:` for lifecycle.** The only parser is
   `plugins/sdd/skills/discover-plans/scripts/discover-plans.mts` — it carries the value
   verbatim and applies an exact-string filter **only when a caller asks**. The gateway's
   re-entry listing applies no filter at all.
2. **Neither distill nor retirement gates on it.** `plugins/sdd/skills/plan-retirement/scripts/retire-plans.mts`
   decides on `cleared(--retire) ∧ plan present ∧ (distilled ∨ no combat log)`. The doctrine
   distill keys on the **spec's** `→ implemented` / `→ deprecated` and on `distills: <cr-ref>`.
   Neither reads the brief's `status`.
   ⇒ Flipping a brief to `implemented` makes it visible to **nothing**. The stated motivation
   ("so they'd become visible to the Scanner's existing distill step") does not hold.
3. **`implemented` / `deprecated` are off-enum for this field.** `.agents/specs/sdd/design/provenance-model.md`
   declares the plan-level `status` as the **dispatch flag** `active | approved`, and carries an
   explicit *"three distinct `status` fields, three scopes — do not conflate"* warning naming
   `spec.md`'s `draft | approved | implemented` as the one **not** to borrow.
4. **The corpus has already drifted** — 23 briefs declare `status`; 12 are off-enum
   (`draft` ×4, `implemented` ×3, `done` ×2, `complete`, `completed`, `awaiting-clearance`).
   `approved` appears zero times. Nothing validates the enum; `pnpm verify` checks plan files
   only for machine-local path leaks (`check-plan-safety`), never frontmatter shape.

The **detect + flag** half of the CR contradicts nothing. The **autofix** half asks to write a
value the declared contract reserves against, into a field nothing reads.

## The open question (blocks the spec gate)

Under the current contract there is no legal terminal value for a plan's `status` — the
contract's own answer to "this mission is over" is **retirement (deletion)**, gated on
source-done + distilled ("present means resumable; retirement is a deletion, not a flag").

- **Option A — widen the enum.** Add terminal values to the plan-level `status` and revise
  `design/provenance-model.md`, `intake/plan-discovery/`, `gateway/dispatch/`,
  `mission/checkpoint/`. Deliberately overturns the "do not conflate" rule; corpus-wide blast;
  needs a backfill of the 12 drifted briefs. Not chore-tier.
- **Option B — autofix as requested, contract unchanged.** Fastest to the letter of the CR,
  but writes an off-enum value into a field with no reader, and leaves the contradiction with
  `provenance-model.md` standing. Encodes a known contradiction into a frozen scenario.
- **Option C — recommended: derive the retirement clearance set instead.** Drop the `status`
  write entirely. The Scanner's pass computes, per brief, `todos-all-done ∧ source-closed`;
  agreement feeds the **`--retire` clearance set** `plan-retirement` already takes from its
  caller, and disagreement surfaces as a flagged finding. Achieves the CR's actual goal — no
  human needed to notice — through machinery that already exists, adds no new field semantics,
  contradicts no declared contract, and is genuinely additive to `doctrine/scanner/`.
  Separately proposable: a `check-plan-safety`-style enum guard so the drift cannot recur.

## Resolved decisions

**Owner picked Option C** (derive the retirement clearance set; drop the `status` write). Explore
landed: `.agents/specs/sdd/doctrine/scanner/scanner.feature` gained a new additive
`# ---- Stale plan frontmatter ----` band (8 scenarios: agree-terminal feeds the clearance set,
agree-non-terminal is a no-op, both disagreement directions surface a flagged finding and never
autofix, a distinguishing scenario pinning the finding's shape (never `kind: strategy`, never
`kind: report`, distinct from the validated-open-improvement finding), the clearance set reuses
`plan-retirement`'s existing `--retire` input rather than a new mechanism, `source-closed` reuses
`plan-retirement`'s own native-query contract, and an explicit never-writes-`status` guard
scenario). `doctrine/scanner/README.md` gained a Use Cases row plus a full "Stale plan frontmatter"
section ahead of "Where each strategy entry lands". No enum widening, no `provenance-model.md`
change — the CR's actual goal (no human needed to notice) rides existing `plan-retirement`
machinery.

**Spec gate — PASS on iteration 2.** Iter-1 cold spec-judge failed oracle/builder/architect: the
two disagreement scenarios said the finding surfaces "in its report," colliding with the reserved
`kind: report` ledger line and this same spec's own frozen Non-goals, and left the finding's shape
unspecified. Remediated (see ledger `scanner-stale-plan-status.b41e7c.jsonl` seq 2 for the full
gate line): reworded to "the Scanner's pass summary to the invoking session" (its established
final-message-only channel, per `sdd-scanner.md` / `doctrine-loop/SKILL.md`), added the
distinguishing scenario, and a README paragraph giving the flagged finding an explicit
ephemeral/non-ledger shape. Iter-2: oracle/builder/architect all PASS, ALIGNED true, no blockers.
Self-asserted within `auto-spec` leash, medium blast (per this CR's own pre-cleared leash line).
`scanner.feature` stays `@frozen` (additive self-clears). Root `spec.md` status unchanged
(`implemented`).

## NEXT

Resume at todo 6 (deliver): wire the Scanner-side computation into `plugins/sdd/agents/sdd-scanner.md`
+ `plugins/sdd/skills/doctrine-loop/{SKILL,README}.md`, and the caller-side clearance derivation
into `plugins/sdd/skills/plan-retirement/` (README + SKILL, and `scripts/retire-plans.mts`/tests if
the derivation should be mechanical there rather than agent-run inside the Scanner). Then
`pnpm verify` green, impl gate, handoff as a direct chore commit (source is a manual finding, not a
GitHub issue — no CR to link an issue to).
