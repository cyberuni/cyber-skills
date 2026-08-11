---
"cyber-sdd": minor
---

The `## Use Cases` section now carries actor, goal, and extensions — not just entry points.

A use case was defined as an **entry point**: one row per way the capability is invoked, given as
trigger / inputs / outcome and named to its implementation surface. That definition had stood since
the section was introduced. It never drifted; it was narrow from the origin.

The requirements-engineering definition is actor + goal + main success path + **extensions** — the
alternate, error and divergence paths. Extensions is where "what can go wrong for this actor" and
"which of these inputs may be combined" live, and a trigger / inputs / outcome row has nowhere to
put any of it. The practical cost: a spec could satisfy the bar completely and still carry no
analysis of why each element of a designed surface exists, what breaks it, or which combinations
are valid. A judge would then confirm the section existed and each row mapped to a scenario, and
pass it — coverage of what is present cannot detect what should not be present.

What changes for spec authors:

- **Use cases are enumerated by actor, never by entry point.** Walking the interface returns only
  the use cases that interface already implies, and is structurally blind to the one nobody built.
  List the actors first — including whoever is affected by the outcome without invoking it — then
  their goals, then map goals to entry points. Both mismatches are findings: a goal no entry point
  serves, and an entry point no listed goal reaches. The enumeration is checkable in both
  directions. On a backfill, source yields only the *served* use cases by construction, and an
  inferred set is never reported as complete.
- **A use case carries four parts** — actor / goal (one line each, not a persona), the entry point
  (trigger / inputs / outcome, unchanged), and its **extensions**. An extension is *any path from
  the trigger that does not reach the success outcome*, stated with its cause and outcome. The
  recurring kinds (refusal, error, boundary, partial result, contended or absent input) are a
  prompt to search with, **not a closed set**.
- **`extensions: none — <why>` is written explicitly** when a use case has no divergence, so the
  claim is contestable rather than silently absent.
- **Every element of the public surface traces to a use case that needs it** — each flag, option,
  parameter, prop, or event names the use case requiring it and the elements it may not be combined
  with. An element no use case needs is an **orphan**: cut it or name the use case. This is the same
  orphan-detection discipline as `## Scenario map`, one level up.
- **Degenerate surfaces stay cheap.** A capability with one entry point and no optional elements
  records the trace in a line, never a table — the obligation is that nothing on the surface is
  unaccounted for, not that a table exists.

The three spec-gate actor bars each take a duty in their own domain rather than a shared copy:
**Oracle** rules cut-or-justify on unbought surface and treats an actor or goal that restates the
mechanism as an unanswered Why; **Builder** requires a scenario per stated extension and per
forbidden combination, and judges `extensions: none` as a claim; **Architect** requires the
control-flow graph to reach every stated extension, since an extension with no edge is a dangling
branch read from the prose side. **Oracle** additionally grades the actor enumeration both ways.

**The CFG remains the single source scenarios derive from.** Extensions are a *discovery
instrument*, not a parallel specification: a graph drawn from an implementation reproduces what the
code already does and can never say a branch is missing, whereas asking what can go wrong for this
actor finds it. So an extension earns its scenario by being a path in the graph — never by being
drawn from the stated list, which would make the suite 1:1 with that list by construction and
unable to surface a hole. A use case is therefore **not** 1:1 with a scenario.

Existing specs are **not** swept — the restored shape applies to new and revised nodes, so no
in-flight change inherits a bar its node has not adopted. Backfilling the existing corpus one node
at a time is tracked separately.
