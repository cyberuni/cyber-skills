---
"cyber-sdd": minor
---

The doctrine-loop Scanner now cross-checks each plan brief's own `todos-all-done` against its
declared `source-closed` during its pass, and derives a **retirement clearance set** from
agreement — feeding it to `plan-retirement`'s existing `--retire` clearance-set input instead of a
human hand-assembling it. It never autofixes a plan brief's frontmatter `status` (no legal terminal
value exists for that field); a disagreement between the two signals is excluded from the clearance
set and surfaced as a flagged finding in the Scanner's pass summary instead.
