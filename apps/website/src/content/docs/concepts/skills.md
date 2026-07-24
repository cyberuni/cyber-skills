---
title: Skills
description: What skills are — on-demand workflow instructions an agent loads, the axes that distinguish one kind of skill from another, and how they differ from personas and governances.
---

**Skills** are on-demand workflow instructions — they encode what to do, not who does it. A skill is a `SKILL.md` file the agent loads when its `description` matches the current situation; unlike a persona, invoking a skill does not spawn a new agent identity, it adds instructions to whichever agent is already running.

**Tagline:** Skills define what to do. [Personas](/concepts/persona/) define who does it.

## What a skill encodes

A `SKILL.md` file has two parts:

- **`description` frontmatter** — the only field loaded at startup; it carries the entire triggering burden. A well-formed description states the capability, "Use this skill when…", and at least one implicit phrasing an agent might not otherwise connect to the trigger.
- **Body** — the workflow itself: numbered steps for a process skill, tool usage and guardrails for a tool-based skill, or rules and pass conditions for a standard (tone/format/quality) skill.

Skills stay narrow and composable by design: one workflow per skill.

## Kinds of skill

"What kind of skill is this?" has no single answer, because **kind is not one axis**. A skill is selected some way, by someone, to change something. Three independent questions, asked every time:

| Axis | Question | Values |
|---|---|---|
| **Selection** | How does this skill get chosen? | situational · by-name · event |
| **Visibility** | Who is allowed to choose it? | user · agent-only |
| **Effect** | What does running it change? | action · routing · stance · reference |

The familiar names are **recognizable combinations** of these values, not slots in a list. They cross-cut.

| Kind | Selection | Visibility | Effect |
|---|---|---|---|
| Public skill | situational | user | action |
| [Gateway skill](/concepts/gateway-skill/) | situational or explicit | user | routing |
| [Persona skill](/concepts/persona/) | explicit | user | stance |
| [Discipline](/concepts/disciplines/) | event | — | stance |
| Name-only skill | by-name | agent-only | action or reference |

**Public skill** is the default — its description states the situations it serves, the agent matches that against the request, and the user can invoke it directly. Everything else is a deviation from it.

**Gateway skills** own the front door of an opt-in workflow: they activate it, gather intent the request did not supply, load the workflow's rules, and route to a narrower skill. What marks a gateway is its behavior when it *cannot* infer intent — it asks, rather than guessing or failing.

**Persona skills** alter how the agent behaves rather than performing a task, and take no action of their own. They come in two realizations: as a *subagent* (an agent definition in `agents/`, spawned with its own tools and limits) or as a *skill* (a stance loaded into the current session via `metadata.persona`). Spawning gets isolation; loading gets continuity.

**Disciplines** are stances that are always on, selected by an event — a session starting, a tool finishing — rather than by a request.

### Selection and Visibility are not the same question

These two get collapsed, and the collapse causes real breakage.

- *Selection* is how the model finds the skill: by matching your situation against its description, or because something named it outright.
- *Visibility* is whether the skill appears in the user's command list.

They feel identical — a skill you can't see is one you can't ask for — but they are not. A skill can be **hidden yet situational**: a governance rule that should load automatically when a relevant tool runs, while being noise in a command menu.

So **a visibility flag must never be read as a selection signal**. If a tool treats "hidden" as proof of "loaded by name only", it will demand that skill drop its trigger language, and the automatic loading it depended on breaks. Hiding a skill is a statement about the *menu*. Having no trigger is a statement about the *description*.

## Name-only skills

A **name-only skill** is triggered by name and never by situation. Its caller knows to invoke it; nothing should ever match it against a user's request.

The rule that follows is the important part:

> **A name-only skill's description is kept to the minimum.**

This is not a labeling convention. It is the mechanism. The description is the only thing the model matches against, so a description with nothing in it to match is a skill that cannot be selected by accident. Anything you add — a summary of what it does, the caller's name, an example — is another handle for a spurious match to grab.

Declare it by making the description exactly the marker, and nothing else:

```yaml
---
name: resolve-governances
description: "By name only"
---
```

Two consequences worth accepting up front:

- **All name-only skills share one description.** That is correct. They are distinguished by `name`, which is how their callers address them. A description exists to answer "should I load this?" — and for these, the answer is always "only if you were told to."
- **Identity moves to the body and README.** What the skill is, who calls it, and what it returns are documentation, not selection criteria.

A caller addresses one by `name`, directly. A caller may also resolve *which* name to invoke first — from a registry, or by matching frontmatter metadata — and then load the result by name. That resolution step is something a workflow builds for itself; the selection is still by name at the point of loading.

**Skills that are not meant to run alone.** Some name-only skills are fragments: a criteria set a producer aligns itself to, a step factored out of a longer procedure. Running one standalone is not forbidden so much as meaningless. This is worth saying in the skill's README, and it changes nothing mechanically — a fragment and a self-contained engine are selected the same way and both keep minimal descriptions. Treat it as documentation, not as a kind.

A name-only skill whose effect is **reference** is read as criteria rather than executed as steps — producers load it to align, judges load it to grade. See [Governances](/concepts/governances/).

## Placement

| Placement | Location | Use case |
| --------- | -------- | -------- |
| **User** | `~/.agents/skills/<name>/` | Personal skills across all projects |
| **Project private** | `.agents/skills/<name>/` | Contributor tooling scoped to one repo |
| **Project public** | `skills/<name>/` | Shipped with a package; users install via `npx skills add` |

Placement is orthogonal to kind, as are **distribution** (whether the skill ships to other repos) and **pattern** (the workflow shape of the body: process, tool-based, standard, persona). Every skill has a value on every axis at once — a project-public, process-pattern, situational, user-visible skill with an action effect is just "a normal skill". The names above only get used when something deviates.

## Skills vs Personas vs Governances

These three are often confused:

| | Skill | Persona | Governance |
|---|---|---|---|
| **What it encodes** | What workflow to run | Who the agent is | What correct looks like for a domain |
| **Activation** | Invoked by the agent matching a situation | Spawned as a new subagent | Loaded on demand, e.g. via `governance show` |
| **Changes agent identity?** | No — runs in the current agent's context | Yes — a new role, expertise, and capability bundle | No — a reference document, never executed as steps |

A skill can *invoke* a persona (spawning a subagent for part of its workflow) and can *load* a governance (reading its rules before acting), but a skill is neither of those things itself.

## Plugin distribution

Skills travel in the `skills` field of a plugin manifest. Installing a plugin that includes skills makes them available to the agent runtime — the description is scanned at startup, the body is loaded only once the skill activates.

**In the plugin schema:**

| Schema | Field |
|--------|-------|
| Claude Code | `skills` (path to `SKILL.md` files) |
| Open Plugin Spec | `skills` (same pattern) |

**Frontmatter fields that define a skill:**

```markdown
---
name: my-skill
description: Use this skill when <trigger>. <One-line capability summary.>
---

# My Skill

## When to use
<the trigger condition, restated for the body>

## Instructions
1. <step>
2. <step>
```

## Related

- [Gateway Skill](/concepts/gateway-skill/) — workflow entrypoints that route an opt-in workflow
- [Persona](/concepts/persona/) — bundled agent identity a skill can invoke as a subagent
- [Governances](/concepts/governances/) — normative rules a skill loads to stay aligned
- [Disciplines](/concepts/disciplines/) — always-on behavioral habits
- [Agent Configuration](/concepts/agent-configuration/) — full picture of what shapes agent behavior
- [Marketplace](/marketplace/) — the plugins and skills shipped with this repo
