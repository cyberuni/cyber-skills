---
name: check-result-freshness
description: "Partial Skill: invoke by name only — the ACED result-trust guard — checks whether a target's latest recorded result is still safe to present as current and passing. Loaded by run and improve, not user-triggered."
user-invocable: false
metadata:
  internal: true
---

# check-result-freshness

The **result-trust guard** — the deterministic engine that decides whether the latest ACED result
recorded for a target is still safe to present as current and passing. A green result is easy to
over-claim in two ways this engine exists to catch:

- **STALE** — the subject (the target agent configuration, its `assets/`/`references/` files, and
  the node's frozen `.feature`) was edited after the result ran. The result now describes a subject
  that no longer exists.
- **untrusted passes / suite defects** — a pass that rests on an assertion the judge could not
  actually settle (nothing in ACED's result schema flags this today, so the engine falls back to
  scanning each passing scenario's own explanation for hedging language), or a recorded suite defect
  that needs the `.feature` fixed rather than the subject.

It is **read-only** — it never writes a result, an eval.md, or any other file.

## What it does

Given a spec node directory (the one holding `eval.md` and the frozen `<node>.feature`):

1. Reads `eval.md`'s `subject:` frontmatter to resolve the target agent configuration.
2. Resolves the subject's dependent files: the subject itself, every file under sibling `assets/`
   and `references/` directories, any `assets/...`/`references/...` path the subject's own text
   references elsewhere, and the node's `.feature`. `scripts/` is deliberately excluded — scripts are
   invoked, not loaded into the agent's context, so this engine does not claim to cover them.
3. Locates the latest result for the target under `.agents/aced/results/` — first by a best-effort
   slug of the subject path, falling back to scanning every result's own recorded `target` field when
   the guessed directory does not exist (the guess is never trusted blindly).
4. Reports **STALE** when any subject file's mtime is newer than the result's timestamp, naming the
   offending files. Reports **FAIL** for a recorded failing scenario or `implementation_pass: false`.
   Reports **WARN** for scenarios flagged untrusted/unprovable (structured or heuristic) or recorded
   suite defects.

Exits non-zero whenever the result must not be presented as current or passing (STALE, FAIL, no
result found at all, or the subject/eval.md could not be resolved); exits 0 for a clean result or a
warnings-only result — warnings must still be surfaced by the caller, never summarized away.

## Install

Loaded in-session by `run` (before reporting a result as current) and `improve` (before treating an
ACED-tracked target's latest result as a starting point). Not user-invocable.
