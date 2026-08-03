---
title: Responsibility
description: The Required / Optional / Delegated axis — what job an agent-configuration artifact must do itself, may optionally take on, or hands to a named role via dependency inversion.
---

**Responsibility** is a different question from [kind](/agent-configuration/skills/overview/#kinds-of-skill). Kind answers *how a skill gets chosen* — Selection, Visibility, Effect. Responsibility answers *what job it is on the hook for* once chosen: what it must implement to be that kind of artifact at all, what it may optionally add on top, and what it explicitly refuses to implement itself — handing that job to whatever role fills a name.

This axis applies to any agent-configuration artifact, not just skills: a persona (subagent or skill), a governance, a discipline, a command are all answering the same three questions about themselves.

## The three relations

| Relation | Meaning | Absence means |
|---|---|---|
| **Required** | Must implement — this is what makes the artifact this kind of thing | It isn't doing its job |
| **Optional** | May implement, as an artifact-specific add-on over the default | Nothing breaks; the default behavior stands |
| **Delegated** | Explicitly not implemented here — resolved by loading a named role | The caller falls back to a bundled default, or does without |

Required and Optional both describe things the artifact does itself. Delegated describes something it deliberately does not — the distinction from Optional is not "how important is this," it's "who does the work."

## Delegation is dependency inversion, realized by name

A **Delegated** responsibility is fulfilled the way [Direct Invocation skills](/agent-configuration/skills/direct-skill/) describe: the artifact tries to load a role by a known name, and falls back to its own bundled default if no override exists — the same resolution order as SDD's conductor trying `architect` before falling back to `sdd:architect`.

This is what lets one artifact's required responsibility stay untouched while its delegated responsibility gets swapped by whoever consumes it. The delegate is usually a new combination on the [Selection / Visibility / Effect axes](/agent-configuration/skills/overview/#kinds-of-skill) — by-name selection, agent-only visibility, and whatever effect the delegated job needs (often **stance**, when the thing being delegated is voice or judgment rather than a task).

## Responsibility across the existing kinds

| Artifact | Required | Optional | Delegated |
|---|---|---|---|
| [Gateway skill](/agent-configuration/skills/gateway-skill/) | Activation, intake against a fixed operation menu, context loading, routing | Continuing to shape the work after routing | Voice and judgment during intake/routing — an optional by-name persona |
| [Persona](/agent-configuration/skills/persona/) (subagent or skill) | Identity layer (role, expertise, voice) and capability layer (tools, constraints) | Additional constraints beyond a plugin's defaults | — (a persona is typically the delegate, not the delegator) |
| [Command](/agent-configuration/skills/commands/) | Explicit-only invocation, auto-match suppressed | — | — |
| [Governance](/agent-configuration/skills/governances/) | Self-contained rules for a domain | — | — |
| [Discipline](/agent-configuration/skills/disciplines/) | Always-on habit, triggered by event | — | — |
| Public skill (default) | Matching a situation, performing the action | — | — |

Most rows have no Delegated column: delegation is the exception, not the default. It shows up where an artifact's job genuinely splits into "the mechanism" (required, fixed, plugin-owned) and "the manner" (an overlay the consumer should be free to swap).

## Worked example: a gateway delegates its voice to a persona

A [Gateway skill](/agent-configuration/skills/gateway-skill/) owns a closed operation menu — for SDD, that's create / backfill / validate / implement / manage. That vocabulary is plugin IP: a consumer changing it has forked the workflow, not customized it. So it is **Required**.

Whether the gateway keeps shaping the work after it routes is **Optional** — allowed, not mandatory, and doesn't change what kind of artifact the gateway is.

How the gateway sounds while doing intake — cautious or terse, how it handles ambiguity, what it apologizes for — has nothing to do with the operation menu. That's **Delegated**: the gateway tries to load a persona by a conventional name, falls back to its own bundled default voice if the consumer hasn't supplied one. The consumer overrides the voice without touching the menu; the plugin ships a default voice without locking the consumer into it.

## Related

- [Skills](/agent-configuration/skills/overview/) — the Selection / Visibility / Effect axes this one complements
- [Direct Invocation Skill](/agent-configuration/skills/direct-skill/) — the by-name resolution mechanism that realizes delegation
- [Gateway Skill](/agent-configuration/skills/gateway-skill/) — the running example above
- [Persona](/agent-configuration/skills/persona/) — the usual shape of a delegated responsibility
