---
title: Target
description: Where an instruction's output goes — into a produced artifact, this session's conversation, or another agent's context. Every purpose can carry a different value per target.
---

**Target** identifies where an instruction's output goes, and therefore who eventually reads it. You may want the agent to reply to you in a caveman register while it writes your documentation in plain, careful English.

There are three kinds of targets, and the forms within each kind are open-ended:

| Target       | Where the output goes                 | Forms it covers                                    | Example                                                                              |
| ------------ | ------------------------------------- | -------------------------------------------------- | ------------------------------------------------------------------------------------ |
| **Artifact** | Into a file that outlives the session | every kind of content the agent can write           | `article-writer-voice` shapes a draft's voice without changing how the agent replies |
| **User**     | Into this session's conversation      | a live reply, and a question carrying its reasoning | `i-have-adhd` shapes how the agent talks without touching anything it produces       |
| **Agent**    | Into another agent's context          | a spawn-time brief, and mail to a peer session      | cyberlegion mail sent to a peer session                                              |

A single request routinely involves more than one target, each with its own value. The agent may reply tersely to the user while briefing a subagent with full context, or draft a formal document while sending a short status message to a peer agent.

## Artifact: purpose values vary by kind of content

Here the target is a specific kind of artifact: a given programming language, tests, Storybook stories, documentation, or agent configuration.

Some harnesses infer the target from the file being worked on — **file type matching**. Conventions load only with the content they govern, and the harness applies the match rather than relying on the agent to notice.

- **Cursor** — a rule in `.cursor/rules/` carries a `globs:` field in its frontmatter, set with `alwaysApply: false`, so it activates only when matching files enter context.
- **GitHub Copilot** — a file in `.github/instructions/` carries an `applyTo:` glob.

File type matching is a shortcut. It indicates roughly what a file holds: a markdown file contains code blocks in several languages, each carrying its own conventions, and one section of prose may answer to a different standard than the next. Content decides the value, and file type is a proxy close enough to be useful.

The other mechanism is **description matching**. An instruction file carries a description, and the agent judges from it whether the current situation calls for loading that file. It is a semantic judgment rather than a rule the tool evaluates, and it carries the work alone in three cases:

- where a harness offers no file type matching
- where the kind of artifact is not evident from a path
- where the target is the user or another agent, which correspond to no file at all

Both mechanisms infer the target rather than declaring it. A glob on `**/*.py` bets that the session is producing Python; a description matches when the situation sounds like the one the instruction was written for. The bet is on presence, not production — a Python file in context may mean the agent is writing it, explaining it, or reading it to answer a question about something else.

The instruction body closes that gap. A rule selected by a glob still has to say it governs the Python you write rather than the replies you write about Python, and a skill selected by its description carries no scope from having been selected. The inference runs one way: a target narrows when an instruction should load, but loading never establishes what the instruction covers. Write that into the body; no harness setting enforces it for you.

Naming the target does not finish the job either. A Python module, a test file, a Storybook story, and a markdown document each follow their own conventions, so the same purpose takes a different value in each.

| Purpose            | Python module                                | Test file                               | Storybook story                           | Markdown doc                                    |
| ------------------ | -------------------------------------------- | --------------------------------------- | ----------------------------------------- | ----------------------------------------------- |
| **Procedure**      | define types, functions, docstrings          | arrange-act-assert, mock setup          | define args, controls, render function    | front matter, headings, body                    |
| **Criteria**       | lint and type-check pass, docstring coverage | edge cases covered, assertions present  | every state has a story, a11y checks pass | heading hierarchy, no broken links              |
| **Reference**      | PEP 8, stdlib idioms                         | this repo's test-runner conventions     | design-system component API               | this repo's doc voice conventions               |
| **Policy**         | no bare `print` in production code           | no snapshot tests without a description | no hard-coded prod URLs in args           | no bare URLs, no rationale prose                |
| **Tone/Structure** | docstring register, import ordering          | comment style, describe/it nesting      | control naming, story ordering            | prose register, section ordering                |

These four columns are an illustration rather than an inventory. Any kind of content that has conventions of its own will fill the same rows differently. Target alone does not fix a value: it identifies where the output goes, and the conventions of that content determine the rest.

## User: more than tone

The user shares the whole session's context, which makes this target look like a matter of tone alone. Shared context is not shared reasoning. An instruction such as "when you need user input, state the reasoning that led to the question" targets the user and is pure Procedure, because it spares the user from reconstructing the question's origin out of the session history.

## Agent: briefs and mail are not interchangeable

A brief and a piece of mail both read like conversation, but they reach agents in different states.

- A **brief** gives a subagent everything it needs in order to act without prior context: the task, the reason for it, and what a finished result looks like. You write it once, at spawn time, and the subagent cannot ask you to clarify it.
- **Agent mail** passes between two running sessions that do not share context by default. It carries a decision, a status, or a question, but never the sender's full reasoning trail.

The distinction that matters is the recipient's standing mission. A brief becomes the subagent's mission, because the subagent has none of its own. Mail arrives at an agent that already has a mission, so it competes for attention instead of setting the agenda. Mail must therefore stand on its own and carry enough context for the recipient to act without access to the sender's session.

Every purpose applies within both forms. A brief carries Procedure (what to do) and Reference (context to load), while a piece of mail may be pure Reference (a status update) or a Menu (a decision the recipient must choose from, such as an approve-or-reject verdict at a gate).

## Keeping targets apart within one session

A single session usually serves more than one target in turn: a reply, then a file, then a brief. Configuration bound to one target tends to carry into the next, and the drift runs in a predictable direction, toward whichever target the agent has been serving most.

The mechanism is accumulation rather than misunderstanding. Every reply the agent writes becomes an example of how it writes, and those examples carry no label recording which target they were for. A scope statement made once, where the instruction is loaded, competes against a growing body of unlabeled demonstrations. The longer the session runs, the weaker its position.

Four arrangements keep the targets apart, in decreasing order of separation and increasing order of convenience.

1. **Produce the artifact in a separate session.** A freshly spawned agent has accumulated nothing, so nothing bleeds. This is the only arrangement that separates by construction rather than by instruction. Its cost is that the new session begins with no context, which makes it a poor fit when the artifact is itself the residue of a long discussion, because the brief would have to reconstruct that discussion.
2. **Restate the target at the moment of production.** Naming the intended register immediately before you write the artifact re-establishes the boundary where it matters, at the cost of having to remember.
3. **Produce the artifact early**, before much output for another target has accumulated. It costs nothing to apply, but it depends on knowing at the outset which artifact the session will produce, which a session that discovers its own scope cannot.
4. **Scope the instruction itself**, so its rules state which target they describe. This is the weakest of the four, because it is the statement that accumulation erodes, but it is the only one that asks nothing of the author at the time of writing.

A reasonable default is to produce in a separate session when the artifact can be specified in a brief, and to restate the target when it cannot.

## Naming a target does not change the purpose

A Procedure remains a set of ordered steps to execute, whether those steps are meant for the user's own turn, a subagent's brief, or a Python module. Purpose describes the job a value performs, and Target describes who receives it.

## Related

- [Purpose](/agent-configuration/instruction-purpose/) — the axis Target composes with
- [Persona](/concepts/persona/) — where Tone and Structure separate from expertise
- [Agent Configuration](/agent-configuration/overview/) — which file kinds carry these
