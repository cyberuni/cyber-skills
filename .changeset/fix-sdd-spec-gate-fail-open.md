---
"cyber-sdd": patch
---

SDD spec-gate checks escalate malformed input instead of failing open. A root `spec.md` whose `status` is missing or outside the lifecycle enum is now a `check-spec-state` violation, and a per-project `check-project-specs` run that finds such a spec escalates instead of reporting "no spec governs — skipped" with exit 0 (#316). A `## Use Cases` data row whose `Scenario` cell is empty or absent is reported like an un-backticked one, rather than skipped (#364). Also drops the dangling spec-tree pointers shipped scripts and skills cited — a repo-only path is a broken link for every installed user (#290).
