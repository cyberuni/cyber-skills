Feature: motive-model/overview — the Motive Model entry page

  The entry page is an argument plus a switchboard. The argument is why a job title stopped
  being the unit of a team and what replaced it; the switchboard routes a reader who came for
  one part to the page that owns it. One rule underwrites the whole section and must reach a
  reader on either arrival: an AI is never an actor.

  Scenarios assert the claims the page must land and the reader questions it must route. They
  freeze neither section order nor wording, and they name no actor — the Oracle/Director drift
  between the project spec and its suite is unresolved, so the routing assertions use the four
  motives, which both artifacts agree on.

  # ── P1 — Find out what this is ──

  Scenario: the page stands alone without prerequisite reading
    Given a reader who has opened this page first and read nothing else in the section
    When the page is read end to end
    Then every term it relies on is defined on the page or linked at its first use
    And no passage directs the reader to read another page before continuing

  Scenario: the page states the old equation and why it held
    Given a reader who has not met the model before
    When the page is read from the top
    Then it states that a position equaled a contribution because production was scarce
    And it states that the work waited on whoever held the discipline the team lacked
    And it states that the waiting, rather than the producing, was the cost of building

  Scenario: the page names what AI changes about producing
    Given a reader who has not met the model before
    When the page is read
    Then it states that a discipline can be codified and run by a delegate acting on a person's behalf
    And it states that producing the artifact is no longer the scarce, defining act

  Scenario: the page names the unit that replaced the title
    Given a reader who has accepted that producing is no longer the scarce act
    When the page is read
    Then it states that the unit of a team is the direction a person sets right now
    And it states that this direction is a motive held from an angle of expertise
    And it states that a title is a default rather than a boundary on what a person contributes

  Scenario: the shift is presented as a before-and-after a reader can place themselves in
    Given a reader deciding whether the claim describes their own work
    When the page's contrast between scarce and abundant production is read
    Then it states, for each side, what the unit of a team is
    And it states, for each side, which act is the scarce one

  # ── P2 — Test the premise against their own work ──

  Scenario: a reader whose work is not cheap to generate is given the dial, not an exception
    Given a reader whose own work is novel enough that generation stays expensive
    When the page's treatment of the abundance premise is read
    Then it states that the premise is relative to how cheap generation is, rather than absolute
    And it states that where generation stays expensive the title-equals-contribution rule survives locally
    And it states that the model degrades gracefully there — the same parts, less compression

  # ── P3 — Find out what their own title becomes ──

  Scenario: a reader reading the model through is given exactly one labeled first step
    Given a reader who wants to read the model through rather than look one thing up
    When the entry page's guidance on where to begin is inspected
    Then exactly one sibling page is marked as the place to start
    And the marked page is the one that maps a reader's existing title onto the model

  Scenario: the closing hand-off names the same page marked as the place to start
    Given a reader who has read the entry page through
    When the page's closing hand-off is read
    Then it names the next page to read
    And that page is the same one marked as the place to start

  # ── A1 — Take the constraint before using the vocabulary ──

  Scenario: the page states that an AI is never an actor
    Given a reader about to describe a team or a workflow in the model's terms
    When the page is read
    Then it states that a human holds the motive and the accountability
    And it states that an AI is capacity the human wields
    And it states that an AI is not a party with goals of its own

  Scenario: the rule is reachable from both reader arrivals
    Given a reader who arrives new to the model
    And a reader who arrives to find one specific part
    When each follows the route the entry page gives their arrival
    Then each route passes through a statement that an AI is never an actor
    And neither route has to leave the entry page to reach it

  Scenario: the page presents the delegation loop including the fidelity check
    Given a reader who will hand work to an AI delegate
    When the page's summary of the model is read
    Then it shows an actor authoring a delegation surface
    And it shows that surface configuring the delegate
    And it shows the delegate returning work to the actor
    And it shows the actor checking the delegate's fidelity rather than assuming it

  Scenario: the page separates what a human holds from what an AI supplies
    Given a reader deciding which side of the model a party falls on
    When the page's summary of the model is read
    Then it attributes motive and accountability to the human side
    And it attributes capacity, and no motive of its own, to the AI side

  Scenario: the page defers the full treatment of surfaces and delegates
    Given a reader who wants the four surfaces enumerated and the substrate-to-party transition explained
    When the page's summary of the model is read
    Then it links the page that owns that treatment
    And it does not enumerate the four surfaces in place of that link

  # ── A2 — Reach one specific part ──

  Scenario: every page in the section is reachable from the entry page
    Given the eight sibling pages of the Motive Model section
    When the entry page's links are listed
    Then each of the eight is linked
    And each link carries a description of what that page covers

  Scenario: the route discriminates by the question a page answers
    Given a reader who arrives holding one specific question
    When the entry page's link descriptions are inspected
    Then each description distinguishes its page by the question that page answers, not by its position in the reading path
    And the description for the term-definition page marks it as where a load-bearing term is defined
    And the description for the motives page names intending, generating, structuring, and accumulating as what it covers

  Scenario: the entry page routes to the owning page instead of standing in for it
    Given a reader looking for the four motives, the gate's verdict, the variants, or a term's definition
    When the entry page is read
    Then each of those topics is reached by a link to the page that owns it
    And none of them is developed on the entry page in place of that link

  # ── A3 — Judge whether the model is worth adopting ──

  Scenario: the page names what getting the motives wrong costs
    Given a reader weighing this vocabulary against organizing by title or by timeline
    When the page's statement of what the model is for is read
    Then it states that the vocabulary is organized so the parts do not overlap
    And it names treating an AI as a teammate with its own goals as a concrete failure
    And it names organizing the team on a timeline instead of by motive as a concrete failure
