@frozen
Feature: quill/init-quill — registering Quill in a project

  Specifies the document at src/content/docs/quill/init-quill.md, published at /quill/init-quill/.

  A how-to. The reader already wants Quill registered; the single outcome is verified registration —
  the registration set off, and an entry in their own .agents/universal-plugin.json they can point
  at. The scenarios therefore check the procedure's followability and every path where the attempt
  does not simply succeed, alongside the shape of the entry a reader compares against.

  Two things this page must not become a second home for: the list of artifact-types Quill claims,
  and the table of which role and governance bindings it fills. Both live on sibling pages and both
  would force the same edit in two places when they move. The scenarios assert the fields and the
  null-means-default rule, and require the memberships to be reached by link.

  They freeze no section order, no wording, and no example. Where the page must show the registry
  entry, the scenarios require an example of that kind, never a particular rendering of it. What a
  bound agent does, what the checks verify, and what any bar requires belong to sibling pages; the
  scenarios assert that those are reached by link and not developed here. The redirect stays
  generic and quantifies over no set of bars — a preamble that counts them is the binding census
  again, in the one place a reader takes for context rather than contract.

  # ── R1 — Register Quill for the first time ──

  Scenario: the steps assume nothing the prerequisites did not declare
    Given a reader who has read the page's stated prerequisites and nothing else
    When the steps are followed in order
    Then every file, tool, and term a step requires is either named in the prerequisites or introduced on the page
    And no step directs the reader to read another page before continuing

  Scenario: the page names what to run and what it writes
    Given a reader who has installed Quill and has come to register it
    When the page is read from the top
    Then it names the skill that performs the registration
    And it gives at least one way a reader can set that skill off
    And it names .agents/universal-plugin.json as the file the registration writes

  Scenario: the page states what the registration changes on disk
    Given a reader deciding whether to run the registration against their project
    When the page's account of what the registration does is read
    Then it states that the registry file at the project root is found, or created when absent
    And it states that the entry is stamped with Quill's own version
    And it states that the entry is written into the sdd-plugins array
    And it states that the file is written back with the updated contents

  Scenario: every step in the procedure carries its own content
    Given a reader following the page's procedure in order
    When each step of that procedure is read
    Then each step states the action to take or the change it makes
    And no step defers its own content to another page

  # ── R2 — Recover from a run that stopped ──

  Scenario: the page tells the two stop causes apart
    Given a reader whose registration reported an error instead of finishing
    When the page's account of the ways the registration stops is read
    Then it distinguishes the cases by what caused each, rather than by the message shown
    And it names, for each case, the change the reader makes before re-running

  Scenario: a registry that does not parse stops the run and leaves the file alone
    Given a reader whose .agents/universal-plugin.json exists but contains malformed JSON
    When the page's account of that case is read
    Then it states that the registration stops with an error
    And it states that the existing file is left unmodified
    And it states that overwriting it could destroy an entry belonging to another plugin
    And it names repairing the file by hand as what unblocks the reader

  Scenario: a squad missing its governances block is rejected before anything is written
    Given a reader whose payload carries a squad with no governances block
    When the page's account of that case is read
    Then it states that the registration is rejected
    And it states that the registry file is not written
    And it states that a binding inside the block may be null while the block itself must be present

  # ── R3 — Take the next step ──

  Scenario: the page ends by naming the reader's next step
    Given a reader whose registration has landed
    When the page's closing guidance is read
    Then it names starting a documentation mission as the next thing to do
    And it states that the conductor resolves the Quill roles from the registry without further setup
    And it links the page that owns starting a mission

  # ── V1 — Confirm the project is really registered ──

  Scenario: the page names what to look for to confirm the entry is present
    Given a reader who has run the registration and wants evidence in the file rather than a report
    When the page's confirmation guidance is read
    Then it names the sdd-plugins array in .agents/universal-plugin.json as where the reader looks
    And it states that the entry carries a version stamp
    And it names the squad's artifact-types field as part of what the reader checks
    And it reaches the list of artifact-types Quill claims by a link rather than enumerating them

  Scenario: the page shows the entry as one squad with its three parts
    Given a reader comparing their own registry entry against a complete one
    When the page's presentation of the entry is read
    Then it shows an example of the entry as it sits inside the sdd-plugins array
    And that example holds one squad
    And that squad carries its artifact-types, its roles block, and its governances block

  # ── V2 — Re-run over an entry that already exists ──

  Scenario: re-running rewrites the existing entry rather than appending another
    Given a reader whose project already carries a Quill entry written by an earlier version
    When the page's account of re-running is read
    Then it states that an existing Quill entry is rewritten in place
    And it states that no second Quill entry is added alongside it
    And it states that an entry in an older shape is migrated by that rewrite
    And it states that an entry whose recorded version differs from Quill's own is rewritten

  Scenario: other plugins' entries are stated to be left untouched
    Given a reader whose registry already registers a different SDD plugin
    When the page's account of re-running is read
    Then it states that entries other than Quill's are not modified
    And it states that entries other than Quill's are not reordered

  # ── V3 — Read what the entry binds ──

  Scenario: the roles block is presented with what a null binding means
    Given a reader looking at the roles block and at a binding whose value is null
    When the page's account of that block is read
    Then it states that the block carries the SDD production-chain role keys
    And it states that each key holds either a bound agent or null
    And it states that a null binding means the SDD default is used for that role
    And it reaches what a bound agent does by a link rather than describing it

  Scenario: the governances block is not presented as unbound
    Given a reader who expects Quill to rely on the SDD default bars throughout
    When the page's account of the governances block is read
    Then it states that the block is required on every squad
    And it states that a null binding falls back to the SDD default bar for that slot
    And it states that Quill does not leave every governance binding null
    And it reaches which bindings Quill fills by a link rather than reproducing that table
    And where it names a bar at all, it links the page owning that bar rather than stating what the bar requires

  Scenario: the page links the owning page instead of developing the binding
    Given a reader who wants to know what a bound agent does, what the checks verify, or what a bar requires
    When the page is read
    Then each of those topics is reached by a link to the page that owns it
    And none of them is developed on this page in place of that link

  Scenario: the block descriptions are reachable from both arrivals
    Given a reader who has just completed a first-time registration and is checking the entry is complete
    And a reader who arrived to audit an entry that already existed
    When each follows the route the page gives their arrival
    Then each route reaches the page's description of the squad's blocks
    And neither route requires the reader to read the other's section first
