# check-result-freshness

Internal, non-invokable ACED engine — loaded in-session by `run` and `improve`, not triggered
directly. It reports whether a target's latest recorded result is still safe to present as current
and passing.

## What it does

Resolves a target's subject from its `eval.md`, checks every subject-dependent file it can reliably
identify (the subject itself, sibling `assets/`/`references/` files, referenced files elsewhere, and
the node's `.feature`) for edits after the latest recorded result's timestamp, and checks that
result's own scenarios for failures, an `implementation_pass: false`, and passes that are untrusted
or unprovable — either because a structured field says so or because the judge's own explanation of a
pass hedges in a way that means it couldn't actually settle the assertion.

Read-only — it never writes a result, an eval.md, or any other file. Run standalone as:

```bash
node plugins/aced/skills/check-result-freshness/scripts/check-result-freshness.mts \
  --node .agents/specs/aced/<project>/…/<node> [--root .] [--format text|json]
```

Exit 0 = safe to report as-is (including a warnings-only result — surface the warnings, don't
summarize them away). Exit 1 = do not present this result as current or passing.
