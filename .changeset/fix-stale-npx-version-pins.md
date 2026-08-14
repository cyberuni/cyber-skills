---
'cyberplace': patch
'cyberfleet': patch
'cyberlegion': patch
---

Fix stale `npx` version pins in the readmes.

The documented pin-to-an-exact-version examples cited versions that were never
published — `cyberplace@0.7.0` and `cyberfleet@0.1.0` return E404 — so anyone
copying them got a hard failure. `cyberlegion@0.1.0` resolved but was two minors
behind. Each now cites the current published version.
