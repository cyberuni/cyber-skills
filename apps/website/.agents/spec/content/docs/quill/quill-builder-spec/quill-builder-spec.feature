@frozen
Feature: quill/quill-builder-spec — the spec-gate Builder bar reference page

  The reference page at src/content/docs/quill/quill-builder-spec.md, published at
  /quill/quill-builder-spec/. It is the public surface of record for Quill's Builder bar at the
  spec gate: what a documentation spec must contain, and what it must never freeze.

  Three readers arrive holding a lookup — an author filling a spec, a reviewer citing a
  requirement a spec failed, and a document author checking whether an edit can break a frozen
  contract. Because it is a reference page, each requirement must stand on its own where the
  reader lands on it.

  Scenarios assert the claims the page must land, the reader paths it must route, and the
  discriminators it must state. They freeze no section order, no wording, no heading, no chosen
  example, and no tone. Where the page's own source retracted an earlier rule, the scenarios
  assert the retraction and its ground, never the retracted rule.

  Every Then here is settleable by reading the one passage its scenario names. Two whole-document
  guarantees are deliberately out of this suite and belong to the document-scoped pass; the
  spec's Completeness check names them.

  # ── P1 — Find out what a doc spec must contain ──

  Scenario: the reference page exists at its declared path
    Given a reader following a link to the spec-gate Builder bar
    When the site is inspected
    Then a page exists at src/content/docs/quill/quill-builder-spec.md

  Scenario: the page states which actor and which gate this bar belongs to
    Given a reader who knows Quill ships two Builder bars and is unsure which this one is
    When the page's statement of its own scope is read
    Then it states that this is the Builder actor's bar
    And it states that it applies at the spec gate rather than the impl gate
    And it links the page that owns the impl-gate bar

  Scenario: the page states that the bar unions onto the generic builder bar rather than replacing it
    Given a reader who expects this page to carry the whole contract a documentation spec is graded on
    When the page's statement of its own scope is read
    Then it states that this bar unions onto the generic SDD builder-spec bar
    And it states that the generic testability and coverage requirements still apply
    And it does not restate those generic requirements in place of naming them

  Scenario: the page states the two directions the bar is read in
    Given a reader who does not know whether this bar is an authoring aid or a grading standard
    When the page's statement of how the bar is used is read
    Then it states that the spec-producer role reads the bar forward while authoring a spec
    And it states that the gate reads the same bar backward while grading that spec
    And it states that this is why each requirement is given with the condition that decides it

  Scenario: the page enumerates the seven required elements of the What section
    Given an author starting the What section of a documentation spec
    When the page's treatment of that section is inspected
    Then it names an audience table as required
    And it names a declared doc type as required
    And it names a north star as required
    And it names a statement of why the document exists as required
    And it names a required-coverage list as required
    And it names non-goals as required
    And it names prerequisites as required

  Scenario: the page requires an audience row to name a role and a goal
    Given an author writing the audience element
    When the page's audience requirement is read
    Then it states that an audience is given as a table rather than a phrase
    And it states that each row names a role together with what that role is trying to accomplish
    And it gives at least one example of a phrase that fails as an audience
    And it states why such a phrase fails: it names no goal, so nothing about the document follows from it
    And it states that the audience list is written before the coverage list and the use cases, which are derived from it

  Scenario: the page states that an audience with no reader entry point is not an audience
    Given an author whose audience table lists a row that no reader entry point serves
    When the page's audience requirement is read
    Then it states that such a row fails as an audience
    And it states that a row carrying at least one reader entry point stands as an audience
    And it names adding a reader entry point as one remedy
    And it names cutting the row as the other remedy

  Scenario: the page treats opposite needs on one fact as a decision to be recorded
    Given an author whose two audiences need opposite things from the same fact
    When the page's audience requirement is read
    Then it states that this is a signal to decide between one document and two
    And it states that the decision must be recorded whichever way it goes
    And it states that leaving the case undecided is what fails

  Scenario: the page requires a north star to carry a failure mode
    Given an author writing the north star element
    When the page's north-star requirement is read
    Then it states that the north star names what the reader leaves with
    And it states that it must carry a concrete reader state that would mean the document missed
    And it states that a north star without such a state grades nothing

  Scenario: the page routes a document whose purpose restates its title
    Given an author who cannot state the problem the document resolves without restating its title
    When the page's requirement on why a document exists is read
    Then it directs that case to be stated outright rather than papered over
    And it states the consequence being surfaced: the document may not need to exist separately from its parent
    And it directs a problem that can be stated independently to be stated in the domain's own terms

  Scenario: the page states the drop test for a key point
    Given an author writing the required-coverage list
    When the page's requirement on key points is read
    Then it states that each row is a claim the document must land rather than a section name
    And it states the test as whether a reader would be worse off if the row were dropped and the document left unchanged
    And it states that a row failing that test is cut
    And it states that each row must be checkable by static inspection, linking the page that owns what those checks verify

  Scenario: the page states when a coverage list is complete
    Given an author whose coverage list is written but not yet checked for completeness
    When the page's completeness requirement is read
    Then it states that the list is complete when a document meeting every row cannot still trip the north star's failure mode
    And it states that if such a document could still trip it, a key point is missing

  Scenario: the page requires a non-goal to carry a forwarding address
    Given an author writing the non-goals element
    When the page's non-goal requirement is read
    Then it states that each exclusion names where that material lives instead
    And it states that an exclusion with no forwarding address reads as an omission rather than a decision

  Scenario: the page requires prerequisites to name the document that supplies them
    Given an author writing the prerequisites element
    When the page's prerequisite requirement is read
    Then it states that prerequisites name what a reader must already know
    And it states that each names which document supplies it
    And it states that a document claiming to be self-contained declares that explicitly

  Scenario: the page requires reader entry points grouped by audience
    Given an author writing the use-case section of a documentation spec
    When the page's requirement on that section is read
    Then it states that each row is one way a reader arrives
    And it states that a row gives the trigger, what the reader brings, and what they leave with
    And it states that the rows are grouped under their audience
    And it states that every audience carries at least one entry point
    And it states that every entry point traces to a coverage row that serves it

  # ── P2 — Settle which doc type this document is ──

  Scenario: the page routes a document to its type by what the reader is doing
    Given an author who knows the document's subject but not which of the four types it is
    When the page's doc-type requirement is read
    Then it directs a reader doing something for the first time and learning by doing to the tutorial type
    And it directs a reader accomplishing a goal they already understand to the how-to type
    And it directs a reader looking one thing up to the reference type
    And it directs a reader building understanding rather than doing a task to the explanation type
    And it states, for each of the four, what counts as success
    And it states that mixing types in one document is a common structural defect

  # ── P3 — Draw the control flow without drawing the table of contents ──

  Scenario: the page distinguishes the reader's decision path from the table of contents
    Given an author at the control-flow section holding the document's list of sections
    When the page's control-flow requirement is read
    Then it states that the graph draws the questions the document must answer to route a reader
    And it states that a list of the document's sections is not a control-flow graph
    And it states the difference: a section list records what was written, while the graph records what a reader needs and in what order
    And it presents branching first on which audience the reader is as the default where several audiences are served

  Scenario: the page routes a disjunction by the kind of node it sits in
    Given an author holding a control-flow node that offers the reader two options
    When the page's requirement on disjunctions is read
    Then it directs a disjunction sitting in a decision node to be kept, on the ground that a decision node is a question
    And it directs a disjunction sitting in an outcome node to be promoted to a decision node with the criterion on its edges
    And it states the consequence of leaving it in an outcome node: the reader is left needing to choose with no criterion to choose on

  Scenario: the page treats an unrouted option as a gap rather than a simplification
    Given an author whose route omits a member of a set the spec's own coverage list names
    When the page's requirement on routing coverage is read
    Then it states that the omitted member is a gap rather than a simplification
    And it names routing to the option as one remedy
    And it names stating why the option is excluded as the other remedy

  # ── P4 — Write a scenario that tests the route rather than ratifying it ──

  Scenario: the page binds every coverage row to at least one scenario
    Given an author binding the coverage list to the suite
    When the page's requirement on the scenario map is read
    Then it states that the map is one-to-one with the suite
    And it states that every coverage row is reachable from at least one scenario
    And it states that a coverage row no scenario checks is unenforced

  Scenario: the page names what the other half of the union bar still requires
    Given an author who has satisfied every requirement this page states and believes the suite is finished
    When the page's treatment of the generic bar it unions onto is read
    Then it states that every edge of the spec's control flow carries a scenario
    And it states that every guard or negative edge is paired with a positive companion
    And it states that every scenario asserts an observable boolean outcome
    And it links the governance that owns those requirements rather than deriving them here

  Scenario: the page directs a shared claim to be asserted against the reader's paths
    Given an author whose coverage row is load-bearing in several passages of the document
    When the page's requirement on asserting such a claim is read
    Then it states that an assertion that the document merely states the claim is satisfied wherever the claim lands
    And it directs the claim to be required on each path the control flow routes a reader to it
    And it states that this freezes no wording, no section order, and no count

  Scenario: the page requires a routing scenario to assert what decides
    Given an author writing a scenario for a case the document routes across a set of options
    When the page's requirement on routing scenarios is read
    Then it directs the assertion to name what decides which option a case takes
    And it states that an assertion naming only where the case lands passes whether or not that destination is the right one
    And it states the consequence: the suite ratifies the route the draft took instead of testing it
    And it states that a destination-only assertion is worth writing only where the set has one member

  # ── P5 — Find out whether this bar applies at all ──

  Scenario: the page routes a subject by whether it has an inspectable document surface
    Given an author whose artifact carries prose but may not be a document
    When the page's statement of what this bar applies to is read
    Then it directs a subject with a declared path and required sections to be graded under this bar
    And it directs a subject with no inspectable document surface to recuse to the SDD-default chain
    And it states that carrying prose does not by itself make an artifact a documentation subject

  Scenario: the page reaches what it does not own by link
    Given a reader wanting the impl-gate bar, what the static checks verify, or which agent fills the spec-producer role
    When the page is read
    Then each of those topics is reached by a link to the page that owns it
    And none of them is developed on this page in place of that link

  # ── R1 — Cite the requirement an element failed ──

  Scenario: a reader reaches one requirement without reading the page through
    Given a reviewer arriving from a gate verdict that cites one element
    When the page's structure is inspected
    Then each requirement sits under a heading naming the element it governs
    And each requirement is stated where the heading leads, rather than by a pointer to another passage
    And each requirement defines or links every term it depends on at the point where it uses it

  Scenario: every requirement is stated with the condition that makes it pass
    Given a reviewer who needs the condition an element missed rather than the element's name
    When each required element on the page is inspected
    Then each carries a condition that decides whether it passes
    And no element is given as a name alone

  # ── R2 — Decide what to do about an element that is simply absent ──

  Scenario: the page states that a missing element is returned rather than guessed
    Given a reviewer looking at a documentation spec that has no audience table
    When the page's treatment of a missing element is read
    Then it states that a missing audience, doc type, north star, or coverage table is returned as a content gap for the user to settle
    And it states that the audience is not inferred from the document's existing prose
    And it states why: inferring launders whatever audience the draft happens to serve into the contract

  # ── R3 — Check that the requirement is graded from the spec, not the draft ──

  Scenario: the page states that routing coverage is checked against the spec, not the draft
    Given a reviewer grading a route with the document open alongside the spec
    When the page's requirement on routing coverage is read
    Then it states that the check is made against the spec rather than against the document
    And it states why: at the spec gate the document may not exist yet
    And it states the cost of grading against the draft: the draft's omissions become the contract

  # ── F1 — Find out whether an edit can break the contract ──

  Scenario: the page enumerates what a documentation spec never freezes
    Given an author revising a published document that is under a frozen spec
    When the page's list of what is never frozen is inspected
    Then it names the order of the document's sections
    And it names wording, phrasing, and headings
    And it names which specific examples are used
    And it names length, tone, and voice

  Scenario: the page states what the spec does freeze, in one rule
    Given an author who has read what is not frozen and needs to know what is
    When the page's statement of what the contract covers is read
    Then it states that the claims the document must land are frozen
    And it states that the paths a reader takes to reach those claims are frozen
    And it states that an example is asserted by the kind of example required, rather than by which example is used
    And it states the rule in one line: freeze the claims and the reader's path, and leave the prose to the author

  # ── F2 — Find out why the prohibition exists ──

  Scenario: the page names the cost that freezing prose would buy
    Given an author who suspects the spec is under-specified because it does not pin the wording
    When the page's ground for the prohibition is read
    Then it states that a spec freezing order, wording, examples, or tone breaks on every honest revision while catching no real defect
    And it names that outcome as the failure mode that makes teams abandon documentation specs
    And it states that a reordering that serves readers better must not fail the gate

  # ── F3 — Check a rule they remember against what the bar now says ──

  Scenario: the page presents the place-count rule as retracted, with the ground for the retraction
    Given an author applying an earlier revision's rule that a claim be stated in exactly one place
    When the page's treatment of a claim appearing in several passages is read
    Then it marks the place-count rule as retracted rather than current
    And it states that recurrence has no empirical warrant as a defect
    And it states that the count gets its driving case backwards, because a reader arriving at a later section has not read the lead
    And that same passage states no requirement fixing how many places a claim may appear in
