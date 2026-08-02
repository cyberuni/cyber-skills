---
title: Agent Configuration
description: What agent configuration is — the collective term for all instructions an agent runtime loads to shape behavior.
---

**Agent configuration** is the collective term for [agent instructions](../instructions.md) and settings for agent harness.

## Agent instructions

**Agent instructions** are prose that agent reads and follows.

Well written agent instructions make a huge difference. So it is important to understand how to write good agent instructions. A few qualities matter most:

| Topic | What it's about |
| ----- | ---------------- |
| **[Purpose](/agent-configuration/instruction-purpose/)** | What the block is *for* — procedure, criteria, policy, reference, menu, tone, or structure. Mismatched purpose is the most common source of confused instructions. |
| **Word choice** | Precise, unambiguous terms. Hedge words ("try to", "consider", "usually") give the model room to skip the instruction; state the rule as a fact. |
| **Tone** | The manner of address — formal, casual, terse — separate from what's actually being said. Two instructions can carry identical content in different tones. |
| **Grammar** | Mood should match purpose: imperative ("Run the tests") for procedure, declarative ("The build output lives in `dist/`") for reference. |
| **Specificity** | Concrete thresholds and examples beat vague guidance — "cap lists at 5 items" over "keep it short." |
| **Structure** | Headings and formatting that signal purpose at a glance; scannable lists over dense prose paragraphs. |

Purpose has its own page because it's the axis with the most nuance and the most room for error; the rest are noted here for now.

## Agent settings

**Agent settings** are the harness's own config file — `.claude/settings.json` for Claude Code — not prose the agent reads, but data the harness applies directly: which tools are pre-approved, which hooks fire on which events, and other per-project or per-user defaults.

| Topic | What it's about |
| ----- | ---------------- |
| **[Permissions](/concepts/permissions/)** | Allow/deny/ask lists for tools, set in `settings.json`'s `permissions` block. Enforced by the harness regardless of what any instruction says. |
| **Hooks** | Shell commands registered against lifecycle events (`SessionStart`, `PermissionRequest`, etc.) in `settings.json`'s `hooks` block. Runs deterministically, with no model tokens spent. |
| **Environment & model defaults** | `env` vars injected into every session, and a default model/effort for the project — set once instead of repeated per invocation. |
| **Project vs. user scope** | `.claude/settings.json` (repo-local, shared with the team) layers under `~/.claude/settings.json` (personal, applies everywhere). The same project/user split shows up in every harness below. |

Permissions has its own page because it's the boundary with the most surface area; the rest are noted here for now.

### Using it efficiently

- **Pre-approve safe, repeated commands.** Every unclassified tool call is a permission prompt; an allowlist for read-only or routine commands removes that friction. The `fewer-permission-prompts` skill automates this for Claude Code by scanning past transcripts for common calls.
- **Put team rules in project scope, personal preferences in user scope.** Project settings are checked in and reviewed like code; user settings follow you across repos and should stay out of the repo.
- **Register a hook instead of trusting the agent to remember.** A rule the agent must apply on every turn (formatting, commit discipline) is safer as a hook than as an instruction — it can't be skipped, forgotten, or reasoned around.
- **Keep the default sandbox/approval mode as tight as the task allows**, loosening it only for scoped, trusted work.

### Similar settings across harnesses

| Harness | Settings file(s) | Typical scope |
| ------- | ----------------- | -------------- |
| **Claude Code** | `.claude/settings.json` (project), `~/.claude/settings.json` (user) | Tool permissions, hooks, env vars, model default |
| **Cursor** | `.cursor/permissions.json` + `.cursor/hooks.json` (project and user versions, arrays merged), `.cursor/cli.json` (CLI-specific allowlist) | Tool permissions, hooks |
| **Codex CLI** | `~/.codex/config.toml`, with named `--profile` overrides | `sandbox_mode`, `approval_policy`, model, per-environment profiles |
| **GitHub Copilot CLI** | `permissions-config.json` in the CLI config dir, or `--allow-tool` / `--deny-tool` / `--available-tools` flags | Tool allow/deny lists |
| **Gemini CLI** | `.gemini/settings.json` (project), `~/.gemini/settings.json` (user) | MCP servers, model defaults, approval mode, tool permissions |

The shape repeats everywhere: a project-scoped file for team-shared rules, a user-scoped file for personal defaults, and the same two levers — what tools may run, and what happens automatically — just named differently per harness.

## Open Standards

Packages and plugins in this repository is designed to work with multiple agent harnesses. Therefore, they follow open standards such as [Agent Skills](https://agentskills.io) and [Agent Plugins](https://agent-plugins.org).

## References

- [Claude Code settings](https://code.claude.com/docs/en/settings)
- [Cursor — permissions.json reference](https://cursor.com/docs/reference/permissions)
- [Cursor — hooks](https://egghead.io/simplify-cursor-hooks-configuration-with-json-schema~cqtlr)
- [Codex CLI — config.toml guide](https://majesticlabs.dev/blog/202607/codex-cli-configuration-guide)
- [Codex CLI — config, profiles, sandbox deep dive](https://www.digitalapplied.com/blog/codex-cli-deep-dive-config-profiles-sandbox-2026)
- [GitHub Copilot CLI — allowing and denying tool use](https://docs.github.com/en/copilot/how-tos/copilot-cli/use-copilot-cli/allowing-tools)
- [GitHub Copilot CLI — configuration directory reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-config-dir-reference)
- [Gemini CLI — configuration](https://google-gemini.github.io/gemini-cli/docs/get-started/configuration.html)
- [Gemini CLI — settings](https://geminicli.com/docs/cli/settings/)
- [Gemini CLI — hooks](https://geminicli.com/docs/hooks/)
