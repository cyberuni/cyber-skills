# verification — quill/init-quill

Per-scenario acceptance checks for the frozen suite at `init-quill.feature`. Authored by the
impl-producer (`quill-doc-writer`); **run** by the impl-judge (`quill-judge`), which authors none of
them.

**Target document (all scenarios):** `apps/website/src/content/docs/quill/init-quill.md`

## Checks that apply to every scenario

- **Existence** — the file exists at the target path above.
- **Completeness** — the file contains no `TBD`, `TODO`, or `FIXME`, and no heading is followed
  immediately by another heading or by end-of-file.
- **Frontmatter** — a `title` and a `description` field are present.
- **Census check (applies document-wide).** The document must not enumerate, count, or tabulate
  either (a) the artifact-types Quill claims or (b) which role/governance bindings Quill fills. A
  link set resolving to exactly the bars Quill authors counts as an enumeration. Any such
  enumeration is a FAIL even where a scenario would otherwise pass.

## Artifacts (layer = impl)

| Path | Layer | Scenarios |
|---|---|---|
| `apps/website/src/content/docs/quill/init-quill.md` | impl | all 16 in `init-quill.feature` |

---

## `the steps assume nothing the prerequisites did not declare`

**Sections:** `## Before you start`, `## Register Quill`

1. A prerequisites section exists and declares its rows (Quill installed; an SDD project at the
   level of knowing what a mission is).
2. Walk the numbered steps under `## Register Quill` in order. For each file, tool, or term a step
   requires — project root, `init-quill`, `.agents/universal-plugin.json`, `sdd-plugins`, the
   returned report — confirm it is either a declared prerequisite or introduced on this page.
3. No step instructs the reader to read another page before continuing. Off-site links inside the
   numbered steps are a FAIL; same-page anchors are permitted.

## `the page names what to run and what it writes`

**Section:** `## Register Quill`

1. The skill performing the registration is named as `init-quill`.
2. At least one concrete way to set it off is given (a phrase to ask for, or the skill name to
   invoke).
3. `.agents/universal-plugin.json` is named as the file the registration writes — present in the
   opening or in the steps, reachable reading from the top.

## `the page states what the registration changes on disk`

**Section:** `## What the registration changes on disk`

All four claims present:

1. The registry file at the project root is found, or created when absent.
2. The entry is stamped with Quill's own version.
3. The entry is written into the `sdd-plugins` array.
4. The file is written back with the updated contents.

## `every step in the procedure carries its own content`

**Sections:** `## Register Quill`, `## What the registration changes on disk`

1. Every numbered item states an action to take or a change it makes — no empty or title-only steps.
2. No step's content is deferred to another page; a step that consists of a pointer plus nothing
   else is a FAIL.

## `the page tells the two stop causes apart`

**Section:** `## When the run stops`

1. Exactly two stop causes are presented, each under its own heading.
2. Each is introduced by its **cause** (a registry that does not parse; a squad with no
   `governances` block), not by the text of an error message.
3. Each names the change the reader makes before re-running.

## `a registry that does not parse stops the run and leaves the file alone`

**Section:** `### The registry file does not parse`

1. States the registration stops with an error.
2. States the existing file is left unmodified.
3. States that overwriting it could destroy an entry belonging to another plugin.
4. Names repairing the file by hand as what unblocks the reader.

## `a squad missing its governances block is rejected before anything is written`

**Section:** `### A squad carries no governances block`

1. States the registration is rejected.
2. States the registry file is not written.
3. States that a binding inside the block may be `null` while the block itself must be present.

## `the page ends by naming the reader's next step`

**Section:** `## Next step`

1. Names starting a documentation mission as the next thing to do.
2. States that the conductor resolves the Quill roles from the registry without further setup.
3. Links the page that owns starting a mission (`/sdd/overview/`).
4. **Reader-path continuity** — the section is reachable from both completion routes: the
   confirmation section and the re-running section both precede it in document order and neither
   terminates the reader's path.

## `the page names what to look for to confirm the entry is present`

**Section:** `## Confirm it landed`

1. Names the `sdd-plugins` array in `.agents/universal-plugin.json` as where the reader looks.
2. States the entry carries a version stamp.
3. Names the squad's `artifact-types` field as part of what the reader checks.
4. **Reaches the list of artifact-types by link** (`/quill/overview/`) and does **not** enumerate
   its members anywhere on the page.

## `the page shows the entry as one squad with its three parts`

**Section:** `### The entry, block by block`

1. An example of the entry is shown as it sits inside the `sdd-plugins` array.
2. The example holds exactly one squad.
3. That squad carries `artifact-types`, a `roles` block, and a `governances` block.
4. **Census check** — the example's values are elided placeholders, not the live bindings. An
   example reproducing the actual role or governance values is a FAIL.

## `re-running rewrites the existing entry rather than appending another`

**Section:** `## Re-running over an entry that already exists`

All four claims present:

1. An existing Quill entry is rewritten in place.
2. No second Quill entry is added alongside it.
3. An entry in an older shape is migrated by that rewrite.
4. An entry whose recorded version differs from Quill's own is rewritten.

## `other plugins' entries are stated to be left untouched`

**Section:** `## Re-running over an entry that already exists`

1. States entries other than Quill's are not modified.
2. States entries other than Quill's are not reordered.

## `the roles block is presented with what a null binding means`

**Section:** `### The roles block`

1. States the block carries the SDD production-chain role keys.
2. States each key holds either a bound agent or `null`.
3. States a `null` binding means the SDD default is used for that role.
4. **Reaches what a bound agent does by link** (`/quill/production-chain/`) rather than describing
   it.
5. **Census check** — the role keys are neither listed nor counted here.

## `the governances block is not presented as unbound`

**Section:** `### The governances block`

1. States the block is required on every squad.
2. States a `null` binding falls back to the SDD default bar for that slot.
3. States that Quill does **not** leave every governance binding `null`. A page stating or implying
   the opposite — the stale draft's claim — is a FAIL.
4. **Reaches which bindings Quill fills by link** (`/quill/production-chain/`) without reproducing
   the table.
5. **Generic-redirect check** — the page names no individual bar. If a future revision names one, it
   must link the page owning that bar and must not state what the bar requires. A link set
   resolving to exactly the bars Quill authors is a FAIL of the census check above.

## `the page links the owning page instead of developing the binding`

**Section:** `### Questions this page hands off`

1. *What a bound agent does* → reached by link (`/quill/production-chain/`).
2. *What the checks verify* → reached by link (`/quill/doc-eval-model/`).
3. *What a bar requires* → reached by link. Because the redirect must stay generic (see the
   generic-redirect check above), this is satisfied by a link to the page whose table names each bar
   and links onward, rather than by direct links to the individual bar pages. A direct link set is
   **not** required and, if it resolves to exactly the bars Quill authors, is a FAIL.
4. None of the three topics is developed on this page in place of its link.

## `the block descriptions are reachable from both arrivals`

**Sections:** `## Confirm it landed`, `## Re-running over an entry that already exists`,
`## What the entry binds`

1. `## What the entry binds` is a **top-level** section, not nested inside a maintainer-only
   section.
2. **Completion arrival** — the first-time reader, arriving via `## Confirm it landed`, reaches the
   block descriptions: `### The entry, block by block` carries a forward link to
   `#what-the-entry-binds`.
3. **Audit arrival** — the maintainer, arriving via `## Re-running over an entry that already
   exists`, reaches the same descriptions: that section routes onward to `## What the entry binds`.
4. Neither route requires reading the other's section first — verify by reading each route in
   isolation and confirming no step depends on content only the other route passes through.

## Deliberate violations

None recorded for this document.
