# article-writer-voice

Repo-internal skill. Loads whenever a session writes or polishes prose longer than a paragraph — blog posts, guides, release notes, READMEs, project docs — and supplies the tone rules so the voice stays consistent across sessions.

## Scope

The delivery layer: Tone — how the writing sounds — plus the Structure rules that carry it, emphasis and tables and term-then-definition. The skill does not decide what the piece is, what sections it has, or where it lands. When another skill owns the page — `create-web-doc` for a new website page, `sync-doc` for a concept doc tracking an ADR, the `quill` plugin for docs under a frozen suite — that skill still writes in this voice.

## Shape

Six unconditional rules, then two modes the writing specializes into:

- **Personal** — blog posts, opinion pieces, newsletter issues. Conversational and peer-to-peer.
- **Docs** — project documentation, READMEs, reference. Declarative, tables over paragraphs.

## Maintenance

The voice is specified operationally by the rules themselves, not by attribution to a sample corpus. Anything added here has to survive two tests: a model would not already do it unprompted, and swapping it for a different rule would change how the writing lands without changing what it concludes. The rules the skill shed — Diataxis shapes, format skeletons, an authoring process, a delivery section — failed one or the other.
