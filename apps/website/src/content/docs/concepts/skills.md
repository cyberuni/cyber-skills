---
title: Skills
description: What skills are — the instructions an agent loads to do a piece of work, the axes that distinguish one kind of skill from another, and the rule for skills triggered by name only.
---

**Skills** are instructions an agent loads on demand to do a piece of work. A skill is a `SKILL.md` file: frontmatter that governs when it loads, and a body the agent follows once it has.

This page is the overview. **Commands, gateway skills, personas, governances, and disciplines are all skills** — they differ only in how they get selected, who is allowed to select them, and what running them changes. Those axes, and the kinds they produce, are below.

## What a skill encodes

A `SKILL.md` file has two parts:

- **`description` frontmatter** — the only field loaded at startup, and the entire basis on which the model decides whether to load the body. For a situational skill it states the capability, "Use this skill when…", and at least one implicit phrasing an agent might not otherwise connect to the trigger. For a skill that should never be matched, it is kept deliberately empty of anything matchable — see [Name-only skills](#name-only-skills).
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
| [Command](/concepts/commands/) | explicit | user | action |
| [Gateway skill](/concepts/gateway-skill/) | situational or explicit | user | routing |
| [Persona skill](/concepts/persona/) | explicit | user | stance |
| [Discipline](/concepts/disciplines/) | event | — | stance |
| Name-only skill | by-name | agent-only | action or reference |

Every row is a skill. Commands, gateways, personas, and disciplines are not separate artifacts that sit *beside* skills — they are skills whose values on these three axes differ from the default. Three of them also have a non-skill realization: a persona can instead be a subagent definition in `agents/`, a governance can be a file loaded via `governance show`, and a discipline can arrive through `AGENTS.md` or a hook rather than a skill.

**Public skill** is the default — its description states the situations it serves, the agent matches that against the request, and the user can invoke it directly. Everything else is a deviation from it.

**Private skill** is not another row in the kinds table — it is a Public skill's *marketplace-visibility* counterpart, declared by `metadata: internal: true` in frontmatter rather than by any Selection/Visibility/Effect value. It says "not shipped via `npx skills add`," nothing about how or by whom the skill gets selected. A private skill still defaults to situational/user/action; the flag changes distribution, not kind — see [Placement](#placement).

**Commands** are skills the user invokes explicitly via `/name`, with automatic invocation suppressed. Use them where accidental auto-invocation would be disruptive — deployments, releases.

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

## Runtime fields

The three axes above describe *selection*. A second, independent question is what a skill is allowed to change about the run itself once it loads — the model, the effort level, the tool pool, whether it executes inline or in a subagent.

This is where a stale assumption is common: that a skill is "just instructions" and anything about *how* the agent runs has to be an agent definition. That was true once. It is not the current contract.

| Field | Effect |
| --- | --- |
| `model` | Model to use while the skill is active |
| `effort` | Effort level while the skill is active |
| `allowed-tools` | **Pre-approves** tools for the invoking turn — does not restrict the pool |
| `disallowed-tools` | Removes tools from the pool while the skill is active |
| `context: fork` + `agent` | Run the skill in a subagent, with the body as the task |
| `paths` | Limit automatic activation to matching files |

Two details worth holding on to, because they are the ones that bite:

- **`allowed-tools` grants, it does not fence.** Listing `Read` does not stop the skill from writing files. Use `disallowed-tools` to take a tool away.
- **`model` and `effort` on a skill are turn-scoped.** They apply for the rest of the invoking turn and then the session reverts. An agent definition's apply for that subagent's whole life.

### What still requires an agent definition

A skill cannot express a tool **allowlist** — "only these tools, nothing else". `allowed-tools` grants and `disallowed-tools` denies; neither closes the set. Nor can it set `permissionMode`, `maxTurns`, persistent `memory`, `mcpServers`, or worktree `isolation`.

Those are the honest reasons to reach for an agent definition. Wanting a different model or a higher effort level is not one.

### Composing the two

The two artifacts compose in both directions, and the direction you want depends on which one owns the task:

| Direction | System prompt | The task is | Use when |
|---|---|---|---|
| Agent definition with `skills:` | the agent's body | the delegation message | the skill is **reference** — a voice, a standard, a convention set |
| Skill with `context: fork` | the agent type's | the skill body | the skill is a **task** with explicit steps |

`skills:` preloads the full skill content into the subagent at startup — the supported way to keep one body of content and reach it from both an in-session load and a delegated run, with no duplicated text and no reading another file by path.

One trap: a skill marked `disable-model-invocation: true` **cannot be preloaded**, because preloading draws from the same pool the model may invoke. If a skill needs to be both user-only and preloadable, those two requirements conflict — see [Name-only skills](#name-only-skills) for the description-based approach that does not.

## Placement

| Placement | Location | Use case |
| --------- | -------- | -------- |
| **User** | `~/.agents/skills/<name>/` | Personal skills across all projects |
| **Project private** | `.agents/skills/<name>/`, `metadata: internal: true` required | Contributor tooling scoped to one repo |
| **Project public** | `skills/<name>/` | Shipped with a package; users install via `npx skills add` |

Placement is orthogonal to kind, as are **distribution** (whether the skill ships to other repos) and **pattern** (the workflow shape of the body: process, tool-based, standard, persona). Every skill has a value on every axis at once — a project-public, process-pattern, situational, user-visible skill with an action effect is just "a normal skill". The names above only get used when something deviates.

## When a persona or governance is not a skill

Persona and governance each have a second realization that is *not* a skill, and that is the one usually being contrasted with skills:

| | Skill | Persona as subagent | Governance as file |
|---|---|---|---|
| **Artifact** | `SKILL.md` | an agent definition in `agents/` | `governances/*.md` |
| **How it loads** | into the context of the agent already running | spawned as a separate agent | read on demand, e.g. via `governance show` |
| **Changes agent identity?** | No | Yes — a new role, expertise, and capability bundle | No — a reference document, never executed as steps |

A skill can *spawn* a persona as a subagent, and can *load* a governance file. In those forms they are separate artifacts with their own mechanisms. As a persona **skill** or a governance **skill**, they are rows in the kinds table above — the same `SKILL.md` mechanism, differing only in their values on the three axes.

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

- [Purpose](/agent-configuration/purpose/) — what a *section* is for: procedure, criteria, policy, reference, menu, voice
- [Responsibility](/concepts/responsibility/) — the Required / Optional / Delegated axis, orthogonal to kind
- [Gateway Skill](/concepts/gateway-skill/) — workflow entrypoints that route an opt-in workflow
- [Persona](/concepts/persona/) — bundled agent identity a skill can invoke as a subagent
- [Governances](/concepts/governances/) — normative rules a skill loads to stay aligned
- [Disciplines](/concepts/disciplines/) — always-on behavioral habits
- [Agent Configuration](/agent-configuration/overview/) — full picture of what shapes agent behavior
- [Marketplace](/marketplace/) — the plugins and skills shipped with this repo
- [Claude Code — skills](https://code.claude.com/docs/en/skills) — frontmatter reference, invocation control, `context: fork`
- [Claude Code — subagents](https://code.claude.com/docs/en/sub-agents) — agent-definition frontmatter and `skills:` preloading
