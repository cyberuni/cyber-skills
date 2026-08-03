Feature: quill/doc-eval-model — how Quill decides a document is correct

  Every scenario below concerns one document: apps/website/src/content/docs/quill/doc-eval-model.md,
  published at /quill/doc-eval-model/. "The page" names that document throughout, and each scenario
  is settled by static inspection of it.

  The page argues one thing: Quill's two instruments are separated by how a verdict is reached —
  inspection compares two structured artifacts and returns a boolean, judgment simulates a reader and
  returns a graded finding — and a reader who has the criterion can place a concern they arrived with
  without being handed an inventory. Two readers arrive: one deciding whether to adopt the gate, one
  deciding where a concern of theirs belongs.

  Scenarios assert the claims the page must land and the reader questions it must route. They freeze
  no section order, no wording, no example, and no count. Where a claim is load-bearing on both
  arrivals, it is asserted against the reader's paths rather than against a place count.

  # ── D1 — Decide whether the gate can block without becoming a style argument ──

  Scenario: the page separates the instruments by what decides the verdict
    Given a reader weighing whether to put this gate in front of their documentation
    When the page's treatment of the two instruments is read
    Then it states that inspection decides by comparing two structured artifacts or matching a pattern
    And it states that judgment decides by simulating a reader
    And it states that the split is by how a verdict is reached
    And it states that the split is not by which file or bar a criterion is written in

  Scenario: the page pairs each instrument with the verdict it yields
    Given a reader who has accepted that the instruments differ by how a verdict is reached
    When the page's treatment of the two instruments is read
    Then it states that inspection yields a boolean and that a failure blocks
    And it states that judgment yields a graded finding
    And it presents each verdict shape as following from how that verdict is reached
    And it gives the reason craft is judged rather than linted: a decision procedure cannot weigh many reader expectations at once

  Scenario: the page bars style at both instruments, not only at the boolean one
    Given a reader who expects a documentation gate to hold opinions about prose
    When the page's statement of what is out of scope is read
    Then it names tone, register, length, word choice, and section order as things neither instrument asserts
    And it states that the bar holds at the judged instrument as well as at the inspection one

  Scenario: the style bar is reachable from both reader arrivals
    Given a reader who arrives to decide whether to adopt the gate
    And a reader who arrives to place a concern of their own
    When each follows the route the page gives their arrival
    Then each route passes through a statement that tone, register, length, word choice, and section order are unassertable
    And neither route has to leave the page to reach it

  Scenario: the page states that a judged entry does not block until it is calibrated
    Given a reader asking what the graded instrument can fail their build on today
    When the page's treatment of the judged instrument's standing is read
    Then it states that an entry does not block until it has been calibrated
    And it glosses calibration as running the entry against documents the repository already accepts and already considers weak
    And it states why the asymmetry is deliberate: a miss ships a weak paragraph, while a false positive teaches the producer to route around the judge
    And it links the page that records the current standing of each catalog entry
    And it does not state the standing of any entry itself

  # ── D2 — Decide whether their own subject is in scope ──

  Scenario: the page states what puts an artifact inside Quill's lens
    Given a reader holding an artifact and asking whether Quill applies to it
    When the page's statement of fit is read
    Then it states that Quill applies to artifacts whose correctness is structurally checkable
    And it names a declared path and required sections as the surface that makes it so
    And it names a reader flow as additionally required for a guide or tutorial

  Scenario: the page routes a subject outside the lens to the SDD default
    Given a reader whose subject has no inspectable document surface
    When the page's statement of fit is read
    Then it states that such a subject is outside Quill's lens
    And it states that the subject recuses to the SDD-default builder
    And it does not offer a reduced or partial Quill grading for that subject

  # ── D3 — Decide what a green run lets them claim ──

  Scenario: the page states what a run with no findings does not certify
    Given a reader about to report a clean run to someone who will act on it
    When the page's treatment of what the judged instrument detects is read
    Then it states that the instrument detects defects and does not certify quality
    And it states that a document with zero findings is not thereby certified well written
    And it gives the reason: good prose is unbounded and cannot be enumerated, while bad prose recurs in a small number of nameable shapes

  # ── S1 — Decide what a scenario may assert ──

  Scenario: the page names the four scenario-scoped checks and what each verifies
    Given an author choosing what a documentation scenario will assert
    When the page's treatment of the scenario-scoped checks is read
    Then it states that the existence check verifies the target is at its declared project-root-relative path
    And it states that the structure check verifies the headings the scenario names are present
    And it states that the completeness check verifies there is no placeholder text and no empty section
    And it states that the reader-path check verifies a sequential flow reaches its stated outcome with every step present and no undeclared external prerequisite

  Scenario: the page states that a concern none of the four checks settles is not scenario material
    Given an author holding a concern that none of the four checks settles
    When the page's treatment of the scenario-scoped checks is read
    Then it states that every scenario a documentation feature file carries must be checkable by one of the four
    And it states that a concern none of them settles does not belong in the suite

  # ── S2 — Find out what happens to a concern no scenario can hold ──

  Scenario: the page states why a scenario-scoped check cannot reach a relation between passages
    Given an author whose concern is a relation between two passages that are each well-formed alone
    When the page's treatment of the document-scoped pass is read
    Then it states that each of the four checks reads only the passage its scenario names
    And it states that each occurrence of such a defect is well-formed against its own scenario
    And it states that it is the pair, rather than either occurrence, that fails

  Scenario: the page states why another scenario is not the fix
    Given an author about to write one scenario per pair of passages
    When the page's treatment of the document-scoped pass is read
    Then it states that a scenario per pair does not scale
    And it states that such scenarios would freeze document structure a documentation spec must never freeze
    And it links the page that owns what a documentation spec must never freeze, rather than restating what that is

  Scenario: the page gives the criterion that routes a between-passage concern
    Given an author deciding which instrument a between-passage concern belongs to
    When the page's treatment of the document-scoped pass is read
    Then it states that a concern whose two sides are both structured and enumerable is settled by comparison
    And it states that a concern whose decision requires reading as a reader is judged
    And it names a route omitting an option the document itself enumerated as the case comparison settles
    And it names at least one case that reads as comparable but requires reading as a reader

  Scenario: the page states why the judged criteria were once misclassified as inspection
    Given an author who reads a citation requirement as evidence that a criterion is mechanical
    When the page's treatment of the document-scoped pass is read
    Then it states that these criteria were once classed as inspection because evidence-with-citation made them feel mechanical
    And it states that the citation requirement disciplines a finding rather than deciding one

  Scenario: the page reaches the owning pages by link instead of developing their content
    Given an author wanting the enumeration rule's wording and the defect catalog's entries
    When the page is read end to end
    Then the enumeration rule's content is reached by a link to the page that owns it
    And the defect catalog's entries, their near-misses, and the citation each group owes are reached by a link to the page that owns them
    And the calibration procedure's steps and scoring are reached by a link to the page that owns them
    And what a judged pass receives and does — including what a calibrated entry blocks on — is reached by a link to the page that owns it
    And none of those is enumerated or restated on this page in place of its link

  # ── S3 — Decide whether to penalize a claim that appears twice ──

  Scenario: the page lands the retraction rather than the retracted rule
    Given an author who has found the same claim landed in two sections
    When the page's treatment of recurrence is read
    Then it states that an earlier revision of the model held a claim landed in two passages to be a defect
    And it states that the rule is retracted
    And it states that a claim may recur

  Scenario: the page states what the measured comprehension cost attaches to
    Given an author asking what the evidence behind the retraction actually showed
    When the page's treatment of recurrence is read
    Then it states that the measured cost attaches to a passage whose given information has no retrievable antecedent
    And it states that the cost does not attach to a claim appearing twice
    And it attributes that finding to a cited source rather than asserting it

  Scenario: the page names the retracted rule's own fix as the worse defect
    Given an author about to replace a repeated statement with a pointer to the first one
    When the page's treatment of recurrence is read
    Then it states that the retracted rule prescribed replacing the later statement with a pointer
    And it states that a pointer standing where the reader needs the content now is the worse defect
    And it gives the reason: such a pointer guarantees the bridging cost that recurrence only risked

  Scenario: the page gives the checkable question that replaces the retracted rule
    Given an author who still wants a rule to apply to a repeated claim
    When the page's treatment of recurrence is read
    Then it states that the right amount of redundancy is relative to the audience and reverses between audiences
    And it states that low-knowledge readers gain from explicit, redundant text where high-knowledge readers do better with gaps
    And it states that the checkable question is agreement with the spec's declared audience and prerequisites
    And it states that the checkable question is never quantity

  # ── S4 — Understand how a judged finding arrives, and what to do with one ──

  Scenario: the page states that the judged pass reads blind before it scores
    Given an author who has received an advisory finding on a document they wrote
    When the page's treatment of how a judged pass runs is read
    Then it states that the reading pass runs blind, with the catalog withheld until the reading is done
    And it states that the scoring happens afterward, against that reading
    And it gives the reason: a judge shown the catalog before reading finds what it was told to find, making the finding an opinion about prose rather than evidence about a reader
    And it links the page that owns what the blind pass receives and how the scoring runs

  Scenario: the page states that a judged finding can be defended as a deliberate violation
    Given an author who violated an expectation about prose on purpose
    When the page's treatment of deliberate violation is read
    Then it states that the producer may mark a finding intentional with a rationale
    And it states that the judge must weigh that rationale before reporting
    And it gives the reason the concession is required: any expectation about prose may be violated to good effect, so a catalog with no defense path would be a style guide with a gate attached
    And it links the page that owns how a deliberate violation is declared

  Scenario: the page states what makes a finding reportable at either instrument
    Given an author checking whether a finding reported against their document is checkable
    When the page's treatment of evidence is read
    Then it states that a failure must quote both locations
    And it states that each citation must name where it came from, not only what it said
    And it gives the reason: a quote can be accurate and misattributed, and reads as verified precisely because the words check out
    And it states that the two locations must be confirmed distinct, since a relation between passages cannot be evidenced by one passage read twice
    And it states that the requirement holds at the judged instrument as well as at the inspection one
