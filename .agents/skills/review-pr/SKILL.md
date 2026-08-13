---
name: review-pr
description: "Use this skill when reviewing a pull request in this repo for design soundness rather than line-level correctness — 'review PR #N', 'is this the right approach', 'should this live here'. Runs an Oracle lens (are the claims true?) and an Architect lens (is it at the right layer, and did it go through the gate?)."
metadata:
  internal: true
---

# review-pr

A **design review**, not a code review. `/code-review` and `simplify` already cover standards
conformance and line-level defects. This skill answers three different questions:

1. **What is it actually trying to solve?** — recovered from evidence, not from the PR body.
2. **Does this approach solve that?** — the Oracle lens.
3. **Does it belong here, at this layer?** — the Architect lens.

The output is a merge/split/reject recommendation with the load-bearing findings ordered by weight.

## Scope

Use this for PRs that add a component, change a contract, or wire a new obligation into existing
callers. Skip it for dependency bumps, typo fixes, and mechanical refactors — there is no design
question to answer.

This skill does **not** hunt for bugs, style violations, or missing tests. Bugs surface only when
they are evidence for a design finding (a guard that cannot fire, a comment the code contradicts).

## Method

Work the steps in order. Each one is cheap; the ordering matters because later steps are only
meaningful once you know what the PR claims.

### 1. Separate intent from blast radius

```bash
gh pr view <N> --json number,title,body,baseRefName,headRefName,additions,deletions,changedFiles,url
gh pr diff <N> --name-only
gh pr diff <N> > "$SCRATCHPAD/pr<N>.diff"
```

Read the body as a **hypothesis about the PR**, never as a finding. It is the author's account of
their own work and it is the thing you are auditing.

### 2. Fetch the base — do not rebase

```bash
git fetch origin
git rev-list --count <headRef>..origin/<baseRef>            # how far behind
git diff --name-only <headRef> origin/<baseRef> -- <the paths this PR touches>
```

**Never rebase or force-push the branch you are reviewing.** A review is read-only. Rebasing writes
to the author's branch, can conflict mid-review, and changes nothing you are reviewing anyway —
`gh pr diff` is already merge-base-scoped, so the PR's own diff is byte-identical before and after.

Fetching still matters, for one specific reason: the **Architect lens reads its baseline from the
working tree**, which is the corpus as of the *branch point*. If a spec node, a placement-map entry,
or a frozen scenario landed on the base branch after the branch was cut, you will report "no spec
node exists" when one now does. So when the branch is behind, read Architect-lens references from
the base ref rather than from disk:

```bash
git show origin/<baseRef>:.agents/specs/<project>/spec.md
git show origin/<baseRef>:<node>/<node>.feature
git ls-tree origin/<baseRef> .agents/plans/
```

Being behind is not itself a finding — branches are behind constantly. It becomes one only when the
base branch moved **in the paths this PR touches**, which is what the `git diff --name-only` above
tells you. If that returns empty, say so and read from disk.

### 3. Read the new artifact whole, before the hunks

For anything the PR adds, read the complete file — the SKILL.md, the README, the engine source.
A diff hunk shows you what changed; it does not show you what the thing *is*. You cannot judge an
approach from a hunk.

### 4. Read the wiring hunks separately

Find every hunk that changes an **existing** caller. These are the obligations the PR imposes on the
rest of the system, and they are where scope creep and spec drift live. Ask of each: what is a caller
now required to do that it wasn't before, and is that requirement specified anywhere?

### 5. Oracle lens — verify every load-bearing claim against a primary source

For each factual claim the PR makes about the system, find the source and check it. In particular:

- **Does the field exist?** `grep` the whole repo for every key the new code reads. A field that
  appears only in the PR's own code and tests is a **dead path**: no producer emits it, so the code
  reading it can never fire. Speculative "forward-compatible" fields are the common form of this.
- **Is the measured property the actual property?** A proxy is not the thing. `mtime` is not
  "content changed" (`git checkout` rewrites it — verify with `stat` vs `git log -1 --format=%ci`).
  A regex over prose is not a structured signal. Name the proxy and the case where it diverges.
- **Can the check be wrong in both directions?** Find a concrete false positive and a concrete false
  negative. If you cannot construct either, the check is probably unfalsifiable — say so.
- **Do the comments match the code?** A comment claiming a verification the code skips is a real
  defect and usually points at a path the author intended but didn't take.
- **Do the tests test reachable paths?** Green tests over dead fields measure nothing.

Every claim you make in the review needs the command that established it. A source-read is a
hypothesis until you have run something against it.

### 6. Architect lens — layer, placement, and gate

This repo is SDD-governed. Run all five checks:

- **Is there a spec node?** Find the owning project spec (`.agents/specs/<project>/spec.md`). Read
  its **Placement map** — it states where a new concept of this kind goes. A new behavioral unit
  with no `<node>/`, no `eval.md`, and no `.feature` has bypassed the spec gate.
- **Is there a CR?** `ls .agents/plans/` and `git log --oneline main..HEAD`. A single commit with no
  plan brief means no change request was opened.
- **Does it drift a frozen suite?** For every touched node, read its `.feature`. If the PR changes
  behavior the suite freezes — or adds behavior the suite has no scenario for — that is spec drift,
  even when the tests are green.
- **Is the fix at the layer where the defect originates?** This is the highest-value question in the
  review. A reader-side guard that compensates for a producer that writes no provenance is
  misplaced: fix the producer and the guard becomes trivial or unnecessary. Trace each guess or
  heuristic in the new code back to the missing upstream contract that forced it. **Count the
  guesses** — a component that guesses three or four different things in sequence is nearly always
  sitting at the wrong layer.
- **Is it one thing?** Name each distinct problem the PR addresses. Two problems fused into one
  component usually means at least one of them is in the wrong place, and it is the reason a PR
  resists a clean verdict.

### 7. Answer "this project or another?" on two axes

Placement and layer are independent. Report them separately, because "right repo" is often true
while "right node" is false:

- **Repo / package** — does this belong to this codebase's product at all?
- **Node / layer** — within the right package, is it in the capability folder its own spec's
  placement map names, and at the layer that owns the defect?

### 8. Recommend

State a verdict — merge, merge-with-fixes, split, or reject — and when splitting, give the ordered
pieces with what each unblocks. Separate **fix regardless of scope decision** (comment/code
mismatches, missing invocation docs) from **fix only if the approach stands**.

## Report shape

```
## Review: PR #<N> — <title>

### Steps I took            ← the commands, so the review is reproducible
### What it tries to solve  ← recovered problems, named and separated
### Does it solve them?     ← Oracle findings, ordered by weight, each with its evidence
### Should it be here?      ← Architect findings across both axes
### Recommendation          ← verdict + ordered split, if any
```

Order findings by **weight**, not by file order or discovery order. The finding that changes the
verdict goes first; code-level defects go last, under a "Minor" heading.

## Boundaries

- Do not fix anything. This skill produces a review; edits are a separate, approved step.
- Do not soften a finding because the PR is well-written. Thorough comments admitting a guess is a
  guess are honest, but several honest guesses stacked in sequence still don't make a sound design —
  say that plainly.
- Do not report a design finding you have not run a command to support.
