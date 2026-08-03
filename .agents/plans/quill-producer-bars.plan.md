---
cr-ref: quill-producer-bars
project: quill
project-path: plugins/quill
status: draft
todos:
  - content: "Extend the three agent definitions' load lists instead of replacing the SDD list"
    status: pending
  - content: "Add the spend-every-row-by-ID rule to the spec bar's completeness element"
    status: pending
  - content: "Add the one-namespace-per-node identifier rule"
    status: pending
  - content: "Join the doc-type table to the north-star element"
    status: pending
  - content: "Add the intra-node reconciliation duty after an edit"
    status: pending
  - content: "Reconcile the stale readme against the two-instrument model"
    status: pending
  - content: "Resolve the null spec-judge contradiction with the SDD plugin contract"
    status: pending
---

# CR quill-producer-bars — what dogfooding Quill on itself revealed about Quill

**Provenance.** Every item here was discovered by running Quill's own production chain over six
website pages documenting Quill (`quill-docs-section`). Nothing is speculative: each was found by a
producer or a cold judge during that mission, and the ones marked **measured** carry a recurrence
count across the six nodes.

**Why a separate CR.** `quill-docs-section` documents Quill; changing Quill inside it would mean the
mission edits its own subject mid-flight. Every item below was recorded as a follow-up there and
deliberately not fixed.

## The findings, ranked by what they cost

### 1. All three agents replace the SDD load list instead of extending it — **blocking, measured**

`quill-spec-writer` names its own Builder bar, the two format bars, and the ownership matrix, then
stops. `sdd:spec-producer-governance` requires the resolved **oracle**, **builder**, and
**architect** bars loaded **forward face**, so the producer self-aligns to the lens set it will be
graded against backward. `quill-doc-writer` and `quill-judge` carry the same omission on the impl
side, naming only the impl Builder bar and the ownership matrix.

**Measured cost.** Six of six cold spec-judges blocked at governance pre-flight. When the six nodes
were re-authored with the missing bars loaded, **six of six carried a real defect only those bars
caught** — and none were cosmetic:

| Defect | Caught by | Nodes |
|---|---|---|
| double-barreled north star (*name the outcome without "and"*) | oracle | 6 of 6 |
| a page documenting only the plugin half of a **union** bar, so a reader following it would write a conforming suite and still fail the gate | builder (sdd half) | 1 |
| a control-flow edge no scenario covered | builder (sdd half) | 2 |
| a decision node with a dead branch | architect | 1 |
| a lone negative with no positive companion | builder (sdd half) | 1 |
| link scenarios asserting a sibling's **prose** rather than its **ownership**, which break when the sibling is trimmed | oracle | 1 |

**The control that makes this conclusive:** the sibling plugin's agents name the full set, and so do
SDD's own defaults. The correct shape already exists in the corpus — this is a Quill defect, not a
gate defect.

**Fix:** extend, never replace. Each agent's load list names its own bar *in addition to* the roles
the SDD producer/judge procedure already requires.

### 2. The spec bar's completeness element does not require spending each row — **measured**

`quill-builder-spec` requires a completeness check ("the coverage list is complete when a document
meeting every row cannot still trip the north star's failure mode") but never says the argument must
**account for each row by ID**. Every instance below is the same shape: a summary claim quantifying
over members it does not actually cover.

| Passage | Quantifies over | What broke |
|---|---|---|
| completeness check *"a page meeting O1–O11"* | 12 rows | O8 never spent; O7a hidden inside the range |
| Use Cases intro *"every entry point ends at a destination"* | 6 entry points | two entry points named no leaf |
| completeness check *"closed by S6"* | a narrowed scenario | the node's own table said it was **not** closed |

Three instances across two nodes, and it was the **dominant regression class of the whole mission** —
each surfaced only after a *different* fix moved what the summary referenced.

**Fix:** the completeness argument must spend every coverage row by ID, and a row it does not spend
is a row nothing depends on and should be cut rather than left standing. One producer independently
invented this exact rule and wrote it into its own spec — the strongest possible evidence the bar is
missing it.

### 3. No identifier-namespace rule — **measured**

Two nodes independently shipped an ID collision: a CFG start node `S` colliding with use-case groups
`S1`/`S2` in the same scenario-map tables, and `B1` used for both a coverage row and a catalog entry.
Both were found only by a sweep, and one was introduced *by a remediation*.

**Fix:** a node's identifiers share one namespace — coverage rows, use-case groups, and CFG nodes may
not reuse a token. Reference enumerated items by name, never by an invented index.

### 4. The doc-type table is not joined to the north-star element

The bar's element 2 gives each doc type a "Success is" column; element 3 defines the north star
type-agnostically. A reference page's north star is a **retrieval** claim and a tutorial's is a
**capability** claim, and they grade differently — so a spec can declare `reference` and write an
explanation's north star with nothing catching it. Producers had to make this join themselves on
every node that declared `reference`.

**Fix:** state the join — the north star's shape follows from the declared doc type.

### 5. No intra-node reconciliation duty after an edit — **measured**

Four of four remediated nodes regressed in one round: every finding was *introduced* by the
remediation rather than surviving it. Three were the identical shape — the producer changed the claim
where the finding pointed and left the passages referencing it stale (a narrowed scenario left a
completeness argument asserting the old wider closure; a reworded step left the `.feature` **preamble**
carrying the original wording; a rewritten completeness argument stopped spending a row).

**Fix:** after changing a claim, reconcile every passage in the node that references it — the
completeness argument, the CFG and its labels, the scenario map, and the `.feature`'s **preamble and
section comments**, not only its scenarios. Report each check with its result, including "nothing":
an unreported sweep is indistinguishable from an unrun one.

**Caveat, learned the same way:** a sweep is not self-certifying. The one node piloted through it
caught five of six targeted items plus four unprompted defects, and still left one claim false. The
sweep reduces rounds; it does not replace the cold judge.

### 6. The plugin readme predates the current model

It still leads the integrity row with *"no claim landed twice"* — the recurrence rule the doc-eval
model **retracts** on measured grounds — classes all listed inter-passage defects as inspection when
the model's own correction makes three of them judged, documents no judged tier at all, and omits the
`governances` block entirely so a reader cannot learn the two bars are bound. That last omission is
what the website page turned into a positive false claim.

### 7. Quill contradicts the SDD plugin contract on `spec-judge: null`

Three Quill artifacts say the spec gate applies the documentation criteria itself with no judge
agent. The SDD plugin contract resolves an unfilled slot to the SDD default, and the spec gate spawns
the cold default judge unconditionally — as it did throughout this mission. One of the two is wrong.
The website contract was deliberately written to hold either way, so nothing blocks on the
resolution, but it cannot stay unresolved.

### 8. Smaller, recorded

- The glossary hard-codes the catalog entry count, coupling the ubiquitous language to a number the
  catalog will move.
- The doc-eval model's instrument table gives the judged instrument's scope as *one check per
  document*, undercounting a tier that carries one inspection rule **plus** the whole catalog.
- The calibration table admits only `advisory` and `calibrated`, so an entry that **ran and never
  fired** — which the prose says is untested, not calibrated — has no representable state.
- `init-quill`'s reject-a-missing-`governances`-block rule has no reachable trigger: the skill
  constructs the only payload it ever writes, and writes the block itself.
- The spec bar requires every entry point to trace to a coverage row but never flags a **coverage row
  no entry point reaches**, though it carries the symmetric rule for audiences and for
  coverage-vs-scenarios.

## Sequencing

Item 1 first and alone — it is the only one that changes what every future Quill spec is graded
against, and items 2–5 are bar edits whose effect is only observable once producers actually load the
bars. Items 6–8 are corrections to shipped prose and can ride together.

## NEXT

Open this CR against `.agents/specs/quill/`. Item 1 is a three-line change across
`plugins/quill/agents/*.md`; items 2–5 are edits to `quill-builder-spec` and `quill-builder-impl`.
