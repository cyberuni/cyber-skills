---
title: Skill Design
description: Rules for authoring SKILL.md files that agents load on demand.
---

**Load:** `npx cyberplace@<version> governance show skill-design`

Rules for authoring `SKILL.md` files that agents load on demand. Apply when creating, generalizing, or auditing a skill.

## Core principles

### Decisions over documentation

Encode what to decide and how. Do not repeat generic best practices or facts the model can derive without the skill.

### Narrow and composable

One workflow per skill. A skill is selected one of three ways — matched against a situation, named by a caller, or fired by an event. Declare that choice in the `description`; never infer it from a visibility flag.

- Name-only skills (loaded by name from another skill) set the `description` to exactly `"By name only"` — nothing else. The minimal description is the mechanism, not a label: it is the only surface the model matches against. Identity goes in the body and README.
- `user-invocable` is a visibility flag only — it controls command-list presence and never determines how a skill is selected.
- Neither type should be loaded as ambient context.

### No baked-in opinions

Detect the user's setup (package manager, monorepo shape, editor, OS paths) at runtime. If the skill only applies to one stack, say so explicitly in the description.

## Structure

`SKILL.md` must be agent-first — dense normative rules the agent executes without opening linked files first.

```markdown
# Skill Title
## When to use / Prerequisites   # short scope
## Workflow                      # numbered steps, decision logic
## Anti-patterns                 # optional
## References                    # on-demand standards, external URLs — no repo file paths
```

- No `## Why`, `## Rationale`, `## Background`, or `## Context` sections
- No causal explanation ("because…") in the body
- Optional depth goes in `## References` at the end only

## Frontmatter

```yaml
---
name: my-skill
activation: per-situation
description: "Use this skill when <trigger>. <One-line summary.>"
---
```

- `name` must match the parent directory name exactly
- `description` must contain `"Use this skill when"` or `"When to use"` trigger language
- Keep `description` ≤ 120 characters — long descriptions are truncated in agent context

### Runtime fields

Support varies by harness; the notes below are Claude Code's documented behavior. Set none of these unless the skill needs them — each is a deviation a reader has to account for.

| Field | Effect |
| --- | --- |
| `allowed-tools` | **Pre-approves** the listed tools for the invoking turn. Does not restrict the pool — every other tool stays callable. Clears on the next user message. |
| `disallowed-tools` | Removes tools from the pool while the skill is active. This is the field that restricts. |
| `model` | Model to use while active. Turn-scoped — the session model resumes on the next prompt. |
| `effort` | Effort level while active: `low`, `medium`, `high`, `xhigh`, `max`. Same turn-scoped lifetime. |
| `context: fork` | Runs the skill in a subagent with the body as the task. Pair with `agent:`. Only for a skill that states a task — a reference or stance skill forked this way gets no actionable prompt. |
| `paths` | Glob patterns limiting automatic activation to matching files. |

A skill cannot express a tool **allowlist**. A hard allowlist, `permissionMode`, `maxTurns`, persistent `memory`, `mcpServers`, and worktree `isolation` remain agent-definition fields — reach for an agent definition when one of those is the requirement, not for `model` or `effort` alone. See [Skills › Runtime fields](/agent-configuration/skills/overview/#runtime-fields).

## Activation

| `activation` | Claude Code | Cursor | Codex |
| ------------ | ----------- | ------ | ----- |
| `per-situation` | — | — | — |
| `session-start` | `SessionStart` | `sessionStart` | `SessionStart` |
| `post-tool-use` | `PostToolUse` | `postToolUse` | `PostToolUse` |
| `stop` | `Stop` | `stop` | `Stop` |

Default: omit or `per-situation` — no hook; activated via description match or explicit invoke.

Register hook-backed skills with `npx cyberplace@<version> hook register --event SessionStart`.

## Placement

| Placement | Location | Use case |
| --------- | -------- | -------- |
| **User** | `~/.agents/skills/<name>/` | Personal skills across all projects |
| **Project private** | `.agents/skills/<name>/` | Contributor tooling; must include `metadata: internal: true` |
| **Project public** | `skills/<name>/` | Shipped with a package via `npx skills add` |

## Progressive disclosure

Keep `SKILL.md` under ~500 lines. Move detailed reference material to sibling files (`reference.md`, `examples.md`) in the same skill folder. Link sibling files **only from References** — agents read them when stuck, not by default.

## Extract deterministic logic

When a step produces the same output given the same input and needs no judgment, move it to a script in `scripts/` or an existing project CLI. The skill retains **when** to invoke; the tool retains **how**.

When the skill includes `scripts/` or documents CLI commands, load the **agent-tool-output** governance before authoring them.

## `skill.json` (optional)

Install-time metadata sidecar — not loaded into agent context. Use `distribution.install_via: "package_manager"` when the skill requires a released npm binary.

## Anti-patterns

- Rationale or "because…" prose in the body
- `## Why`, `## Rationale`, `## Background` sections
- Links to repository files mid-workflow
- Mid-body links to sibling skill files
