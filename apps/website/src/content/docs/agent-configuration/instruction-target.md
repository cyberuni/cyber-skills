---
title: Target
description: Who or what consumes an instruction's output — the user, a subagent, a peer agent, or a produced artifact. Every purpose can carry a different value per target.
---

**Target** answers who or what consumes an instruction's output. You may want the agent to reply to you in a **caveman** tone, but write documentation that is **welcoming** and **inclusive**.

| Target         | Consumer                           | Example                                                                                                    |
| -------------- | ---------------------------------- | ---------------------------------------------------------------------------------------------------------- |
| **Reply**      | The user, this session             | `i-have-adhd` — shapes how the agent talks, touches nothing it produces                                    |
| **Brief**      | A subagent, at spawn time          | the delegation message a parent hands a subagent: context, why, what done looks like                       |
| **Agent Mail** | A peer agent, asynchronously       | cyberlegion's inter-agent mail — what has to cross the boundary vs. what stays in the sender's own session |
| **Artifact**   | A third party, via a produced file | `article-writer` — shapes a draft's voice, never touches how the agent replies while drafting it           |

These four are the targets that come up most often, not a closed set. Target is an axis to identify in a given setup, not a list to work through — anything that consumes an agent's output can be one.

A single request routinely needs more than one target at once, each with its own value: reply tersely to the user while briefing a subagent with full context, or draft a formal document while sending a terse status mail to a peer agent.

## The same purpose lands differently per kind of content

Naming the target doesn't finish the job. A Python module, a test file, a Storybook story, and a markdown doc each follow their own conventions, so the _same_ purpose takes a different value in each:

| Purpose            | Python module                                | Test file                               | Storybook story                           | Markdown doc                                    |
| ------------------ | -------------------------------------------- | --------------------------------------- | ----------------------------------------- | ----------------------------------------------- |
| **Procedure**      | define types, functions, docstrings          | arrange-act-assert, mock setup          | define args, controls, render function    | front matter, headings, body                    |
| **Criteria**       | lint and type-check pass, docstring coverage | edge cases covered, assertions present  | every state has a story, a11y checks pass | heading hierarchy, no broken links              |
| **Reference**      | PEP 8, stdlib idioms                         | this repo's test-runner conventions     | design-system component API               | this repo's doc voice and structure conventions |
| **Policy**         | no bare `print` in production code           | no snapshot tests without a description | no hard-coded prod URLs in args           | no bare URLs, no rationale prose                |
| **Tone/Structure** | docstring register, import ordering          | comment style, describe/it nesting      | control naming, story ordering            | prose register, section ordering                |

These four columns are an illustration, not an inventory — any kind of content with conventions of its own fills the same rows differently. The point is that Target alone doesn't fix a value; it says who receives the output, and the content's own conventions do the rest.

## Brief and Agent Mail aren't Reply, even though both look like talking

A Brief and a piece of Agent Mail both read like conversation, the same way a Reply does — but the consumer is different, and so is what belongs in each:

- **Reply** is live back-and-forth with the user, who already shares the whole session's context — though shared context is not shared reasoning. "When you need user input, state the reasoning that led to the question" targets Reply: it saves the user from reconstructing the question's origin out of session history.
- **Brief** hands a subagent everything it needs to act with no prior context — the task, the why, what done looks like — written once, at spawn time; the subagent can't ask the briefer to clarify mid-brief.
- **Agent Mail** crosses between two already-running sessions that don't share context by default: a decision, a status, a question — never the sender's full reasoning trail.

Agent Mail also arrives at an agent that already has a mission of its own, so it competes for attention rather than setting the agenda. What crosses has to stand on its own — a request, a report, or a question carrying enough for the recipient to act on it without the sender's session.

Every purpose still applies within each: a Brief carries Procedure (what to do) and Reference (context to load); a piece of Agent Mail might be pure Reference (a status update) or Menu (a decision the recipient must pick from, like an approve/reject gate verdict).

## Naming a target doesn't change the purpose

A Procedure is still "ordered steps to execute" whether the steps are for the user's own turn, a subagent's brief, or a Python module. Purpose says what job a value is doing; Target says who receives it.

## Related

- [Purpose](/agent-configuration/instruction-purpose/) — the axis Target composes with
- [Persona](/concepts/persona/) — where Tone and Structure separate from expertise
- [Agent Configuration](/agent-configuration/overview/) — which file kinds carry these
