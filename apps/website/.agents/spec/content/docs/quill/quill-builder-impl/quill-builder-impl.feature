Feature: quill/quill-builder-impl — the impl-gate Builder bar reference

  A reference page, consulted one item at a time. Its reader arrives holding a single lookup —
  a criterion, a citation rule, an entry's standing, or the calibration procedure — so the
  scenarios assert that each criterion is retrievable with everything needed to use it: what
  fires it, the near-miss that must not, the citation its group owes, and whether it blocks.

  The page is at src/content/docs/quill/quill-builder-impl.md, project-root-relative to the
  website project. Scenarios assert the claims the page must land and the lookups it must
  route. They freeze neither section order nor wording, and they assert no example verbatim.

  One distinction is load-bearing and is asserted twice from different arrivals: recurrence is
  retracted, and the entry that survived it fires on new-information marking rather than on the
  restatement itself.

  # ── W1 — Read the bar forward before the gate ──

  Scenario: the page identifies the bar by actor, gate, and scope
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And an author whose frozen scenarios all pass, arriving at the page for the first time
    When the passage introducing the bar is read
    Then it names the Builder actor and the impl gate as the bar's position
    And it states that the bar runs once per document rather than once per scenario
    And it states that the bar unions onto the generic conformance bar rather than replacing it
    And it states that each criterion is a relation between two passages

  Scenario: the page states what the bar carries and links for the split's rationale
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reader who landed on the page directly and is not yet holding a criterion
    When the passage naming what the bar contains is read
    Then it states that the bar carries one enumeration rule and a catalog of nine entries
    And it links the page that owns the two-instrument split
    And it does not argue that split in place of the link

  Scenario: the page states the enumeration rule and what reporting it must cite
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reader looking up the bar's one enumeration rule by name
    When the enumeration rule is read
    Then it states that a route must reach every option the document itself named
    And it states that an option absent from the routing is a defect rather than a simplification
    And it requires a report to cite the passage enumerating the set and the routing that skips a member

  Scenario: the catalog is presented as three groups named by what the defect does to a reader
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reader who has reached the judged instrument
    When the catalog is read
    Then it presents nine entries
    And it groups them by what the defect does to a reader
    And it names one group for what the reader cannot retrieve
    And it names one group for what misrepresents what the reader already has
    And it names one group for where the document disagrees with its own spec

  # ── W2 — Test a finding against its near-miss ──

  Scenario: group A names its three entries and what each fires on
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And an author whose passage was reported to assume something the reader does not have
    When the group covering what the reader cannot retrieve is read
    Then it names unresolvable presupposition, bare cross-reference, and undefined term at first use
    And it states, for each of the three, the condition that fires it
    And it states that the reader meant throughout is a reader on one declared control-flow path

  Scenario: group B names its three entries and what each fires on
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And an author whose passage was reported to misstate content the reader already has
    When the group covering what misrepresents what the reader already has is read
    Then it names re-presented as new, term drift, and contradiction
    And it states, for each of the three, the condition that fires it

  Scenario: group C names its three entries, and gates claim-without-mechanism on the declared doc type
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And an author whose passage was reported to disagree with the document's own spec
    When the group covering disagreement with the spec is read
    Then it names declaration mismatch, claim without mechanism, and orphan claim
    And it states, for each of the three, the condition that fires it
    And it states that claim without mechanism fires only where the declared doc type is explanation

  Scenario: every catalog entry states the near-miss that must not fire it
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And the nine catalog entries the page carries
    When each entry is inspected
    Then each of the nine states a case that must not fire it
    And the page states that an entry without a near-miss is a style opinion with a rubric attached

  Scenario: every catalog entry can be used without reading the rest of the page
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And the nine catalog entries the page carries
    And a reader who arrived at one of them from search or from a finding naming it, having read nothing above it
    When each of the nine entries is read on its own
    Then each of the nine states the condition that fires it at the entry
    And each of the nine states the near-miss that must not fire it at the entry
    And each of the nine makes the citation its group owes reachable from the entry

  Scenario: the page states which finding to report when one passage fires several entries
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And an author whose single passage fired more than one catalog entry
    When the page's reporting rule is read
    Then it states that one finding is reported per passage
    And it names repair subsumption as what selects which of the fired entries is reported

  # ── W3 — Check whether restating a claim is a problem ──

  Scenario: the page records recurrence as retracted rather than relocated
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And an author who landed one claim on two reader paths
    When the page's treatment of a claim appearing in two passages is read
    Then it states that recurrence is retracted rather than moved to another instrument
    And it states that a claim may recur freely
    And it states that replacing the second passage with a pointer is the worse defect

  Scenario: the surviving entry fires on new-information marking, not on the recurrence
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reader looking up the entry that survived the retraction
    When that entry is read
    Then it states that what fires it is the marking of returning content as new
    And it names at least one form that marking takes
    And it states that content restated but marked as already given does not fire it

  # ── W4 — Declare a violation made on purpose ──

  Scenario: the page names the channel, the three fields, and when the judge reads them
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a producer who broke an expectation knowingly and wants it weighed
    When the passage on declaring a deliberate violation is read
    Then it names the file the producer already writes for the judge as the channel
    And it states that a declaration names the entry, the location, and the rationale
    And it states that the judge reads the record in the scoring pass only
    And it states that a rationale asserting only that the choice was deliberate clears nothing

  # ── V1 — Decide whether a finding is admissible ──

  Scenario: each group states the citation it owes, and the three rules differ
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reviewer holding a finding from a known group
    When each group's citation rule is read
    Then the group for what the reader cannot retrieve requires the absence to be shown over a named path
    And it requires what that path traverses beforehand to be listed
    And the group for misrepresentation requires both passages to be quoted
    And the group for spec disagreement requires the spec line disagreed with to be quoted
    And the three citation rules differ from one another

  Scenario: the page requires each citation to name where it came from and the two locations to be confirmed distinct
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reviewer checking the two quotes a finding carries
    When the page's evidence rule is read
    Then it states that a quote carries its location and not only its words
    And it states that two quotes resolving to the same location are one passage read twice
    And it states that such a finding is not reportable

  # ── V2 — Decide whether a finding blocks ──

  Scenario: the page states that an entry is advisory until calibrated and what it blocks on afterward
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reviewer asking whether a reported finding stops the gate
    When the page's statement of when an entry blocks is read
    Then it states that an entry does not block until it has been run against documents the repo already accepts and documents it already considers weak
    And it states that the entry's false-positive rate must be reported rather than asserted
    And it states that a calibrated entry blocks only on a finding that is confirmed and undefended

  Scenario: the page shows a per-entry standing, and every entry is advisory
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reviewer looking up the standing of the one entry a finding named
    When the standing of each of the nine entries is inspected
    Then each entry's standing is readable beside that entry
    And all nine entries are shown as advisory
    And the page states that the whole catalog is therefore non-blocking
    And it states that this is the designed starting state rather than an outage

  # ── V3 — Resolve a collision with a frozen scenario ──

  Scenario: the page states that a frozen scenario outranks the bar and where the collision is filed
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reviewer whose frozen scenario requires what a criterion here would fail
    When the page's precedence rule is read
    Then it states that the scenario wins and the bar yields
    And it states that the collision is filed as an architect observation against the spec
    And it states that the collision is not reported as a gate blocker

  # ── V4 — Run the judged pass correctly ──

  Scenario: the page states the two passes in order and what the blind pass receives
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reviewer executing or auditing the judged pass
    When the page's description of the two passes is read
    Then it states that the first pass simulates a reader on one declared control-flow path
    And it lists the document, that declared path, and the audience row as everything the first pass receives
    And it states that the second pass scores the first pass's transcript against the catalog

  Scenario: the page routes the reason the first pass is blind rather than arguing it
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reviewer asking why the catalog is withheld from the first pass
    When the passage on the blind pass is read
    Then it states that the first pass is blind to the catalog
    And it links the page that owns the reason for the blind pass
    And it does not argue that reason in place of the link

  # ── M1 — Judge whether the catalog is trustworthy today ──

  Scenario: the page states that the catalog detects defects and never certifies quality
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And an adopter who has run the catalog over a document and got no findings
    When the page's statement of what the catalog does is read
    Then it states that the catalog names defects rather than certifying quality
    And it states that a document with zero findings is not thereby endorsed

  # ── M2 — Move an entry to blocking ──

  Scenario: the page gives the calibration run as steps and states what must be recorded
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a maintainer preparing to calibrate one advisory entry
    When the calibration procedure is read
    Then it presents the run as ordered steps
    And it states that the team names the corpus rather than the judge choosing it
    And it states that the judged pass runs unchanged during a calibration
    And it requires the false-positive rate and the named corpus to be recorded together
    And it states that a rate recorded without a named corpus is not a measurement

  Scenario: the page states how a run is scored and that firing on an accepted document keeps the entry advisory
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a maintainer scoring one entry against a document the repo already accepts and one it already considers weak
    When the scoring step is read
    Then it states that every firing on an already-accepted document counts as a false positive
    And it states that a miss on an already-weak document does not disqualify the entry
    And it states that an entry firing on an already-accepted document stays advisory
    And it names widening that entry's near-miss as the repair

  Scenario: the page states that calibration is per entry and not a vote across the catalog
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a maintainer holding nine cleared entries and one untested entry
    When the page's scope for a calibration verdict is read
    Then it states that calibration is per entry
    And it states that entries clearing together tells nothing about another entry
    And it states that an entry firing on neither corpus document is untested rather than calibrated

  # ── M3 — Check the bar is not a style guide ──

  Scenario: the page names what neither instrument may assert
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And an adopter holding a complaint about how a passage is written
    When the page's scope boundary is read
    Then it names tone, register, length, word choice, and section order as out of scope
    And it states that the exclusion holds at both instruments
    And it names evidence as what draws the boundary against style

  # ── M4 — Reach a neighboring claim ──

  Scenario: the page routes the claims it does not own instead of developing them
    Given the reference page at src/content/docs/quill/quill-builder-impl.md
    And a reader arriving with a question about the scenario-scoped checks, the spec-gate bar, or which agent runs this bar
    When the page is read
    Then each of those topics is reached by a link to the page that owns it
    And none of them is developed on this page in place of that link
