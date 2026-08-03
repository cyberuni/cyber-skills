# verification — quill/production-chain

Per-scenario acceptance checks for the frozen suite at `production-chain.feature`. Authored by the
impl-producer (`quill-doc-writer`); **run** by the impl-judge (`quill-judge`), which authors none of
them.

**Target document (all scenarios):** `apps/website/src/content/docs/quill/production-chain.md`

## Checks that apply to every scenario

- **Existence** — the file exists at the target path above.
- **Completeness** — the file contains no `TBD`, `TODO`, or `FIXME`, and no heading is followed
  immediately by another heading or by end-of-file.
- **Frontmatter** — a `title` and a `description` field are present.

## Artifacts (layer = impl)

| Path | Layer | Scenarios |
|---|---|---|
| `apps/website/src/content/docs/quill/production-chain.md` | impl | all 13 in `production-chain.feature` |

---

## `the page places each Quill agent at the phase that dispatches it`

**Section:** `## Where each Quill agent acts in the mission loop`

1. The section exists.
2. `quill-spec-writer` appears in a row whose point-of-loop cell names **explore**.
3. `quill-doc-writer` appears in a row whose point-of-loop cell names **deliver**.
4. `quill-judge` appears in a row whose point-of-loop cell names **the impl gate**.
5. Each of the three rows also carries the role slot the agent fills, so the phase and the role are
   readable off one row.

## `a phase that dispatches no Quill agent names what acts there instead`

**Section:** `## Where each Quill agent acts in the mission loop`

1. The same table that carries the three dispatching phases also carries a row for **the spec gate**
   and a row for **the design fork** — i.e. all five points sit in one table, not in a separate
   "exceptions" list.
2. The spec-gate row names an actor that acts there (SDD's spec gate) and marks the `spec-judge`
   slot as empty.
3. The design-fork row names an actor that acts there (the SDD conductor) and marks the
   `solution-producer` slot as empty.
4. The prose directly below the table states that a role Quill leaves empty **falls back to the SDD
   default** and that it is **not a point where nothing runs**.
5. **Neutrality check (recorded conflict).** Neither the rows nor the prose names a specific
   spec-judge agent, and neither states that no judge agent runs. A revision that resolves that
   question in either direction is a FAIL of this check, not a fix.

## `the page states the three agents are conductor-dispatched and not reader-invocable`

**Section:** `## The three agents are dispatched, not invoked`

1. The section exists.
2. All three agent names appear in it.
3. It states that the **SDD conductor** dispatches them.
4. It states that a reader does not invoke them directly.

## `the page separates the agent that authors a document from the agent that runs its checks`

**Section:** `## Who writes, and who runs`

1. The section exists.
2. It states that `quill-doc-writer` authors **both** the documents **and** their per-scenario
   acceptance checks.
3. It states that `quill-judge` **runs** those checks and authors no criteria of its own.
4. The two claims are separately attributable — a reader can tell which agent each verb belongs to.

## `the page enumerates the three frozen anchors the judge runs from`

**Section:** `### Three anchors, and no fourth`

1. The section exists and presents exactly three anchors.
2. The frozen `.feature` is named.
3. The frozen document-scoped rule is named.
4. The frozen defect catalog is named.
5. A statement is present that each of the three is an artifact the judge **did not write**.

## `an impression matching none of the anchors is stated not to be a finding`

**Section:** `### Three anchors, and no fourth`

1. The page states that there is **no fourth anchor**.
2. The page states that an impression matching none of the three is **not a finding**.

## `the page states what the judge's independence rests on`

**Section:** `### What the independence rests on`

1. The section exists.
2. It attributes independence to the anchors being artifacts the judge did not write.
3. It attributes independence to the judge being a separate runner from the author.
4. Both attributions are present; a page carrying only one is a FAIL.

## `a deferred claim is named with its owning page rather than developed here`

**Section:** `## Questions this page hands off`

1. The section exists and pairs each deferred claim with an owning page.
2. *What a check verifies / how the judged pass runs* is paired with `/quill/doc-eval-model/`.
3. *What a bar contains* is paired with `/quill/quill-builder-spec/` and
   `/quill/quill-builder-impl/`.
4. *How a registry entry is written* is paired with `/quill/init-quill/`.
5. **Non-development check** — for each of those rows, the page does not elsewhere enumerate,
   tabulate, or argue the deferred claim. Naming a bar or a check is permitted; developing its
   contents is a FAIL.

## `the page presents all five production-chain roles as one lookup`

**Section:** `## The five production-chain roles`

1. The section exists and its table carries exactly five role rows.
2. `spec-producer`, `solution-producer`, `spec-judge`, `impl-producer`, and `impl-judge` each appear
   as a row.
3. The prose states that the five are SDD's **closed set** and that a plugin fills a **subset**.
4. `quill-spec-writer` is bound to `spec-producer`, `quill-doc-writer` to `impl-producer`, and
   `quill-judge` to `impl-judge` — readable off one row each.

## `every unfilled role row names the SDD default that fills it`

**Section:** `## The five production-chain roles`

1. `solution-producer` and `spec-judge` are the two rows showing `null`.
2. Each of those two rows names an actor that fills it in Quill's absence.
3. **Sweep** — every one of the five rows carries either a Quill agent name or a named filler; no
   row's "who acts" cell is blank, hedged, or absent.
4. **Neutrality check** — as above, the `spec-judge` row names an actor without resolving whether a
   judge agent is spawned.

## `the page separates the bars Quill binds from the bars it leaves to SDD`

**Section:** `## The five bar governances`

1. The section exists and its table carries exactly five bar rows.
2. `builder-spec` is bound to `quill-builder-spec` and its row names the **spec gate** as where it
   acts.
3. `builder-impl` is bound to `quill-builder-impl` and its row names the **impl gate** as where it
   acts.
4. `oracle-spec`, `architect-spec`, and `architect-impl` are each shown as left to the SDD default.

## `the page names the registry file and the entry that decides every binding`

**Section:** `## Checking the table against the registry`

1. The section exists.
2. `.agents/universal-plugin.json` is named as the authority for every binding the page reports.
3. The `sdd-plugins` entry named `quill` is named as the entry to read, and its squad's **`roles`**
   and **`governances`** objects are each named as where the corresponding table comes from.
4. The page states that it **reports** the bindings and the registry **decides** them.
5. **Reader-path continuity** — the statement is reachable from both binding tables: the intro
   links to this section, and the section follows both tables in document order.

## `a reader who needs the bindings created is routed to the page that writes them`

**Section:** `## Questions this page hands off` (closing paragraph)

1. The page directs the question of **creating** an entry to `/quill/init-quill/`.
2. The page states that what an entry that already exists currently binds stays on this page.
3. Both halves are present; routing without keeping, or keeping without routing, is a FAIL.

## Deliberate violations

None recorded for this document.
