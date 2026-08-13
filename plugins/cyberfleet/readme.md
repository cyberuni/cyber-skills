# cyberfleet

A harness-agnostic, MCP-free way to direct a fleet of AI-agents across your projects.

You're the **Council** — the human. You give directions and make decisions; the fleet is
autonomous and carries them out.

## Pod

The **Pod** is the bridge-companion automaton of a ship. A ship is a workspace: a folder, a
repository, or a worktree; your fleet is all the ships you've enlisted, across one project or many.
Pod greets you, clears the inbox, runs the mission, and hails specialist crew when a concern belongs
to one. When the work should fan out, it tells you that spawning a sister ship is the Operator's
job, which you invoke directly — Pod never spawns.

## Operator

The **Operator** is the dispatcher automaton of the **fleet** — it spawns every ship (your first, a
new peer session, or a parallel worktree-ship on a project already in flight), lists who's out
there, routes messages between ships, and sweeps away the dead ones. It's where you survey the fleet
and decide what sails next.

Operator sits at a **bunker seat**: a single dispatch desk that outlives any one session. Seating it
claims that desk — last claim wins — and behind the desk is a durable **mailbox** at the address
every brief names, so reports from ships that finished while nobody was watching are still waiting
when you sit back down. Operator leads with what's in that mailbox, and acks a report only once it's
been acted on. With no Council on the line at all, the same seat runs unattended as a lifecycle
loop: pull the ready missions, spawn a ship per mission, merge and retire each one as it lands.

## Crimp

Crew don't come bundled — the **Crimp** recruits them from the **Tavern**, the storefront of
installable **crews**, each a specialist you command through its own persona. Browse the roster,
pick the hands you need, and the Crimp signs them on — and discharges them, on your say-so, when
you're done with them.

## Mechanic

The **Mechanic** works the bench — it stamps a fresh automaton when the fleet needs one, and once a
crew is aboard it adjusts how that crew runs: the guidance it follows, the model it uses, how hard it
thinks, and how much leash it has before it checks back with you. It routes each of those to the
engine that owns it rather than doing the work itself.

## The two consoles

Under the automatons sit two CLIs — cold, deterministic mechanism with no judgment in it.

**`cyberlegion`** is the foundation, and it's where nearly every mechanic lives: identity
(`unit register`, `unit claim`, `unit who`), durable mail (`mail send`, `mail inbox`, `mail read`,
`mail await`), spawning a peer session in its own git worktree (`unit spawn`), reaping dead ones
(`unit prune`, `unit close`), and the pane layer (`mux`).

**`cyberfleet`** is the thin fleet layer on top, and carries only what is fleet-specific:

- `missions` — the Council view: ships × mission × gate × leash, derived from SDD state
- `jump` — focus a ship's pane, or print its worktree path to `cd` into
- `pause` — mark a ship's mission paused (a status marker only, not an SDD mission checkpoint)
- `gate approve` — deliberately stubbed: a Council ratification can't be safely relayed through a
  CLI, so it refuses and tells you to ratify in-session

The plugin (this one) adds the **automaton** layer over both — Pod, Operator, and the crew are the
agents that reason about the situation and reach for the right command underneath, which is usually
a `cyberlegion` one.

## The control panel

Each ship runs live in its own terminal pane, and the fleet drives your multiplexer to manage them
— opening a pane per ship, reading what's happening inside, and closing it when the work is done. The
whole fleet lays out as panes you can see and jump between, like a control panel of running ships.
Two multiplexers work today: **tmux**, and **herdr** — an agent-aware one that also reports whether
each ship is working, idle, or blocked. cyberlegion detects which you're running and drives it, and
refuses anything else up front rather than half-opening a session.

## Why no MCP

The usual way to wire agents together is MCP — which means running a server: a process to start, a
port to hold open, config to add to every harness. cyberfleet needs none of it.

- **Nothing to run.** No server, no port, no daemon to keep alive or secure — coordination lives in
  the project itself and rides each harness's own session-start hook.
- **Harness-agnostic by construction.** No vendor-specific protocol, so Claude Code, Cursor, and
  Codex all join the same fleet with no per-harness glue.
- **Portable and inspectable.** It's plain CLI calls end to end — easy to script, log, and debug,
  with nothing extra to stand up per project.

## Installation

Install the plugin:

```bash
npx skills add cyberuni/cyberplace --plugin cyberfleet --global
```

The automatons call the `cyberlegion` CLI for identity, mail, and spawning, so install that too:

```bash
npm install -g cyberlegion
```

Optionally, install the `cyberfleet` CLI globally if you want the fleet view from the command line:

```bash
npm install -g cyberfleet

pnpm add -g cyberfleet

bun add -g cyberfleet

yarn add -g cyberfleet
```
