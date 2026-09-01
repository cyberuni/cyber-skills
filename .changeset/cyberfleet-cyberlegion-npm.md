---
'cyberfleet': patch
---

Depend on the published `cyberlegion@^0.3.1` instead of the workspace copy. `cyberlegion`
was extracted to its own repository, so the `workspace:*` link no longer exists and the
runtime dependency now resolves from the registry.
