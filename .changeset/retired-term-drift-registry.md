---
"cyber-sdd": minor
---

Add `check-retired-terms` — a declared registry of retired paths and conventions (`.agents/sdd/retired-terms.toml`) plus a verify-time sweep over every git-tracked file that reports each surviving occurrence as `file:line:term` with its replacement and exits non-zero. Narrowed by built-in exclusions (the guard's own definition, durable provenance), a per-entry scope, and a two-form allow list. A malformed registry fails loud rather than falling back — the registry is the check.
