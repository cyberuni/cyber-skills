# design — the rules and the model

The **rules** home for the `website` project: the model and the *why*, as descriptive docs. Behavior
that enacts a rule lives in the capability node, not here — rules and the scenarios enacting them
live apart, so this folder stays readable as a model while the nodes stay testable as behavior.

Empty at scaffold. Rules are written as explore surfaces them.

What belongs here:

- a **content style rule** the corpus is held to (voice, page shape, when a page earns its own slug)
- an **information-architecture principle** the sidebar is derived from
- a **theming model** — how Starlight tokens, Tailwind utilities, and `global.css` divide
  responsibility
- any cross-node model a reader needs before the node contracts make sense

What does not:

- a **decision plus its rationale** → [`decisions/`](./decisions/README.md)
- **behavior** — scenarios go to the node that owns the surface
- **term definitions** → [`../glossary.md`](../glossary.md)
