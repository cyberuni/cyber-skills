# i-have-adhd

Reply-shaping rules for a reader with ADHD, scoped to this repository.

## What it is

A project-private copy of the personal `i-have-adhd` skill, narrowed to a single instruction target: the reply the user reads in this session. The rules themselves are unchanged. What is added is an explicit scope, so the skill does not spread into the files the agent writes.

## Why it is scoped

This repository is largely prose: skills, governances, ADRs, and the documentation site. An unscoped reply-shaping skill spreads its voice into those artifacts, producing fragments, bare "Next:" lines, and epigram-style sentences in documents whose readers never saw the session.

The pattern generalizes. A skill binds to an instruction target through three parts:

1. a scope statement placed before any rule, so the rules are never read unscoped
2. positive framing, stating what the rules describe rather than listing where they must not apply — a negative list is unbounded and always has an eighth case, while a positive scope defines its complement by construction
3. per-rule binding on the rules most likely to travel, since a rule such as "lead with the next action" is a self-contained imperative that carries no pointer back to a distant scope header

The `description` field stays out of it. Description drives selection; the body drives behavior.

## Known limit

Scope text competes with accumulated evidence. Over a long session the agent's own shaped replies act as unlabeled style exemplars, and they outnumber the scope statement many times over. Wording alone cannot fully counter that. Re-injecting the boundary at the moment a file is written is a stronger mechanism than stating it once at load time.

## Related

- [Target](../../../apps/website/src/content/docs/agent-configuration/instruction-target.md) — the axis this skill is scoped along
- [Purpose](../../../apps/website/src/content/docs/agent-configuration/instruction-purpose.md) — the axis Target composes with
