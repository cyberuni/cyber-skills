---
title: Agent Configuration
description: What agent configuration is — the collective term for all instructions an agent runtime loads to shape behavior.
---

**Agent configuration** is the collective term for all the instructions an agent runtime loads to shape how it behaves. A change to any of these files changes how the agent responds, decides, and acts — making them the primary unit of quality control in agentic workflows.

## Kinds of file

Every agent harness natively supports a small set of file kinds, independent of anything this repo layers on top:

| File kind | What it configures | When active |
| --------- | ------------------- | ----------- |
| **Persistent instructions** (`AGENTS.md`, `CLAUDE.md`, always-on rules like `.cursor/rules/*.mdc`) | Always-on project context and behavioral habits | Every session, every subagent |
| **Skills** (`SKILL.md`) | On-demand workflow instructions | Loaded when a situation matches, or a caller names it |
| **Commands** (`commands/*.md`, or a skill with auto-invocation disabled) | Explicit, user-triggered workflow | Invoked by the user via `/name` only |
| **Subagent definitions** (`agents/*.md`) | A separate agent: identity, tools, limits, preloaded skills | Whenever spawned by a parent agent |
| **Settings** (`settings.json`) | Tool permissions and hook registration for the main agent | Enforced on every tool call or lifecycle event |

Two root files, one source of truth: never edit `AGENTS.md` and `CLAUDE.md` as if they were independent — edit `AGENTS.md` and let the symlink carry it to Claude Code.

This repo draws further distinctions *within* these primitives — [governance](/concepts/governances/) (a reference doc loaded via CLI convention, not a harness file kind of its own), [discipline](/concepts/disciplines/) (a name for the persistent-instructions row above), [permissions](/concepts/permissions/) and [constraints](/concepts/constraints/) (capabilities expressed through subagent-definition frontmatter and settings), and [persona](/concepts/persona/) (the concept a subagent definition encodes). Each has its own page; this page stays at the harness-primitive level.

## Plugin distribution

Plugins are the distribution unit for agent configuration. A plugin can provide any combination of file kinds:

| Plugin field | File kind distributed |
|---|---|
| `skills` | `SKILL.md` |
| `commands` | `commands/*.md` |
| `agents` | `agents/*.md` |
| `rules` | `.cursor/rules/*.mdc` — Cursor-only; silently ignored by other harnesses |
| `hooks` | Hook registrations (SessionStart, PermissionRequest) |
| `mcpServers` | Tool contracts (typed tool schemas) |
| *(no field — CLI)* | `governances/*.md` — loaded out-of-band via `governance show` |

There is no plugin field for `AGENTS.md`/`CLAUDE.md` content itself — a plugin can ship disciplines via `rules` or `hooks`, but the repo's own root file is authored once, locally, not distributed.

**Cross-plugin patterns:** One plugin's persona can be consumed as a subagent by another plugin's skills. Example: the `sdd` plugin provides `sdd-judge`; the `aced` plugin spawns `sdd-judge` to evaluate spec quality. Neither plugin has a hard `dependency` on the other — the integration is a workflow convention, not a schema constraint.

**Open Plugin Spec** defines `rules` as its schema-level name for the same Cursor-style always-on rule file (`.mdc`, with `description`/`alwaysApply`/`globs`). Cursor implements it; Claude Code does not, despite the spec naming Claude Code a conformant host. No spec or harness has a schema-level equivalent to `governance show` — governances travel via CLI convention only, on every harness.

## Why it matters

Agent configuration has the same failure modes as LLM prompts:

- **Silent regression** — editing a skill changes behavior without any signal that something broke
- **Trigger mismatch** — a skill's `description:` doesn't match when agents actually invoke it
- **Ambiguous rules** — vague language in `AGENTS.md` causes inconsistent agent behavior
- **Coverage gaps** — instructions work for common cases but fail silently on edge cases

Unlike code, agent configuration has no type-checker, no linter, and no test runner built in. Correctness is measured by whether the agent does the right thing in real situations — which requires explicit evaluation.

## Evaluation

[ACED (Agent Config Evaluation System)](/aced/overview/) provides layered evaluation for agent configuration:

1. **Structural** — does the file have the required fields and format?
2. **Trigger** — does the agent correctly identify when to invoke this file?
3. **Behavior** — when invoked, does the agent follow the steps and rules?
4. **Quality** — is the output the agent produces actually good?

## Related

- [Skills](/concepts/skills/) — `SKILL.md`, on-demand workflows
- [Governances](/concepts/governances/) — `governances/*.md`, normative domain standards
- [Disciplines](/concepts/disciplines/) — always-on behavioral habits in `AGENTS.md`
- [Permissions](/concepts/permissions/) — tool capability boundaries in `settings.json`
- [Constraints](/concepts/constraints/) — hard behavioral limits and guardrails
- [Persona](/concepts/persona/) — `agents/*.md`, bundled agent identity + permissions + constraints
- [Commands](/concepts/commands/) — `commands/*.md`, explicit slash-command entries
- [Commit Discipline](/disciplines/commit-discipline/) — example of an always-on discipline
- [ACED Overview](/aced/overview/) — eval system for agent configuration
- the `init` skill (`cyberspace` plugin) — sets up `AGENTS.md` for a repo
- [Spec Dependencies](/sdd/spec-dependencies/) — why `AGENTS.md` is the composition root for cross-references
