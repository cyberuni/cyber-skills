# motive-model — the Motive Model section

Descriptive grouping. Mirrors `src/content/docs/motive-model/`. **One page, one behavioral node** —
each document carries its own spec stating its north star, required coverage, and the reader
questions it must route.

This section is unusual in the corpus: it is the website's rendering of a **project spec that lives
elsewhere**, at [`artifacts/specs/motive-model/`](../../../../../../artifacts/specs/motive-model/spec.md).
That spec is the authority for what the model *is*; the nodes here are the authority for what each
**page** must land and for whom. A page node derives its coverage from the project spec's
`## Use Cases` (Output 1), never by reading backward from the published draft.

| Page | Node | Doc type | Role |
|---|---|---|---|
| `overview.mdx` | [`overview/`](./overview/README.md) | explanation | **entry page** (hub) — the premise, and the route to the other eight |
| `four-actors.mdx` | [`four-actors/`](./four-actors/README.md) | explanation | the four motive-distinct actors and the boundaries between them |
| `glossary.md` | [`glossary/`](./glossary/README.md) | reference | every load-bearing term, in dependency order |
| `delegates-and-surfaces.mdx` | *not yet specified* | — | the actor/delegate pair and the four delegation surfaces |
| `faces-and-the-gate.mdx` | *not yet specified* | — | forward/backward faces and the two-axis gate |
| `variants.mdx` | *not yet specified* | — | membership gates, confirmed and forming variants |
| `positions-are-not-roles.mdx` | *not yet specified* | — | title-to-actor mapping |
| `scenarios.mdx` | *not yet specified* | — | the compressed and decoupled worked scenarios |
| `recursion.mdx` | *not yet specified* | — | the framework applied to product, process, and toolchain |

Three nodes are authored; six stand in the root spec's backfill gap. The three were chosen for
**doc-type coverage** rather than reading order — two explanation pages and one reference — because
several evaluation criteria are gated on the declared doc type and need both sides exercised.

## Section-level findings (unowned — no node covers these)

### The project spec's suite names an actor the model does not have

`artifacts/specs/motive-model/spec.md` names the first actor **Oracle** throughout — the actor table,
the boundaries, the glossary, the positions table. Its own frozen suite,
`artifacts/specs/motive-model/motive-model.feature`, names it **Director** at lines 24, 41, 50, 87,
102, and 108.

Every published page agrees with `spec.md`; the suite is the divergent artifact, and it diverges in
both Output 1 and Output 2 scenarios. A rename landed everywhere except the frozen suite that was
supposed to hold it. This is a change request against `artifacts/specs/motive-model/`, and a fix must
sweep all six lines rather than the one row that surfaced it.

The three nodes here were written to survive the drift either way: none of them asserts the literal
string. They assert name-agreement **with the project spec's body**, so settling the drift toward
`Oracle` leaves them passing.

### No detector reconciles a spec body against its own suite

The drift above survived because nothing looks for it. The repo has `check-spec-state` and
`check-scenario-overlap`, but neither compares the vocabulary a spec body defines against the
vocabulary its own `.feature` asserts. Six occurrences of a renamed actor outlived a rename that
reached the published articles.

### The website root spec is stale about this tree

`apps/website/.agents/spec/spec.md` still records `content/docs/agent-configuration/instruction-target/`
as the only node carrying a `.feature`, and its backfill-gap counts predate these three nodes. The
by-concept index also needs regenerating: these nodes introduce `motive-model` as a concept tag
spanning nine pages.
