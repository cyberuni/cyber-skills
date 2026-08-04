---
cr-ref: cause-enum-conformance
target: .agents/specs/sdd
status: in_progress
todos:
  - content: "explore — author off-enum-visibility cause discipline (conductor.feature + READMEs)"
    status: done
  - content: "spec gate — cold spec-judge round 3 ALIGNED, self-asserted by:agent (additive self-clears)"
    status: done
  - content: "deliver — combat-log-governance + gate-validation + lifecycle + start-mission + design docs (nudge + gate-enum reconcile swept across all 6 documented sites)"
    status: done
  - content: "pnpm verify (35/35); rebased onto main 2891e9b9"
    status: done
  - content: "impl gate — cold impl-judge round 2 PASS, self-asserted by:agent"
    status: done
  - content: "handoff — followups recorded (ledger seq4/5), STOPPED for human ratification (no PR/merge/ratify)"
    status: done
---

# CR: cause-enum conformance — off-enum causes stay visible

Ratified doctrine KEEP (CR-2). Grounding: `combat-log-governance` says an absent/off-enum `cause`
"fails closed (breaks cross-mission matchability)" — so off-enum causes silently vanish from the
doctrine loop's own recurrence detector though they are real on-disk defects. Corpus scan: 8+ off-enum
causes across 5 missions (376 `node-boundary`, github-89 `format-json-missing-built-array`, github-224
×3, cybermux-60 ×2, 304-m3 `post-write-verification-edge`).

## Deliverable — a visibility NUDGE, not a hard blocking linter

At the point the conductor writes a `cause` (correction lines AND gate lines): prefer an enum value;
if none fits, write the off-enum string in `cause` AND set `cause-candidate: true` so it reads as
"proposed for enum growth" and STAYS COUNTABLE, rather than silently failing closed. An **absent**
cause still fails closed (the nudge is no license to omit). NOT a fail-closed linter that blocks the
write.

Secondary (confirmed clean in explore): the gate-line `cause` enum documented `dimension | ceiling` is
stale — corpus uses `dimension` (heavy), `clearance` (7×), `floor` (1×); `ceiling` has 0 uses.
Reconcile ONLY the unambiguous add: `clearance` maps to the named Clearance hard floor → enum becomes
`dimension | clearance | ceiling`. Generic `floor`/`council-placement`/bespoke strings stay off-enum
and are now handled by the primary nudge (flagged as candidates). No taxonomy invention.

## Rule 1 check

The primary rule turns on a SINGLE condition ("does an enum value fit?") → specified by example with a
positive companion. Rule 1's ≥2-interacting-condition closed-form trigger does NOT fire. Do not force
closed form.

## Node-boundary guard (376's lesson)

"Stays countable" is asserted as the conductor's WRITE OUTPUT (cause present + flagged), never as the
Scanner's counting behavior — the flag is a visibility marker, countability follows from the cause
string being present. No Scanner-side scenario (avoids the co-owned seam trap).

## Surfaces

- SPEC (frozen): `mission/conductor/conductor.feature` (+6 additive, self-clears) + `mission/conductor/README.md`
- SPEC prose (reference node, no .feature): `common-governances/combat-log/README.md` `## Subject`
- IMPL (widened — the nudge itself requires the gate-validation legality rule; the enum is documented
  in 6 sites and must be swept together to avoid new drift, memory "fix everywhere not the named site"):
  - `plugins/sdd/skills/combat-log-governance/SKILL.md` (owns the enum: correction cause discipline +
    gate enum add `clearance` + `cause-candidate` marker)
  - `plugins/sdd/skills/gate-validation-governance/SKILL.md:28` (off-enum+flag is now legal; add clearance)
  - `plugins/sdd/skills/lifecycle-governance/SKILL.md:27` (enum comment)
  - `plugins/sdd/skills/start-mission/SKILL.md` (autonomy-bar write duty — the nudge)
  - `.agents/specs/sdd/design/{lifecycle-model.md,provenance-model.md}` (enum mentions) + conductor/README.md:349
- Note: no frozen scenario encodes "off-enum cause is illegal" — the legality rule is SKILL prose only,
  so the nudge contradicts no frozen scenario (no Conflict, no re-open).
- Standing followup 263-op6-m2 already requested the clearance reconciliation — this CR discharges it.

## Spec-judge round 1 (blocked on preflight) — resolved

- Preflight fail: declared set omitted oracle/builder/architect-spec bars → re-loaded + re-declared.
- Node-boundary: removed the "stays matchable" scenario (asserted the Scanner's consumer act).
- Builder per-site gap: added the correction-site enum-fit companion.
- Corrections recorded: cause-enum-conformance.log.jsonl seq1-3 (2 off-enum, dogfooded cause-candidate).

## NEXT

STOPPED at handoff for the in-session channel-holder. Both gates self-asserted `by: agent` in
`ledger/cause-enum-conformance.7a5176.jsonl` (spec seq2, impl seq3); root `spec.md` status untouched
(additive self-clears, stays `implemented`). Deliver commit: `71c05cc8` on branch
`worktree-agent-a764fa2637eccca36`, rebased onto main `2891e9b9`. No PR opened, no merge, no human
ratification written — those are the channel-holder's. To land: ratify (`by: <name>` gate lines) and
merge the branch. Standing followup `263-op6-m2` (clearance reconciliation) is DISCHARGED by this CR.
Two backlog followups recorded (ledger seq4/5) — not filed (no forge for the self-spec; drain deferred).

## CR link

Headless doctrine CR-2, ratified KEEP. Source: `.agents/specs/sdd/ledger/strategy.0bfda2.jsonl` seq2 +
enum-conformance cluster (`strategy.2d9bbc` seq4/9/10).
