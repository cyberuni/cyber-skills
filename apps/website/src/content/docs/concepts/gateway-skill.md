---
title: Gateway Skill
description: What gateway skills are — user-invoked workflow entrypoints that activate and route opt-in agent workflows.
---

**Gateway skills** are user-invoked workflow entrypoints. They activate an opt-in workflow, gather missing intent, load the workflow's rules, and route the request to the right next skill or action.

They are for workflows that should not be always on, but need more than a single narrow command once invoked.

## Responsibilities

A gateway skill's job splits along the [Required / Optional / Delegated](/concepts/responsibility/) axis.

**Required** — the front door of the workflow:

- **Activation** — the user explicitly invokes the workflow, such as `$sdd` or "use SDD for this feature"
- **Intake** — when the request is underspecified, the skill asks what kind of work the user wants to do, against its own fixed operation menu
- **Context loading** — the skill loads the rules, constraints, and terms needed for the workflow
- **Routing** — the skill sends the work to a narrower skill, tool, or implementation path

**Optional** — continuing to shape the current work after routing; still scoped to the requested workflow, not global agent behavior.

**Delegated** — voice and judgment during intake and routing. A gateway does not own its own tone: it tries to load a persona by name and falls back to a bundled default if the consumer hasn't supplied one. That's what lets a consumer change how the gateway sounds without forking its operation menu — see the [worked example](/concepts/responsibility/#worked-example-a-gateway-delegates-its-voice-to-a-persona).

A gateway skill should stay at the user-facing boundary: it does not own the workflow's internal delegate selection, detailed lifecycle transitions, or artifact-specific correctness rules unless those are themselves part of the user-facing intake surface.

## Why not use always-on configuration

Always-on [agent configuration](/concepts/agent-configuration/) is appropriate when a rule should apply to every task in a repo. A gateway skill is appropriate when the workflow is optional.

Spec-Driven Development is a good example: not every edit in a repository needs SDD, but once the user opts in, the SDD workflow beneath the gateway needs the lifecycle, gate, and freeze rules in context.

## Gateway Skill vs Other Concepts

A gateway skill is close kin to a [Command](/concepts/commands/) — both are meant to be reached by the user, not fired on stray context — but they differ on two of the three axes that distinguish any skill (see [Skills](/concepts/skills/#kinds-of-skill)):

| Concept | Selection | Effect |
|---|---|---|
| Gateway skill | situational or explicit — `$sdd` or "use SDD for this feature" name it directly; a description match on an unlabeled request for a governed, spec-first change catches it situationally | routing — hands off to a narrower skill or action |
| Command | explicit only — `/name`, never auto-matched | action — the command itself is the work |
| Skill (default) | situational | action |
| Governance | by-name | reference |
| Discipline | event | stance |

A Command's whole point is that auto-invocation is suppressed — that's what makes it safe for deployments and releases. A gateway skill keeps the situational path open: it can still activate from a description match, because its job is to catch the user before they've named the workflow, not just to wait until they do. What it never does is perform the work itself — it routes, the way a Command acts.

## Example: SDD

`$sdd` is the gateway skill for Spec-Driven Development.

With enough detail, it routes directly:

```text
use SDD to create a spec for auth
```

With no detail, it conducts intake:

```text
$sdd
```

The agent should ask what SDD work the user wants to do: create a new feature, backfill an existing feature, validate a spec, implement an approved spec, or manage existing specs.

## Related

- [Skills](/concepts/skills/) — on-demand workflows; Selection, Visibility, and Effect axes
- [Responsibility](/concepts/responsibility/) — Required / Optional / Delegated, and the gateway-persona seam
- [Commands](/concepts/commands/) — the explicit-only, action-effect counterpart
- [Governances](/concepts/governances/) — domain rules loaded on demand
- [Disciplines](/concepts/disciplines/) — always-on behavioral habits
- [Spec-Driven Development](/concepts/spec-driven-development/) — the workflow `$sdd` activates
