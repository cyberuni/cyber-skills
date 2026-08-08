---
"cyber-sdd": patch
---

verify-scenarios: bind a scenario whose test title differs only by punctuation or whitespace

A curly apostrophe pasted where the frozen `.feature` has a straight one used to land the same
scenario in BOTH the UNBOUND list and the EXTRA list, with nothing saying the two were the same
binding — so a real signal read as an unbound scenario and got hand-judged at every impl gate. The
fold now retries an unmatched key against unclaimed results on a punctuation- and whitespace-folded
comparison key (curly quotes/apostrophes, dashes, ellipsis), and reports the bind as a **probable
title mismatch** naming both verbatim titles so the typo still gets fixed. Titles are never
rewritten, an exact match always wins, case is not folded, and an ambiguous fold stays UNBOUND.

Closes #312.
