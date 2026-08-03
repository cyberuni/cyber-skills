# workflows — the project-level suite

Whole-site usage flows: paths a reader takes **across** several capability nodes. A workflow is the
project-level analogue of a use case — where a node's use case is one entry point into one surface, a
workflow is one journey through the composed surfaces.

Empty at scaffold. Workflows are authored once enough nodes carry contracts to compose.

Candidate flows this site already supports, for whoever authors this folder:

- **land and orient** — a reader arrives at the root page, reads the introduction, and reaches
  installation (`content/` → `tooling/navigation/`)
- **find and install a skill** — a reader searches the marketplace, picks a skill, and copies its
  install command (`components/marketplace-search/` → `content/`)
- **follow a diagram-heavy explanation** — a reader opens an SDD page whose control flow is drawn as
  a Mermaid diagram and reads it in both light and dark themes (`content/` → `components/mermaid/` →
  `styles/`)
- **deep-link in** — a reader arrives from an external link at a page under the base path, with no
  sidebar context, and navigates outward (`tooling/site-config/` → `tooling/navigation/`)
