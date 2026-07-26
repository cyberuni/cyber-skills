# Agent harness landscape — canonical comparison set

Standing reference for any task that researches, surveys, or compares agent harnesses (website content, specs, ADRs). Re-derive this list from current sources rather than trusting memory — the space moves fast — but treat the tiers below as the floor: don't drop a tool from the always-include tier without updating this file first.

## Always include

| Harness | Vendor | Notes (as of 2026-07) |
| --- | --- | --- |
| Claude Code | Anthropic | Wins on capability/context (per 2026 roundups); hook system, subagents |
| Cursor | Cursor / Anysphere | Wins on UX in most 2026 comparisons |
| Codex CLI | OpenAI | #1 on several benchmarks as of GPT-5.6 GA, July 2026 |
| GitHub Copilot CLI | GitHub / Microsoft | Vendor-native, IDE + terminal |
| Gemini CLI | Google | Vendor-native |

## Secondary tier — mention if relevant to the comparison's scope

| Harness | Notes |
| --- | --- |
| Cline | Open-source, VS Code-hosted agent; appears in most "front-runner" 2026 lists |
| OpenCode | Model-agnostic open-source CLI; appears in most 2026 "top CLI tools" lists |

## Excluded from the standing list (checked 2026-07, re-verify before reusing)

- **Windsurf** — real product, but consolidated after a 2025 acquisition; not appearing as a front-runner in 2026 roundups. Include only if the comparison is explicitly about IDE-integrated agents or acquisition history.
- **Aider** — real, older terminal-first tool; not appearing in current 2026 front-runner lists. Include only for comparisons scoped to open-source/legacy tooling.
- **OpenClaw, Hermes** — no evidence found of these as established agent harnesses as of 2026-07. Do not include without a specific source naming them; if found, add here with the source before using elsewhere.

## Framing

Agent = Model + Harness. When comparing, separate what's attributable to the underlying model (e.g. GPT-5.6, Opus 4.8, Claude 5) from what's attributable to the harness (context management, tool design, retry/failure handling, hook system) — two tools on the same backend can differ purely on harness design.

## Sources (2026-07 sweep)

- [Every AI Coding CLI in 2026: The Complete Map (30+ Tools Compared)](https://dev.to/soulentheo/every-ai-coding-cli-in-2026-the-complete-map-30-tools-compared-4gob)
- [The 2026 Guide to Coding CLI Tools: 15 AI Agents Compared](https://www.tembo.io/blog/coding-cli-tools-comparison)
- [Best CLI AI Tools in 2026: CLI Coding Agents Compared](https://kilo.ai/articles/best-cli-coding-agents)

## Maintenance

Re-run a fresh web sweep before relying on this file for anything published (website, spec) if it's more than ~2 months old — this list decays fast. Update the tiers and sources above in place rather than creating a new dated file for the same topic.

Paired with the `.agents/skills/agent-harness-landscape/` skill, which agents load on demand and which carries the same tiers without the sourcing. This file holds the evidence; the skill holds the decision. Update both when the set changes.
