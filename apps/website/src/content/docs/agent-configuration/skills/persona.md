---
title: Persona
description: What personas are — agent identity definitions that bundle role, expertise, permissions, and constraints into a named, invocable subagent.
---

**Personas** are agent identity definitions — they encode who an agent is, not what workflow it runs. A persona bundles role framing, expertise, permissions, and constraints into a single named, invocable unit. When a parent agent spawns a subagent, it is instantiating a persona.

**Tagline:** Skills define what to do. Personas define who does it.

## What a persona encodes

A persona is an agent definition file (`agents/*.md`) with two layers:

**Identity layer** (who the agent is):
- Role framing — "you are a senior code reviewer specializing in security"
- Expertise — domain knowledge the agent should apply
- Voice and tone — how the agent communicates

**Capability layer** (what the agent can do and how far it can go):
- `tools` / `disallowedTools` — [permissions](/concepts/permissions/) for this agent
- `maxTurns` / `effort` — [constraints](/concepts/constraints/) for this agent
- `skills` — which skills are **preloaded** into this agent at startup
- `model` — which model this agent uses

The identity layer shapes behavior through instruction. The capability layer shapes behavior through enforcement.

`skills` is a preload list, not an access list. It injects each named skill's full content into the agent's context at startup; it does not gate what the agent may load later, which stays open through the Skill tool unless you remove that tool.

That makes it the right way to carry an identity layer that other callers also need. A voice, a house style, a review standard — write it once as a skill, name it in `skills`, and the same text serves both the spawned agent and any in-session load. Writing it into the agent body instead strands it there: the only ways back to it are spawning the agent or reading its file by path.

A skill named this way must stay model-invocable. `disable-model-invocation: true` blocks preloading, since preloading draws from the same pool the model may invoke.

## As a delegated responsibility

A persona is usually the **delegate**, not the delegator: another artifact — commonly a [Gateway skill](/agent-configuration/skills/gateway-skill/) — owns a required job (an operation menu, a routing decision) and hands off only the voice or judgment layer to a persona it resolves by name, falling back to a bundled default if none is supplied. See [Responsibility](/agent-configuration/skills/responsibility/) for the Required / Optional / Delegated axis this realizes, and its worked example.

A persona filling this role is `agent-only` and selected `by-name`, not the `explicit`/`user` combination in the table below — it exists to be loaded by its caller, not invoked directly.

## Personas vs Skills vs Subagent definitions

These three are often confused:

| | Persona | Skill | Subagent definition |
|---|---|---|---|
| **What it encodes** | Who the agent is | What workflow to run | Same as persona — persona is the term for the concept; subagent definition is the implementation artifact |
| **Activation** | Spawned by parent agent | Invoked by agent matching a situation | Spawned by parent agent |
| **Reusability** | Yes — any agent can spawn it | Yes — any agent can invoke it | Yes |

"Subagent definition" is the file format. "Persona" is the concept. They are the same thing named differently by layer.

## Plugin distribution

Personas travel in the `agents/` directory of a plugin. Installing a plugin that includes agents makes those personas available as named subagents the harness can invoke.

A plugin can both **provide** and **consume** personas:
- **Provide** — `sdd` plugin ships `sdd-judge`, an agent that evaluates spec quality
- **Consume** — `aced` plugin spawns `sdd-judge` as a subagent when evaluating SDD artifacts

This is the primary cross-plugin integration pattern: one plugin's persona becomes a tool in another plugin's workflow.

**In the plugin schema:**

| Schema | Field |
|--------|-------|
| Claude Code | `agents` (path to agent definition files) |
| Open Plugin Spec | `agents` (same pattern) |

**Agent frontmatter fields that define a persona:**

```markdown
---
name: my-agent
description: What this agent specializes in — used by parent agents to decide when to spawn it
model: sonnet
effort: medium
maxTurns: 20
tools: [Read, Bash, WebSearch]
disallowedTools: [Write, Edit]
skills: [code-reviewer]
---

You are a [role framing here]...
```

## Related

- [Permissions](/concepts/permissions/) — tool boundaries bundled in a persona
- [Constraints](/concepts/constraints/) — behavioral limits bundled in a persona
- [Skills](/agent-configuration/skills/overview/) — on-demand workflows a persona can invoke
- [Responsibility](/agent-configuration/skills/responsibility/) — Required / Optional / Delegated; a persona as the usual delegate
- [Gateway Skill](/agent-configuration/skills/gateway-skill/) — the typical delegator
- [Agent Configuration](/agent-configuration/overview/) — full picture of what shapes agent behavior
