---
"cyberlegion": minor
---

**BREAKING** — the spawn wake now carries the brief instruction, and the SessionStart hook no longer
injects a brief.

`unit spawn`'s first-turn doorbell used to be content-free (`"Your brief is loaded in context — read
it and begin work."`) because the peer's brief was injected into its context by the peer's own
`mail hook` SessionStart branch. That made brief pickup depend on a hook firing in the child — in the
child's harness, with the hub's hook correctly installed — none of which the spawning side can
observe. When the chain broke, the peer was woken and told to read a brief that was not there.

The doorbell is now the instruction itself, naming the brief's **file path**: *read your brief at
`<path>`, then begin work*. The brief is still written to its file and still never typed into the
pane, so the wake stays one bounded line however large the brief is.

What changes for consumers:

- `SPAWN_DOORBELL` (constant) is replaced by `spawnDoorbell(briefPath)` (function).
- `WakeSpawnInput` gains a required `briefPath`.
- `mail hook` never emits a `## Your brief` section, on the first call or any later one.
- The `spawning` agent status is retired — `unit spawn` registers a peer `active` outright, since
  nothing flips it any more. A record migrated from an older hub may still carry `spawning`; reads
  preserve it verbatim and never coerce or normalize it. (`unit register` still asserts `active`, as
  it always has — that is an explicit re-registration, not a read normalizing a value.)
- `--no-wake` changed meaning without changing its flag: previously *no turn, brief auto-loaded*; now
  *no turn and brief unread on disk*. A caller driving the first turn itself must convey the path.

Supersedes ADR-0027; see ADR-0032.
