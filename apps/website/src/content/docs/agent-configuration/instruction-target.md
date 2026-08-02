---
title: Target
description: Who or what consumes an instruction's output — a produced artifact, the user, or another agent. Every purpose can carry a different value per target.
---

**Target** identifies who or what consumes an instruction's output. You may want the agent to reply to you in a **caveman** tone, but write documentation that is **welcoming** and **inclusive**.

| Target       | Consumer                                         | Example                                                                                  |
| ------------ | ------------------------------------------------ | ---------------------------------------------------------------------------------------- |
| **Artifact** | A third party, through a file the agent produces | `article-writer` shapes a draft's voice without changing how the agent replies            |
| **User**     | The person in this session                       | `i-have-adhd` shapes how the agent talks without touching anything it produces            |
| **Agent**    | Another agent that will act on the output        | a subagent brief, or cyberlegion mail sent to a peer session                              |

Each of the three consumers expects something different. The three kinds are stable, but the forms within each kind are not. The Artifact target covers every kind of content the agent can write. The User target covers both a live reply and a question that must carry its own reasoning. The Agent target covers a spawn-time brief as well as mail sent to a peer session.

A single request routinely involves more than one target, each with its own value. The agent may reply tersely to the user while briefing a subagent with full context, or draft a formal document while sending a short status message to a peer agent.

## Artifact: purpose values vary by kind of content

Naming the target does not finish the job. A Python module, a test file, a Storybook story, and a markdown document each follow their own conventions, so the same purpose takes a different value in each.

| Purpose            | Python module                                | Test file                               | Storybook story                           | Markdown doc                                    |
| ------------------ | -------------------------------------------- | --------------------------------------- | ----------------------------------------- | ----------------------------------------------- |
| **Procedure**      | define types, functions, docstrings          | arrange-act-assert, mock setup          | define args, controls, render function    | front matter, headings, body                    |
| **Criteria**       | lint and type-check pass, docstring coverage | edge cases covered, assertions present  | every state has a story, a11y checks pass | heading hierarchy, no broken links              |
| **Reference**      | PEP 8, stdlib idioms                         | this repo's test-runner conventions     | design-system component API               | this repo's doc voice and structure conventions |
| **Policy**         | no bare `print` in production code           | no snapshot tests without a description | no hard-coded prod URLs in args           | no bare URLs, no rationale prose                |
| **Tone/Structure** | docstring register, import ordering          | comment style, describe/it nesting      | control naming, story ordering            | prose register, section ordering                |

These four columns are an illustration rather than an inventory. Any kind of content that has conventions of its own will fill the same rows differently. Target alone does not fix a value: it identifies who receives the output, and the conventions of that content determine the rest.

## User: more than tone

Because the user shares the whole session's context, it is tempting to treat this target as a matter of voice alone. Shared context, however, is not shared reasoning. An instruction such as "when you need user input, state the reasoning that led to the question" targets the user and is pure Procedure, because it spares the user from reconstructing the question's origin out of the session history.

## Agent: briefs and mail are not interchangeable

A brief and a piece of mail both read like conversation, but they reach agents in different states.

- A **brief** gives a subagent everything it needs in order to act without prior context: the task, the reason for it, and what a finished result looks like. It is written once, at spawn time, and the subagent cannot ask the briefer to clarify it.
- **Agent mail** passes between two running sessions that do not share context by default. It carries a decision, a status, or a question, but never the sender's full reasoning trail.

The distinction that matters is the recipient's standing mission. A brief becomes the subagent's mission, because the subagent has none of its own. Mail arrives at an agent that already has a mission, so it competes for attention instead of setting the agenda. Mail must therefore stand on its own and carry enough context for the recipient to act without access to the sender's session.

Every purpose applies within both forms. A brief carries Procedure (what to do) and Reference (context to load), while a piece of mail may be pure Reference (a status update) or a Menu (a decision the recipient must choose from, such as an approve-or-reject verdict at a gate).

## Naming a target does not change the purpose

A Procedure remains a set of ordered steps to execute, whether those steps are meant for the user's own turn, a subagent's brief, or a Python module. Purpose describes the job a value performs, and Target describes who receives it.

## Related

- [Purpose](/agent-configuration/instruction-purpose/) — the axis Target composes with
- [Persona](/concepts/persona/) — where Tone and Structure separate from expertise
- [Agent Configuration](/agent-configuration/overview/) — which file kinds carry these
