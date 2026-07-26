---
title: Agent Configuration
description: What agent configuration is — the collective term for all instructions an agent runtime loads to shape behavior.
---

**Agent configuration** is the collective term for all the instructions an agent runtime loads to shape how it behaves. A change to any of these files changes how the agent responds, decides, and acts — making them the primary unit of quality control in agentic workflows.

## Kinds of file

Agent configuration is not one file format — it is several, each with its own location, distribution path, and dedicated doc:

| File | Distribution | Doc |
| ---- | ------------- | --- |
| **`AGENTS.md`** (repo root) | Repo-local. The one canonical file this repo edits directly | [Disciplines](/concepts/disciplines/) |
| **`CLAUDE.md`** (repo root) | Repo-local. A symlink to `AGENTS.md`, not a second source of truth — Claude Code reads `CLAUDE.md` by convention, so the repo points it at the real file instead of duplicating content | [Disciplines](/concepts/disciplines/) |
| **`SKILL.md`** | Repo-local (`.agents/skills/`, `skills/`) or plugin-shipped via the `skills` field | [Skills](/concepts/skills/) |
| **`agents/*.md`** | Repo-local or plugin-shipped via the `agents` field | [Persona](/concepts/persona/) |
| **`.cursor/rules/*.mdc`** | Cursor's own always-on mechanism — the rough equivalent of an `AGENTS.md` section, but Cursor-native and `alwaysApply`-gated. Repo-local or plugin-shipped via the `rules` field (Cursor-only; other harnesses ignore it) | [Disciplines](/concepts/disciplines/) |
| **`governances/*.md`** | Repo-local; loaded out-of-band via the `governance show` CLI, never auto-loaded by the harness | [Governances](/concepts/governances/) |
| **`settings.json`** | Repo-local, harness-specific | [Permissions](/concepts/permissions/) |
| **`commands/*.md`** | Repo-local or plugin-shipped via the `commands` field | [Commands](/concepts/commands/) |

Two root files, one source of truth: never edit `AGENTS.md` and `CLAUDE.md` as if they were independent — edit `AGENTS.md` and let the symlink carry it to Claude Code.

Each file kind's own doc covers what it encodes, when it activates, and how it distributes. This page stays at the index level — see [Related](#related) for the full set.

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
- [Spec Dependencies](/concepts/spec-dependencies/) — why `AGENTS.md` is the composition root for cross-references
