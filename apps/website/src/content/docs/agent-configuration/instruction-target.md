---
title: Target
description: Which of the agent's outputs an instruction governs — a produced artifact, this session's conversation, or another agent's context — and why separating them lets contradictory instructions coexist.
---

**Target** identifies which of the agent's outputs an instruction governs, and therefore who eventually reads it. You may want the agent to reply to you in a caveman register while it writes your documentation in plain, careful English.

A single request routinely involves more than one target, each with its own value. The agent may reply tersely to the user while briefing a subagent with full context, or draft a formal document while sending a short status message to a peer agent.

Separating the targets is what lets those values contradict each other safely. Caveman and careful English cannot both be one house style; as values on two targets, they coexist.

The target is also the boundary. Two instructions governing different outputs never meet, so their contradiction costs nothing. Two governing the same output are in genuine conflict, and naming the target does not resolve it.

## Specifying a target

Three mechanisms carry the target, and they act at different moments:

| Mechanism                | Where the target lives      | Decided by                | What it settles       |
| ------------------------ | --------------------------- | ------------------------- | --------------------- |
| **File type matching**   | a path glob in frontmatter  | the harness, mechanically | whether the file loads |
| **Description matching** | the `description` field     | the agent, at load time   | whether the file loads |
| **Prose matching**       | the instruction body        | the agent, while working  | which value applies    |

File type matching is deterministic. The harness evaluates a path glob rather than the agent judging a situation, so the instruction loads with the content it governs and the same file always draws the same rules.

- **Cursor** — a rule in `.cursor/rules/` carries a `globs:` field in its frontmatter, set with `alwaysApply: false`, so it activates only when matching files enter context.
- **GitHub Copilot** — a file in `.github/instructions/` carries an `applyTo:` glob.

What a path cannot express is a file that mixes targets. A markdown file holds prose under one set of conventions and code blocks in several languages, each under its own, and one section of prose may answer to a different standard than the next. The glob binds at file granularity while the targets vary inside the file.

Description matching reaches what a path cannot. An agent configuration file — a `SKILL.md`, a subagent definition, a Cursor rule — carries a `description` in its frontmatter, and the agent judges from it whether the current situation calls for loading that file. It is a semantic judgment rather than a rule the tool evaluates, and it carries the target alone in three cases:

- where a harness offers no file type matching
- where the kind of content is not evident from a path
- where the output is not a file at all

Both of those gate loading, and neither settles what an instruction covers once it is loaded. Prose matching does: the body names the target, so one loaded file carries a different value per target. The `article-writer-voice` skill states six rules that hold for all prose, then splits — **Personal** for blog posts and newsletter issues, **Docs** for project documentation and READMEs. The file loads once; the agent matches its situation against the branch and takes that value.

Reach for prose matching in two cases. The first is when neither of the others distinguishes the targets — a mixed-target file, where one path and one description govern content answering to several standards. The second is when the variants are too minor to separate: the two registers above share all six rules and diverge only in delivery, so a file per target would duplicate more than it distinguishes.

Write the target into the body; no harness setting enforces it for you.

A target you can name is a target you can write for. Once the boundary is explicit, an instruction can carry rules that hold for one kind of output and reach nothing else — a convention for your Python modules that never touches how the agent talks to you.

Naming has a limit. When one target needs a substantial body of instruction, isolating the work beats scoping it: give it its own subagent or its own session, and its rules arrive with nothing to compete against. Scoping asks the agent to honor a boundary on every turn, while isolation removes the other side of the boundary from context altogether. [Keeping targets apart](#keeping-targets-apart-within-one-session) weighs the two.

## The three targets

There are three kinds of targets, and the forms within each kind are open-ended:

| Target       | Where the output goes                 | Forms it covers                                    | Example                                                                              |
| ------------ | ------------------------------------- | -------------------------------------------------- | ------------------------------------------------------------------------------------ |
| **Artifact** | Into a file that outlives the session | every kind of content the agent can write           | `article-writer-voice` shapes a draft's voice without changing how the agent replies |
| **User**     | Into this session's conversation      | a live reply, and a question carrying its reasoning | `i-have-adhd` shapes how the agent talks without touching anything it produces       |
| **Agent**    | Into another agent's context          | a spawn-time brief, and mail to a peer session      | cyberlegion mail sent to a peer session                                              |

## Artifact: the only target with a path

Here the target is a specific kind of content: a given programming language, tests, Storybook stories, documentation, or agent configuration.

Having a path is what makes file type matching possible, and this is the only target that has one. It is also the only target where a single file can hold several targets at once, which is where prose matching earns its place most often.

## User: the default target

Everything the agent says lands here unless it is writing a file or briefing another agent. That makes this the target always in force, and the one whose examples pile up fastest — the drift described in [Keeping targets apart](#keeping-targets-apart-within-one-session) runs toward it.

No path reaches it. A reply is not a file, so file type matching has nothing to match on, and description matching or prose matching carries the target alone.

Every purpose applies here, not only Tone. Tone comes to mind first — the caveman register above and `i-have-adhd` in the table are both Tone instructions — because the user already holds the session's context, so it looks as though nothing is left to convey and only the manner of conveying it is in play. Shared context is not shared reasoning: "when you need user input, state the reasoning that led to the question" targets the user and is pure Procedure, sparing them from reconstructing the question's origin out of the session history.

The user can also answer back, which no other target can. An instruction here may leave something to a follow-up turn, where a brief has to anticipate it because the subagent has no way to ask.

## Agent: briefs and mail are not interchangeable

A brief and a piece of mail both read like conversation, but they reach agents in different states. Neither is a file, so a description or the instruction body has to carry the target.

- A **brief** gives a subagent everything it needs in order to act without prior context: the task, the reason for it, and what a finished result looks like. You write it once, at spawn time, and the subagent cannot ask you to clarify it.
- **Agent mail** passes between two running sessions that do not share context by default. It carries a decision, a status, or a question, but never the sender's full reasoning trail.

The distinction that matters is the recipient's standing mission. A brief becomes the subagent's mission, because the subagent has none of its own. Mail arrives at an agent that already has a mission, so it competes for attention instead of setting the agenda. Mail must therefore stand on its own and carry enough context for the recipient to act without access to the sender's session.

Every purpose applies within both forms. A brief carries Procedure (what to do) and Reference (context to load), while a piece of mail may be pure Reference (a status update) or a Menu (a decision the recipient must choose from, such as an approve-or-reject verdict at a gate).

## Composing configuration

Separation pays off twice — once when you write configuration, once when you install it.

If you **write** it, the target is the seam to split on. A skill shaping both your replies and your written documents has to be adopted whole: a project that wants its prose conventions inherits its reply style along with them. Split it by target and each half can be adopted on its own.

If you **install** it, the target tells you whether two units can coexist, before you try them:

| The two units govern | Result                           |
| -------------------- | -------------------------------- |
| different targets    | they never meet — enable both    |
| the same target      | a real conflict — one has to win |

The two skills named above sit in the first row. `article-writer-voice` governs Artifact; `i-have-adhd` governs User. Enable both and neither yields — the agent writes your documentation in careful, structured prose while answering you in short, front-loaded replies. Read as one house style they contradict. Read as two targets they are unrelated.

## Keeping targets apart within one session

A single session usually serves more than one target in turn: a reply, then a file, then a brief. Configuration bound to one target tends to carry into the next, and the drift runs in a predictable direction, toward whichever target the agent has been serving most.

The mechanism is accumulation rather than misunderstanding. Every reply the agent writes becomes an example of how it writes, and those examples carry no label recording which target they were for. A scope statement made once, where the instruction is loaded, competes against a growing body of unlabeled demonstrations. The longer the session runs, the weaker its position.

Four arrangements keep the targets apart, in decreasing order of separation and increasing order of convenience.

1. **Produce the artifact in a separate session.** A freshly spawned agent has accumulated nothing, so nothing bleeds. This is the only arrangement that separates by construction rather than by instruction. Its cost is that the new session begins with no context, which makes it a poor fit when the artifact is itself the residue of a long discussion, because the brief would have to reconstruct that discussion.
2. **Restate the target at the moment of production.** Naming the intended register immediately before you write the artifact re-establishes the boundary where it matters, at the cost of having to remember.
3. **Produce the artifact early**, before much output for another target has accumulated. It costs nothing to apply, but it depends on knowing at the outset which artifact the session will produce, which a session that discovers its own scope cannot.
4. **Scope the instruction itself** — prose matching, applied to the drift problem. This is the weakest of the four, because a scope statement is exactly what accumulation erodes, but it is the only one that asks nothing of the author at the time of writing.

A reasonable default is to produce in a separate session when the artifact can be specified in a brief, and to restate the target when it cannot.

## Naming a target does not change the purpose

A Procedure remains a set of ordered steps to execute, whether those steps are meant for the user's own turn, a subagent's brief, or a Python module. Purpose describes the job a value performs, and Target describes who receives it.

## Related

- [Purpose](/agent-configuration/instruction-purpose/) — the axis Target composes with
- [Persona](/concepts/persona/) — where Tone and Structure separate from expertise
- [Agent Configuration](/agent-configuration/overview/) — which file kinds carry these
