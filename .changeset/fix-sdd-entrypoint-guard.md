---
"cyber-sdd": patch
---

**Fix** — SDD skill-script CLIs silently no-opped on the supported Node floor. The entrypoint
guard used `import.meta.main`, added only in Node 24.2.0, while the engines floor is `>=22`; on
Node 22/23 the guard was `undefined`, so the `bin` ran nothing and exited 0. Switched all 19
affected scripts — and 7 more that used the `file://${process.argv[1]}` concat, which breaks on
any install path holding a space, `#`, `?`, or `%`, and under the symlink npm creates for a `bin`
— to the portable `pathToFileURL(realpathSync(process.argv[1])).href === import.meta.url`
entrypoint check. Adds a guard test so no shipped script can regress to either form. Fixes #272.
