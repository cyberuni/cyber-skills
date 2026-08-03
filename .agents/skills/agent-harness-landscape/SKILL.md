---
name: agent-harness-landscape
activation: per-situation
description: "Use this skill when research, website content, a spec, or an ADR compares, surveys, or lists agent harnesses (coding agents / AI coding CLIs) — it supplies the canonical comparison set so the list is consistent across sessions instead of ad-hoc from memory."
metadata:
  internal: true
---

# Agent harness landscape

The canonical comparison set for this repo. Treat the tiers below as the floor: don't drop a tool from the always-include tier without updating this skill first. Re-derive membership from current sources when the stakes are published output — the space moves fast.

## Always include

| Harness | Vendor | Notes (as of 2026-07) |
| --- | --- | --- |
| Claude Code | Anthropic | Wins on capability/context (per 2026 roundups); hook system, subagents |
| Cursor | Cursor / Anysphere | Wins on UX in most 2026 comparisons |
| Codex CLI | OpenAI | #1 on several benchmarks as of GPT-5.6 GA, July 2026 |
| GitHub Copilot CLI | GitHub / Microsoft | Vendor-native, IDE + terminal |
| Gemini CLI | Google | Vendor-native |

## Secondary tier — include if relevant to the comparison's scope

| Harness | Notes |
| --- | --- |
| Cline | Open-source, VS Code-hosted agent; appears in most "front-runner" 2026 lists |
| OpenCode | Model-agnostic open-source CLI; appears in most 2026 "top CLI tools" lists |

## Excluded from the standing list

Checked 2026-07; re-verify before reusing.

- **Windsurf** — real product, consolidated after a 2025 acquisition; not a front-runner in 2026 roundups. Include only when the comparison is explicitly about IDE-integrated agents or acquisition history.
- **Aider** — real, older terminal-first tool; absent from current 2026 front-runner lists. Include only for comparisons scoped to open-source or legacy tooling.
- **OpenClaw, Hermes** — no evidence of these as established agent harnesses as of 2026-07. Do not include without a specific source naming them.

## Framing

Agent = Model + Harness. Separate what is attributable to the underlying model (GPT-5.6, Opus 5, Gemini) from what is attributable to the harness (context management, tool design, retry and failure handling, hook system). Two tools on the same backend can differ purely on harness design.

## Freshness

If the "as of" dates above are more than ~2 months stale and the output is published (website, spec, ADR), run a fresh web sweep first, then update the tiers here in place.
