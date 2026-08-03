---
description: Write a post, guide, README, or release note in the article-writer voice — briefs the article-writer subagent and returns the draft.
---

Gateway to the `article-writer` subagent. Take the writing request, brief the subagent, return what
it produces.

**Do not load `article-writer-voice` into this session, and do not adopt it as a standing
instruction.** The voice governs a produced artifact; this conversation is not one. Adopting it here
is what makes it bleed into replies — it becomes a scope statement made once, competing against every
reply that accumulates after it. The subagent preloads the skill in its own context, which is where
it belongs.

## The request

$ARGUMENTS

## What to do

1. **Read the request.** If it names the piece and carries enough to write it, go to step 3.

2. **Ask only what would change the draft.** The subagent cannot ask anything once it starts, so
   whatever is genuinely undecided has to be settled here. Ask about at most two things, in one
   message, and only when you cannot settle them yourself:

   - **What it is and who reads it** — a release note for existing users and a tutorial for newcomers
     are different pieces, not different tones.
   - **The takeaway** — the one thing the reader should leave with. If the request implies it
     clearly, take it and say so rather than asking.
   - **Where it goes** — a file path, or inline. Check the repo first; if the destination is obvious
     from the request (an existing README, a docs page), name it rather than asking.

   Do not ask about register, structure, or length. Register follows from audience and destination,
   and the voice skill settles the rest — asking makes the user do the subagent's inference.

3. **Brief the subagent.** Dispatch `article-writer` with everything it needs, because it starts
   blank and inherits nothing from this conversation:

   - what the piece is, who reads it, and the takeaway
   - the destination path, or that the draft comes back inline
   - **the source material** — paths to the notes, transcript, existing draft, or code it should work
     from. Name the files; do not paste their contents and do not summarize them.
   - anything the user settled explicitly, marked as settled so the subagent does not re-derive it
   - what is out of scope, if the request has an edge worth naming

4. **Return what came back.** The draft is the deliverable.

   - It wrote a file — give the path and relay its declared assumptions.
   - It returned inline — relay the draft.
   - It left `[NEEDS FACT: …]` markers — surface them as the first thing the user sees. They are
     places it refused to invent, and they need a human answer.

   Relay its assumptions rather than burying them. It inferred register, audience, and takeaway from
   the brief, and a wrong inference is cheapest to catch before the next revision.

## If the user wants a revision

Dispatch again with the same completeness — the new subagent has not seen the previous draft. Name
the file it wrote, what to change, and what to leave alone.

Do not edit the draft in this session to save a round trip. Editing it here means editing it without
the voice skill, which is how a draft drifts out of the voice it was written in.
