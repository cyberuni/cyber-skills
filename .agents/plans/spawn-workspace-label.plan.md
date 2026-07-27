---
cr-ref: spawn-workspace-label
project: packages/cyberlegion
todos:
  - content: intake — locate spec, scaffold plan, emit run-level leash line
    status: completed
  - content: explore — draft the naming rule into unit/lifecycle + mux spec + suite
    status: completed
  - content: spec gate — structural additive check (gherkin-cli), self-asserted; no cold spec-judge run
    status: completed
  - content: deliver — implement label derivation + herdr label pass-through, tests
    status: completed
  - content: impl gate — cold impl-judge, pnpm verify
    status: completed
  - content: handoff — commit one unit of work, record follow-ups
    status: completed
---

# spawn-workspace-label — name the herdr workspace after the spawn's subject

## CR

Source: a direct owner brief (no forge issue). `unit spawn --at workspace` opens the unit's own
visible space, but the space carries no name a human can scan — herdr shows whatever it defaults to.
Give it a **short, human-identifiable label** derived from the spawn's own subject.

## Shape of the change

- **`unit/lifecycle`** — spawn resolves a **workspace label** for a `workspace` placement:
  `<code>-<subject>`, **≤ 30 characters including the code**.
  - **Code** (NieR YoRHa unit classes), matched against the brief's leading action in a fixed order:
    `A2-` teardown/removal → `9S-` recon/read-only analysis → `2B-` everything else (the default).
  - **Subject** — `--handle` when given, else the brief's first non-empty line, lowercased,
    action-word and leading article dropped, non-alphanumerics collapsed to `-`, then whole words
    taken greedily up to the 27-char remainder. Empty result falls back to the unit's short id.
- **`mux`** — a `workspace` placement opens under the resolved name; a `pane:*` or `tab` placement
  carries none. How a backend writes the name onto its own tier belongs to the multiplexer package.

## Non-goals

Pane/tab placements (no label), tmux window naming, uniqueness/collision handling between labels,
and every other spawn behavior (handle, harness, task delivery, SessionStart cold-read).

## NEXT

Landed, then re-cut on rebase: the target moved the multiplexer mechanism into an external package
that already carries the naming seam, so the mux-side scenarios were restated at the retargeted node
boundary (ledger seq 5) and the tmux follow-up is moot (seq 6). The derivation contract is unchanged.
