---
'cyberplace': patch
---

Ship the `cyberplace/tavern` entry point. `exports["./tavern"]` resolves to
`src/tavern/plugins.ts`, but `files` listed only `bin`, `dist` and `governances`, so the
file was never in the tarball and the subpath 404'd for every consumer outside this
workspace. In-repo callers resolved through the workspace link, which is why it went
unnoticed. `src/tavern` is now packed.

Also releases the tavern source resolution landed in the plugin extraction: a
`git-subdir` marketplace entry rendered as `npm:undefined` because the resolver
understood only `string` and `npm` sources. It now resolves those to the owning repo's
directory URL.
