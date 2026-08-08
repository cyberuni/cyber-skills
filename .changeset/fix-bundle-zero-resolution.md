---
"universal-plugin": patch
---

`plugin bundle` no longer reports a clean bundle when it resolved nothing (#315).

`--root` is now resolved to an absolute path and workspace discovery walks up for the
`pnpm-workspace.yaml` marker, so the same plugin resolves the same workspace whichever directory
`bundle` ran from — `--root .` from inside a plugin directory previously resolved zero packages,
counted every pin as `skipped`, and still exited 0.

When every referenced package is skipped, `bundle` now warns with the count
(`resolved 0 of N referenced package(s) against the workspace`) and prints a corrective next-step
instead of "review and commit the pinned skills", so a zero-resolution can no longer be mistaken for
a bundled plugin at release time.
