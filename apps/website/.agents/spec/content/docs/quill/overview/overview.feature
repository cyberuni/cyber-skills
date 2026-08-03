Feature: quill/overview — the Quill section entry page

  The entry page delivers one outcome: a reader can name where the artifact they are holding
  goes next — the sibling page that owns their question, or the SDD default chain if Quill's
  chain does not resolve for it. Screening is not a second outcome; a subject Quill does not
  resolve for has a destination too, so the recusal is a leaf like the five pages are leaves.
  The argument is the premise that makes the destination defensible rather than guessed.

  Scenarios assert the claims the page must land and the reader questions it must route. They
  freeze neither section order nor wording, and they name no check, no role binding, and no
  catalog entry — those belong to sibling pages, and the assertions below require the link
  rather than the content.

  # ── E1 — Find out what this is ──

  Scenario: the page stands alone without prerequisite reading
    Given a reader who has opened this page first and read nothing else on the site
    When the page is read end to end
    Then every term it relies on is explained where it is first used or linked at that point
    And no passage directs the reader to read another page before continuing

  Scenario: the page states the gap a documentation runner fills
    Given a reader who has not met Quill before
    When the page is read from the top
    Then it names missing content, structural drift, and reader-path gaps as ways documentation fails
    And it states that those are the same ways code fails
    And it states that documentation has no compiler and no test runner to catch them

  Scenario: the page states what Quill treats a document as
    Given a reader who accepts that documentation fails the way code fails
    When the page is read
    Then it states that a document is an implementation artifact with verifiable structure
    And it states that the document's behavior is contracted before the document is written
    And it names the frozen .feature as the artifact carrying that contract

  Scenario: the page places Quill inside SDD rather than as a standalone tool
    Given a reader who expects a tool they run against their docs themselves
    When the page's statement of what Quill is is read
    Then it states that Quill is a plugin to SDD
    And it states that SDD's conductor invokes Quill's delegates for a documentation artifact-type
    And it states that Quill does not run on its own

  # ── E2 — Check whether it applies to what they own ──

  Scenario: the page names the five documentation artifact-types
    Given a reader holding one file they might put under Quill
    When the page's statement of what Quill covers is read
    Then it names documentation, guide, tutorial, article, and reference
    And it states that these are the keys by which SDD resolves the Quill chain for a file

  Scenario: the page states what makes a subject structurally checkable
    Given a reader deciding which side of Quill's boundary their own subject falls on
    When the page's statement of what Quill applies to is read
    Then it states that the subject must have a declared path
    And it states that the subject must have required sections
    And it states that a guide or tutorial must additionally have a reader flow

  Scenario: a subject the chain does not resolve for is given the recusal, not a refusal
    Given a reader whose subject has no inspectable document surface
    And a reader whose subject is a document of none of the five artifact-types
    When the page's statement of what Quill applies to is read
    Then it states that the SDD default chain handles a subject Quill does not resolve for
    And that destination is stated for a missing document surface and for an unlisted artifact-type alike
    And neither case is described as refused or unsupported

  # ── E3 — Get it running ──

  Scenario: the page presents installing and registering as two separate steps
    Given a reader whose project uses SDD and has never installed Quill
    When the page's setup guidance is read
    Then it gives the command that installs the plugin
    And it states that registering Quill is a further step
    And it states that without registration the conductor resolves Quill for nothing

  Scenario: the next-step guidance names the page that owns registration
    Given a reader who has just run the install command
    When the page's next-step guidance is read
    Then it links the sibling page that owns registration
    And it does not give the registry entry's contents in place of that link

  # ── E4 — Find out what it will not touch ──

  Scenario: the page states that wording, style, and tone are never asserted
    Given a reader who owns prose and expects an automated grader to police their voice
    When the page's statement of what Quill checks is read
    Then it states that wording is not asserted
    And it states that style and tone are not asserted
    And it attributes that limit to both instruments rather than to one of them
    And it links the sibling page that is the page of record for that limit

  # ── S1 — Find which chain handles a documentation change ──

  Scenario: the page names the roles Quill fills and defers the bindings to the owning page
    Given a practitioner running SDD who has reached a change whose artifact is a document
    When the page's account of how Quill plugs into SDD is read
    Then it states that Quill fills the production-chain delegate roles for its artifact-types
    And it links the sibling page that owns which agent fills which role
    And it does not pair a role with the agent or governance that fills it

  # ── S2 — Reach one specific part ──

  Scenario: every page in the section is reachable from the entry page
    Given the five sibling pages of the Quill section
    When the entry page's links are listed
    Then each of the five is linked
    And each link carries a description of what that page covers

  Scenario: the route discriminates by the question a page answers
    Given a reader who arrives holding one specific question
    When the entry page's link descriptions are inspected
    Then each description distinguishes its page by the question that page answers, not by its position in the section
    And the two bar pages are distinguished by which gate each one applies at
    And the page covering how a document is checked is distinguished from the page covering who checks it

  Scenario: both instruments are named and each routes to the page that owns the split
    Given a reader asking how a verdict on a document is reached
    When the page's account of how a document is checked is read
    Then it names inspection as reaching a boolean verdict by comparing the document against a frozen artifact
    And it names judgment as reaching a graded verdict by simulating a reader against a frozen catalog
    And it links the sibling page that owns the split for each of the two

  Scenario: the entry page routes to the owning page instead of standing in for it
    Given a reader looking for what a check verifies, what a documentation spec must contain, or what the impl gate holds a document to
    When the entry page is read
    Then each of those topics is reached by a link to the page that owns it
    And none of them is developed on the entry page in place of that link
