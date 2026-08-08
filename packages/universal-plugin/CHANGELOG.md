# universal-plugin

## 0.2.2

### Patch Changes

- 2702146: `plugin bundle` no longer reports a clean bundle when it resolved nothing (#315).

  `--root` is now resolved to an absolute path and workspace discovery walks up for the
  `pnpm-workspace.yaml` marker, so the same plugin resolves the same workspace whichever directory
  `bundle` ran from — `--root .` from inside a plugin directory previously resolved zero packages,
  counted every pin as `skipped`, and still exited 0.

  When every referenced package is skipped, `bundle` now warns with the count
  (`resolved 0 of N referenced package(s) against the workspace`) and prints a corrective next-step
  instead of "review and commit the pinned skills", so a zero-resolution can no longer be mistaken for
  a bundled plugin at release time.

## 0.2.1

### Patch Changes

- 7c92d8e: Mark the CLI bin shim as executable so it runs directly after install.

## 0.2.0

### Minor Changes

- c6bc08a: Add `publish sync-version` command to sync the `version` field in `.plugin/plugin.json` from the npm package declared by a new `packagePath` field. Run `universal-plugin publish sync-version` after `changeset version` to keep the plugin manifest version in sync with the npm package. Also fixes the `build` command to strip `packagePath` from generated vendor manifests.
- 1100fa3: Add initial `universal-plugin` CLI with cross-vendor plugin management commands.

  New commands:
  - `prepare` — diffs the current vendor's installed plugins against the last snapshot and writes pending cross-vendor sync actions to state.
  - `sync apply <actionId>` — executes a pending install, update, or remove action using the target vendor's registered CLI command (or emits a manual instruction when none is configured).
  - `governance show <name>` / `governance list` — resolves and displays governance files by scope (global → project).
  - `asset-store` — manages the local store of downloaded plugin assets.
  - `self-update` — rewrites `universal-plugin` version pins in hook files when a newer version is detected.
  - `clean` — removes the local asset store directory.

  Supporting modules added: state file schema with tolerant reader and mutation helpers, vendor registry with bundled defaults and user-override support, source registry with store-path derivation for npm / GitHub / GitLab / URL sources.
