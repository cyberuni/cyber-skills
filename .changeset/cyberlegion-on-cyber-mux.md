---
"cyberlegion": minor
---

**BREAKING** — the multiplexer fast-path environment variables are renamed, and the multiplexer
layer is now the `cyber-mux` package rather than a copy of it carried here.

- **`$CYBERLEGION_MUX` / `$CYBERLEGION_MUX_PANE` become `$CYBER_MUX` / `$CYBER_MUX_PANE`.**
  `mux doctor` now prints `export CYBER_MUX=<m> CYBER_MUX_PANE=<p>`, and `unit spawn` injects the
  new names into the pane it opens. **The old pair is still read**, but only when the new pair is
  absent, so a session that was already running when you upgrade keeps its identity instead of
  falling back to a process-tree walk that answers for a different pane. That fallback is
  transitional and will be removed — re-pin anything that sets these names by hand.

- **`cyber-mux` is now a dependency** (pinned exact). `packages/cyberlegion/src/console/` had been a
  fork of that package's source since the extraction, and the two had drifted with the package
  moving and the copy standing still. Every improvement landed upstream since was invisible here.

- **A detected multiplexer that a unit record cannot name is now refused, by name, before anything
  opens.** `cyber-mux` drives four backends; a unit's pane pointer can only be stored for tmux and
  herdr. Previously such an environment reported that no multiplexer was running, which was a lie
  when you were plainly inside one; opening there would have stranded a live session that `unit
  prune` could never reap and no caller could reach.

- **A `--at pane:right` / `pane:down` spawn now splits the calling pane.** Both backends default to
  splitting the pane a *human* is looking at, which matches the caller's only by coincidence and
  diverges exactly when a program is driving — which `unit spawn` always is.

Library consumers: the re-exported multiplexer types are now `cyber-mux`'s (`MuxAdapter`,
`MuxTarget`, `MuxPlacement`), and `send` is `sendText`. Note that `sendText` types text **without**
submitting it; `submit(target, text)` is the equivalent of the old `send`.
