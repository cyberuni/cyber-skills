---
title: Instruction Purpose
description: What a block of instruction is for — procedure, criteria, policy, reference, menu, or voice — and why separating them makes instructions composable.
---

**Instruction purpose** answers what a block of instruction is _for_: steps to execute, conditions to be measured against, rules to conform to, material to consult, options to choose among, or a way to sound.

By identifying them, we can separate them cleanly to create composable and reusable instructions.

| Purpose       | Gives the reader                       | Typical section headings                                    |
| ------------- | -------------------------------------- | ----------------------------------------------------------- |
| **Procedure** | ordered steps to execute               | Steps, Workflow, Usage, Instructions                        |
| **Criteria**  | conditions to be measured against      | The Bar, What It Requires, Verification                     |
| **Policy**    | rules that must / must not be followed | Boundaries, What Not To Do, Anti-patterns, Non-goals        |
| **Reference** | facts about the world being worked in  | Architecture, Key Directories, Tech Stack, Domain, Glossary |
| **Menu**      | a closed option set, and help choosing | Operations, Route The Request First                         |
| **Voice**     | a way of sounding                      | Tone, Output Shape                                          |

## Reference is material, not citations

**Reference** is the ground truth an agent needs to work here at all: what the project contains, how directories are laid out, which stack it runs on, what the domain terms mean. `AGENTS.md`'s Architecture and Key Directories sections are the clearest case — they assert nothing normative, they just tell you where you are.

A list of links is not a purpose of its own. A pointer inherits the purpose of whatever it points at: a link to a governance is delivering policy, a link to a rubric is delivering criteria. Classify the destination, not the hyperlink.

## Criteria and Policy are not the same

Both are normative, and they get conflated constantly.

- A **policy** is something you _comply with_. Violating it means you did the job wrong.
- **Criteria** are something you are _measured against_. Failing them means you scored low.

A judge conforms to a governance (policy) while grading a submission against a rubric (criteria) — both at once, in the same run. If a section tells the reader how to behave, it is a policy. If it tells them how someone else's output will be scored, it is criteria.

## Voice is the swappable one

A section is **Voice** if you could replace it with a different one and change only how the agent sounds — never what it does.

`i-have-adhd` and `caveman` pass this test: swap one for the other and every decision the agent makes is identical, only the delivery changes. That separability is the point — it is what lets voice ship as a standalone, user-chosen set of instructions rather than being welded into the workflow that uses it.

Note that voice sections often _read_ like policy ("cap lists at five items", "no preamble"). Genre is set by what the rules govern, not their grammar. Rules governing manner of interaction are voice; rules governing what counts as correct work are policy.

A persona is usually **not** pure voice. Its Domain, Decisions, and Boundaries sections change what the agent concludes, not just how it sounds — those are reference and policy. Only the tone layer is voice, which is precisely the layer a caller can delegate.

## What about disciplines?

A discipline's content is a **policy**. What makes it a discipline is _when it loads_ — always on, selected by an event — which is a question for the Selection axis, not this one.

Strip the loading behavior from commit discipline and its body reads like any governance: one complete, independently revertable change per commit. Same genre, different scope.

## Related

- [Skills](/concepts/skills/) — the per-artifact Selection / Visibility / Effect axes
- [Governances](/concepts/governances/) — artifacts that are almost entirely Policy
- [Persona](/concepts/persona/) — where Voice separates from expertise
- [Gateway Skill](/concepts/gateway-skill/) — the clearest Menu example
- [Agent Configuration](/concepts/agent-configuration/) — which file kinds carry these
