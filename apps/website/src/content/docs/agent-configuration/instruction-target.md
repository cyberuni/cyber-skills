---
title: Target
description: Which of the agent's outputs an instruction governs — a produced artifact, this session's conversation, or another agent's context — and why separating them lets contradictory instructions coexist.
---

**Target** identifies which of the agent's outputs an instruction governs, and therefore who eventually reads it. A single request routinely involves more than one, each with its own value: the agent may reply to you in a caveman register while writing your documentation in plain, carefully written English, or draft a formal document while sending a peer agent a one-line status.

Separating the targets is what lets those instructions contradict each other safely. A caveman register and careful prose cannot both be one house style; assigned to two targets, they coexist. Two instructions on the same target genuinely conflict — there is no second target to separate them onto, so one of them has to win.

## Specifying a target

Three mechanisms carry the target, and they act at different moments:

| Mechanism                | Where the target lives     | Decided by                | What it settles        |
| ------------------------ | -------------------------- | ------------------------- | ---------------------- |
| **File type matching**   | a path glob in frontmatter | the harness, mechanically | whether the file loads |
| **Description matching** | the `description` field    | the agent, at load time   | whether the file loads |
| **Prose matching**       | the instruction body       | the agent, while working  | which value applies    |

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

| Target       | Where the output goes                 | Forms it covers                                     | Example                                                                              |
| ------------ | ------------------------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------------ |
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

This pays off twice: once when you write configuration, and again when you install someone else's.

When you write it, cut along the target. A skill that shapes both your replies and your written documents can only be adopted whole, so a project that wants its prose conventions gets its reply style too, whether it wanted that or not. Split the skill at the target and each half becomes something a project can take on its own.

When you install it, the target tells you in advance whether two units will fight. Compare what each one governs:

| The two units govern | Result                           |
| -------------------- | -------------------------------- |
| different targets    | they never meet — enable both    |
| the same target      | a real conflict — one has to win |

`article-writer-voice` and `i-have-adhd` are that first row: one governs Artifact, the other User. Enable both and neither has to give way, because they never touch the same output — your documentation comes out in careful, structured prose while your replies stay short and front-loaded.

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
