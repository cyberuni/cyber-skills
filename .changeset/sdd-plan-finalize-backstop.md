---
"cyber-sdd": minor
---

Add the plan-brief finalize backstop to the SDD conductor: a mission that lands now reconciles its plan brief's `todos` and `## NEXT` anchor to the landed state, in the same change as the work, rather than leaving the drift to a later retro.

The reconcile is a backstop — it runs in one pass over the whole brief even when nothing updated it mid-flight — and it reconciles *to the landed state*, never *marks everything done*: a todo whose work was held out of scope stays un-completed and rides the follow-up machinery. It writes the brief and nothing else, including no terminal value in the plan-level `status` dispatch flag, which stays `active | approved` with terminal-ness derived. A mission that halts is checkpointed at its true in-progress state, not reconciled as landed.
