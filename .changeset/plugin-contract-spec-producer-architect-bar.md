---
"cyber-sdd": patch
---

**Fix** — `plugin-contract-governance`'s role-loads table dropped `architect-spec` from the
spec-producer row, so plugin authors built agents that loaded three bars and were graded against
four.

The table contradicted its own preamble two lines above it, which states the spec-gate lens set as
`{oracle, builder, architect}` and that "a producer self-aligns to exactly the bars its judge
grades". The impl-producer row one line below correctly carried its `architect-impl` bar against its
own `{builder, architect}` set, which is what identifies the spec-producer row as a dropped cell
rather than a deliberate narrowing. `spec-producer-governance` — the procedural authority — and
`design/specialists-and-squads.md` — the table's declared owner — both name all three bars.

The cost was measured, not theoretical: six of six cold spec-judges blocked at governance pre-flight
on a plugin built to this row, and when the affected nodes were re-authored with the missing bar
loaded, six of six carried a real defect only that bar caught.

Also notes in the table's preamble that it is a shipped copy of a spec-owned table, restated because
a governance loads standalone and cannot reach the spec tree — so a row missing part of its lens set
should be read as a transcription slip.
