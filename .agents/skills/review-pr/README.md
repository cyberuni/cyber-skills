# review-pr

Repo-internal contributor skill. Reviews a pull request for **design soundness** — is the approach
right, and does it belong at this layer — rather than for line-level correctness.

It runs two lenses:

- **Oracle** — every load-bearing claim in the PR is checked against a primary source. Does the
  field the new code reads actually exist anywhere? Is the measured property the real property, or a
  proxy that diverges? Can the check be wrong in both directions?
- **Architect** — spec node, change request, frozen-suite drift, and the layer question: does the fix
  sit where the defect originates, or is it compensating downstream for a missing upstream contract?

## When to use it

Reviewing a PR that adds a component, changes a contract, or imposes a new obligation on existing
callers — "review PR #467", "is this the right approach", "should this live in this project".

Not for dependency bumps, typo fixes, or mechanical refactors. For standards conformance and bug
hunting use `/code-review`; for quality cleanups use `simplify`.

## Relationship to SDD

The Architect lens is SDD-aware: it reads the owning project spec's placement map, looks for the
`<node>/` + `eval.md` + `.feature` triple, checks `.agents/plans/` for a change request, and compares
touched behavior against the `@frozen` suites. Findings are reported, never fixed.

Because that baseline is read from the working tree — the corpus as of the branch point — the skill
fetches the base ref and reads spec material from `origin/<base>` when the branch is behind in the
paths the PR touches. It never rebases the branch under review: a review is read-only, and
`gh pr diff` is merge-base-scoped already, so a rebase would change nothing being reviewed.
