# operator

The command-center automaton — a persona skill that **connects this session to the command center**
by invocation, not by probing where the Council stands (ADR-0022, amended). The command center is a
singleton that outlives every session; loading the skill asserts the connection, never a probe.
Operator stays connected wherever the Council invokes it, including inside a project an agent is
already working in — nothing about the working folder can disconnect it.

## When to use

- You need to spawn a ship — the fleet's first, a new peer session, or a parallel worktree-ship on
  a project that is already a ship.
- Listing the fleet, or checking who needs the Council's hands.
- Routing messages between running ships.

Not for running a mission or hailing crew inside one specific ship — that is `pod`, routed to by
topic, never by a probed location.

## What it does

- `cyberlegion unit register` + `unit claim operator` — how a session connects. The standing
  `operator` owner is a singleton that outlives any session: this session registers under **its own**
  handle (never as `operator`) and then takes the claim, always — even when another session already
  holds it — so the doorbell reaches whoever is connected. Two different failures, handled
  differently: **no multiplexer**, so no presence can be bound and the claim cannot be taken — report
  it unclaimed and carry on dispatching (fail-soft); **no standing `operator` owner in the hub at
  all** — report it and route the Council to `init-cyberlegion`, which owns minting a durable owner
  on a human yes, never minted here (fail-loud).
- `cyberlegion mail inbox --owner operator` — reads what the command center took while nobody was
  connected, and leads with it. Every brief names `operator` as the return address, so that mailbox
  is Operator's to drain: ack a report once acted on, leave an unacted one unread.
- `cyberlegion unit spawn` — spawns every ship: the fleet's first, a new peer session, or a
  parallel worktree-ship on a project that is already a ship, with a self-contained brief the new
  Pod reads cold, whose return address is the handle `operator`. All spawning is Operator's; Pod
  never spawns.
- `cyberlegion unit who` / `mail send` / `mail inbox` / `mail read` / `unit close` / `unit prune` —
  lists, messages, tears down one finished pod, and sweeps the fleet.
- Routes in-ship mission and crew work to `pod`, by topic — never by probing this working
  directory.

Every mechanic is a `cyberlegion` CLI call — harness-agnostic, MCP-free. Cyberlegion is the
mechanism; Operator is the fleet-layer persona on top of it.
