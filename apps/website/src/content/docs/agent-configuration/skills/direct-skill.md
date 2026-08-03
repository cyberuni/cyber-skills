---
title: Direct Invocation Skill
description: A skill selected by another skill naming it outright, never by matching a user's situation — the minimal-description rule that enforces it, and why it is not "internal."
---

A **Direct Invocation skill** (or **Direct skill** in short) can be invoked by name only. It should never be triggered through context.

It is useful for a capability that should run only when a specific caller asks for it by name — a rubric a judge loads to grade, a role a conductor fills without committing to which plugin supplies it, a fragment factored out of a longer procedure. None of these should self-activate just because their subject matter comes up in conversation.

Currently, there is no official way to support this kind of skill by major harnesses. Claude Code has a `disable-model-invocation: true` that suppresses automatic loading outright — but a skill with that flag [cannot be preloaded into a subagent](https://code.claude.com/docs/en/sub-agents#preload-skills-into-subagents), because preloading draws from the same pool the model may invoke. A skill built with that flag, if a subagent needs it preloaded at startup, would be silently skipped.

So the workaround way is to specify `description` in the frontmatter to a fixed, minimal marker string that gives the model nothing to match against. It works on every harness, and it keeps the skill preloadable. Note that it must not be blank or omitted either — Claude Code's own docs say a missing `description` falls back to reading the skill body's first paragraph as the trigger, which is the opposite of unmatchable.

But due to this workaround, a **Direct skill** is currently not suitable to be used as slash command because user would not tell what the skill does in the menu as the `description` contains only the minimal marker. That's why typically you will see a **Direct skill** often comes with `user-invocable: false`.

This makes a **Direct skill** almost a polar opposite to a [Command](../commands):

| Kind                    | Selection                       | Visibility |
| ----------------------- | ------------------------------- | ---------- |
| [Command](../commands/) | explicit (user types `/<name>`) | user       |
| **Direct skill**        | **direct (a caller names it)**  | agent-only |

## Significance — dependency inversion

Architecturally, this kind of skill exists to enable **dependency inversion**: a caller can name a
role it depends on without committing to which plugin supplies it. That one property drives several
concrete use cases:

- A plugin ecosystem overrides a default implementation by name, without the caller's code changing.
- A judge loads a reference rubric blind, so grading criteria stay identical across every run.
- A producer factors shared criteria out into a fragment every judge in a pipeline loads the same way.

None of that works if the skill can also fire on its own — an overriding skill and the default it
replaces would both be candidates for auto-match, and the caller loses control over which one runs.
Direct Invocation is the constraint that makes override-by-name safe: the model is never in the loop
deciding — only the explicit name is.

This is also why the kind is not "internal": "Direct Invocation" describes _how the skill is chosen_,
not _who is allowed to choose it_. Any skill, agent, or workflow can load one, as long as it knows the
name — there is no ownership fence around it. The closest analogy is a C/C++ `friend` function or a
namespace-level function: it can be defined _inside_ the library it's most associated with, or
_outside_ it as an unrelated caller's own file — either placement is addressable by name the same way,
and neither one makes the function belong to whoever happens to call it. "Internal" would claim
ownership by a single caller; Direct Invocation only claims a selection mechanism.

For example, SDD's conductor wants an `architect` role. It can:

1. Try to load a skill literally named `architect` — a project or plugin may have defined one to
   override the default.
2. Fall back to `sdd:architect` — SDD's own bundled default — if no override exists.

Neither skill is "private" to the caller. `architect` might be authored by a completely unrelated
plugin, discovered purely because the conductor asked for that name. Ownership and callability are
different questions from selection — a Direct Invocation skill answers only the second.

## The rule

> **A Direct Invocation skill's description is kept to the minimum.**

The `description` field is the only thing a model matches against. A description with nothing
matchable in it is a skill that cannot be selected by accident, on any harness. Minimum means a fixed
marker string, never blank or omitted — on Claude Code, a missing `description` falls back to reading
the skill body's first paragraph as the trigger, which defeats the whole point:

```yaml
---
name: resolve-governances
description: "Direct invocation only"
---
```

All Direct Invocation skills share this same description; they're distinguished by `name`, which is
how callers address them. Identity moves to the body and README — what the skill is, who calls it,
what it returns, is documentation a caller reads after loading it by name, not selection criteria a
model reads before. `user-invocable: false` alone does not enforce unmatchability — see
[Selection and Visibility are not the same question](/agent-configuration/skills/overview/#selection-and-visibility-are-not-the-same-question).

## Relation to Governance

A Direct Invocation skill whose **effect** is _reference_ rather than _action_ is read as criteria
instead of executed as steps — a producer loads it to align, a judge loads it to grade. That
combination (direct selection, `user-invocable: false`, reference effect) is what
[Governances](/agent-configuration/skills/governances/) are built from.

## Related

- [Skills](/agent-configuration/skills/overview/) — the overview this page specializes; Selection, Visibility, and Effect axes
- [Governances](/agent-configuration/skills/governances/) — the reference-effect realization of a Direct Invocation skill
- [Commands](/agent-configuration/skills/commands/) — the user-visible, explicit-selection counterpart
