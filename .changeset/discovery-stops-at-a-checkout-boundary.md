---
"cyber-sdd": patch
---

Spec discovery no longer descends into a nested checkout.

The filesystem walk was guarded by a name blocklist — `node_modules`, `.git`, `dist`, `.turbo`,
`.next`, `coverage`. A name list can say "this is called X"; it cannot say "this is where the tree
stops". A nested git checkout is a full copy of the repository inside the repository, and nothing
stopped the walk from descending into one, so every spec in the corpus was discovered once per
nested checkout.

The guard was also one level off from where it was needed: `.git` was already in the blocklist, so
the walk skipped the **metadata directory** while descending straight into the **checkout that
directory marks**.

Agent harnesses that isolate work in a git worktree check the repo out inside itself, which is how
this surfaced: seven such worktrees turned a 10-spec corpus into 38 discovered spec files. The loud
symptom was `check-project-specs` failing with "`packages/x` is claimed by 8 specs — a project has
exactly one spec", breaking `pnpm verify`. The quiet symptom was worse: `check-suite`,
`concept-index`, `check-scenario-overlap`, `check-spec-structure`, and the formation Warden all
reported green over a corpus nearly 4x duplicated. A guard passing over a corpus nobody has is worse
than one that fails.

Discovery now skips any directory that is itself a checkout — one carrying its own `.git`, whether a
**directory** (a clone) or a **file** holding a `gitdir:` pointer (a worktree or a submodule). Both
forms matter: guarding only on the directory form would miss the worktree case that caused this.

The rule is structural rather than a name, so it also covers submodules, vendored clones, and
whatever the next harness invents, without naming any of them. A directory that merely *resembles* a
checkout by name but carries no `.git` of its own is still part of this tree and is still scanned.

All three walk sites are guarded: the fixed-convention scan, the `**` any-depth expansion behind
extra anchors, and the `<project>` glob frontier.
