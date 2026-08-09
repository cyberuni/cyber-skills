---
name: resync-local-plugins
description: "Use this skill after committing changes to this repo's plugins or skills, to re-pin the local-directory cyberplace marketplace so the installed plugins reflect the new HEAD. Triggers: 'resync the plugins', 'the marketplace is stale', 'my skill edit isn't loading', 'update the local plugins', after landing a commit under plugins/."
metadata:
  internal: true
---

# Resync Local Plugins

This repo's `cyberplace` Claude Code marketplace is a **`directory` source** pointing at the local working tree. A directory marketplace snapshots at the **committed git HEAD**, not the working tree — so uncommitted plugin/skill edits never go live, and installed plugins stay pinned to whatever HEAD was current when they were last installed. Run this after committing plugin/skill changes to move the pin forward.

**Not every plugin is a directory source.** Each entry in `.claude-plugin/marketplace.json` declares its own `source`, and an **npm-source** plugin installs from the registry — this skill cannot move it to your local HEAD at all. Read the manifest before assuming a resync will help:

```bash
ROOT="$(git rev-parse --show-toplevel)"
node -e 'const m = JSON.parse(require("fs").readFileSync(process.argv[1], "utf8"))
for (const p of m.plugins)
  console.log(p.name.padEnd(14), typeof p.source === "string" ? p.source : JSON.stringify(p.source))' \
  "$ROOT/.claude-plugin/marketplace.json"
```

Anything not of the form `./plugins/<name>` needs a **release**, not a resync. See the npm-source note below.

## Preconditions

- Your plugin/skill edits are **committed** (this reads HEAD, not the working tree). Uncommitted edits are invisible — commit first.
- The `cyberplace` marketplace is a directory source at this repo. Confirm:
  ```bash
  claude plugin marketplace list        # cyberplace → Source: Directory (…/cyberplace)
  ```
  If it still points at GitHub, repoint it first: `claude plugin marketplace remove cyberplace && claude plugin marketplace add "$(git rev-parse --show-toplevel)"`.

## Steps

1. **Re-snapshot the marketplace** to current HEAD:
   ```bash
   claude plugin marketplace update cyberplace
   ```

2. **Re-pin every installed `@cyberplace` plugin.** Plain `install` is idempotent and will NOT move the pin — you must uninstall then install:
   ```bash
   for p in $(claude plugin list 2>/dev/null | grep -oE '[a-z-]+@cyberplace' | cut -d@ -f1 | sort -u); do
     claude plugin uninstall "${p}@cyberplace"
     claude plugin install   "${p}@cyberplace"
   done
   ```

3. **Verify by content, not by metadata.** Each `@cyberplace` key in `installed_plugins.json` maps to an **array of install records across scopes** — index 0 is usually a stale `scope: "project"` pin from an old `cyberplace.worktrees/*` checkout, so reading it reports failures that aren't real. Filter to `scope: "user"`, then diff the installed tree against the source:

   ```bash
   ROOT="$(git rev-parse --show-toplevel)"
   HEAD=$(git -C "$ROOT" rev-parse --short=12 HEAD)
   node -e '
     const fs = require("fs")
     const root = process.argv[1]
     const inst = JSON.parse(fs.readFileSync(process.env.HOME + "/.claude/plugins/installed_plugins.json", "utf8"))
     const mkt = JSON.parse(fs.readFileSync(root + "/.claude-plugin/marketplace.json", "utf8"))
     const kind = Object.fromEntries(mkt.plugins.map(p => [p.name, typeof p.source === "string" ? "dir" : "npm"]))
     for (const [key, recs] of Object.entries(inst.plugins)) {
       if (!key.endsWith("@cyberplace")) continue
       const name = key.slice(0, -"@cyberplace".length)
       const rec = (recs || []).find(r => r.scope === "user")
       if (!rec) { console.log([name, "-", "-", "NO-USER-INSTALL"].join("\t")); continue }
       console.log([name, kind[name] || "?", (rec.gitCommitSha || "-").slice(0, 12), rec.installPath].join("\t"))
     }' "$ROOT" | while IFS=$'\t' read -r name knd sha dir; do
       case "$knd" in
         npm) pin="npm source — cannot track HEAD" ;;
         dir) [ "$sha" = "$HEAD" ] && pin="pin OK" || pin="PIN STALE ($sha)" ;;
         *)   pin="$sha" ;;
       esac
       # diff -rq emits "Files A and B differ", so exclusions must match mid-line, not at $
       n=$(diff -rq "$dir" "$ROOT/plugins/$name" 2>/dev/null \
           | grep 'differ' \
           | grep -vE '\.turbo/|node_modules/|/package\.json and ' | wc -l)
       printf '%-14s %-32s content-diffs=%s\n' "$name" "$pin" "$n"
     done
   echo "HEAD: $HEAD"
   ```

   **`content-diffs=0` is the pass condition** for every plugin, directory- and npm-sourced alike. Directory-sourced plugins must *also* read `pin OK`. The exclusions are deliberate: `.turbo/` and `node_modules/` are local build state, and npm rewrites `package.json` on publish — none of the three indicate drift.

4. **Tell the user to run `/reload-plugins`.** This reloads every active plugin's code from disk into the running process — plugins, skills, agents, hooks, and plugin MCP/LSP servers — so the re-pin takes effect without a restart. `/new` and `/clear` do NOT reload plugins; `/reload-skills` only refreshes skill text, not plugin code/agents/hooks. Caveats: if a re-pinned plugin ships an MCP server the reload may invalidate the prompt cache on the next request — pass `/reload-plugins --force` to push it through. A full quit-and-relaunch of the `claude` process is the fallback if `/reload-plugins` misbehaves.

## Notes

- Do not push or commit anything here — this only touches local plugin install state (`~/.claude/plugins/`), never the repo.
- If a plugin fails to reinstall, report which one and stop; do not leave the set half-pinned.

### npm-source plugins cannot be resynced

A plugin declared as `{"source":"npm","package":"<pkg>"}` installs from the registry, so **no amount of `marketplace update` + reinstall will pick up local edits**. Shipping a change to one means releasing it: changeset → version PR → release workflow → `claude plugin uninstall/install <name>@cyberplace`.

Two tells that you are looking at an npm-source plugin, both visible in `installed_plugins.json`:

- its user-scope record has **no `gitCommitSha`** while every directory-sourced sibling has one
- its cache directory is named for the npm version (`…/sdd/0.0.0`) rather than a commit sha

### Do not trust the recorded version

Claude Code keys the cache directory on the version string, and **reuses a directory whose name it already has** — it has been observed writing `0.1.0` content into a directory still named `0.0.0`, leaving `version: "0.0.0"` in the install record. The directory name and the `version` field are therefore both unreliable. The content diff in step 3 is the only honest check.
