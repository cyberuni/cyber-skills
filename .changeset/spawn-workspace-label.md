---
"cyberlegion": minor
---

`unit spawn --at workspace` now opens the unit's own space under a short, human-identifiable name
instead of the backend's default, so a session is findable by eye rather than by reading every
workspace.

The name is `<code>-<subject>`, capped at 30 characters including the code.

- **Code** — a NieR YoRHa unit class read off the brief's leading action word in one fixed order:
  `A2-` when the action tears down or reverts, else `9S-` when it is read-only recon (investigate,
  audit, review, diagnose and kin), else `2B-`, the build-and-change class and the default when the
  leading word matches no action at all. The same brief always yields the same code.
- **Subject** — `--handle` when given, otherwise the brief's first non-empty line: lowercased, a
  recognized action word and any leading article dropped, non-alphanumerics collapsed to `-`, then
  whole words taken while they fit, so the name ends on a complete word. A brief that yields nothing
  usable falls back to the unit's own 6-character short id.

Only a `workspace` placement is named. A `pane:*` or `tab` placement opens into a space the caller is
already in, so it carries no name and never renames that space.

Examples: `--task "add a retry budget to the mail poller"` → `2B-retry-budget-to-the-mail`;
`--task "prune the stale pane index"` → `A2-stale-pane-index`; `--task "diagnose the boot race"
--handle scribe` → `9S-scribe`.
