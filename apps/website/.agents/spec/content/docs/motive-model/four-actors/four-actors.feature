Feature: four-actors — the "Four Actors" article

  The article names the four actors of the Motive Model and teaches a reader to say which
  actor a concrete act belongs to. Its payload is the three boundaries between neighbours —
  Oracle|Builder, Builder|Architect, Architect|Strategist — because a reader who cannot tell
  two actors apart has a roster, not a model.

  Scenarios assert the claims the article must land and the reader questions it must route,
  for both audiences. They freeze neither section order nor wording.

  Background:
    Given the article published at /motive-model/four-actors/
    And its source at apps/website/src/content/docs/motive-model/four-actors.mdx

  # ── P1 — Name the actor for the act in hand ──

  Scenario: the article assumes the premise and defines the four actors itself
    Given a reader who has read the section's entry page and nothing else
    When the article is read end to end
    Then it defines each of the four actors within itself
    And no passage requires a later page in the section to be read first

  Scenario: an actor is a human holding a motive that generates work the others do not
    Given a practitioner holding an act whose owning role is unclear
    When the article's opening is read
    Then it states that an actor is a human holding one of four base motives
    And it states that the motive is what makes each a real actor, because each generates work the others do not

  Scenario: each actor carries a motive, what it owns, and a signature output
    Given a practitioner naming the actor for an act
    When the article's presentation of the four actors is inspected
    Then Oracle, Builder, Architect, and Strategist each state their motive
    And each states what that actor owns
    And each states that actor's signature output

  Scenario: deciding whether and why routes to the Oracle, and how routes to the Builder
    Given an act that decides whether the thing should exist at all
    When the article's treatment of the Oracle and the Builder is read
    Then it assigns whether and why to the Oracle
    And it assigns how it is made to the Builder
    And it states that a Builder who redefines the goal has stepped into the Oracle role

  # ── P2 — Settle a boundary with the neighbour ──

  Scenario: the Builder/Architect boundary is decided by the object, not by scope
    Given a Builder who has zoomed out to work at system scope
    When the article's treatment of the Builder and the Architect is read
    Then it states that the Builder's object is a part and the Architect's is the relations between parts
    And it states that a larger part is still a part, so scope is not what separates them
    And it states that the same person can cross that boundary within one sitting

  Scenario: the ladder separates the rungs by scope of reuse and where the result lives
    Given a reader comparing the three actors that operate on the product
    When the article's ladder is inspected
    Then it places generalizing within one feature, across features, and across products over time on one scale
    And it states where each rung's result lives — the feature, the product, the corpus
    And it names each rung's concern as design, architecture, and curation respectively

  Scenario: each rung names the mechanism by which it adds value
    Given a reader who cannot see what the three rungs actually differ on
    When the article's account of the ladder is read
    Then it states that design changes behavior directly
    And it states that architecture changes behavior through structure
    And it states that curation changes future capability through knowledge

  Scenario: an example shows design satisfied while the whole stays unmaintainable
    Given work that satisfies design yet leaves the whole unmaintainable
    When the article's justification of the Architect is read
    Then it presents an example of work whose behavior is correct while the whole is unmaintainable
    And it attributes that gap to behavior bought directly, without structural leverage
    And it names that gap as the Architect's reason to exist

  Scenario: the Architect draws lines ahead of the work and authors the rules Builders follow
    Given a structural concern being decided before anyone builds
    When the article's Architect section is read
    Then it states that the Architect draws the lines ahead of the work
    And it states that the Architect authors the rules the Builders then build under
    And it denies that the Architect merely tidies what already landed

  Scenario: extracting a shared path is Architect work, not a separate design act
    Given a concern visible across features that have already landed
    When the article's Architect section is read
    Then it presents an example of one shared path extracted across several features
    And it states that the resulting behavioral gain is the fruit of organizing rather than a separate design act

  # ── P3 — Decide where a lesson belongs ──

  Scenario: the Architect/Strategist boundary is decided by whether the result outlives the product
    Given a result that may or may not outlive the product it came from
    When the article's treatment of the Architect and the Strategist is read
    Then it states that the Architect's result lives in this product and dies with it
    And it states that a result lifted out to outlive the product is Strategist work
    And it states that the Strategist's object is knowledge rather than the product

  Scenario: the article answers the objection that curating a corpus is architecture at another tier
    Given a reader who suspects the Strategist is only an Architect of the corpus
    When the article's Strategist section is read
    Then it raises that objection explicitly
    And it concedes that organizing the corpus is architecture of the corpus, which a Strategist does constantly
    And it names three acts that organizing does not contain — selecting which lessons are durable enough to encode, generalizing across products and time, and removing what is no longer true
    And it states that those three acts are accumulate rather than structure

  # ── M1 — Take the actor set as a vocabulary ──

  Scenario: the object that separates Builder from Architect is retrievable on both reader paths
    Given a reader arriving at the vocabulary rather than at a boundary dispute
    When the passages presenting the four actors are read
    Then the object that separates the Builder from the Architect is retrievable there
    And it is also retrievable from the passage that treats the Builder and Architect boundary directly

  # ── M2 — Justify the closure ──

  Scenario: the four are declared mutually exclusive and collectively exhaustive
    Given a reader asking whether a fifth actor is missing
    When the article's account of the set is read
    Then it states that the motives do not overlap
    And it states that nothing essential falls outside the four

  Scenario: the four are presented as a control loop around abundant generation
    Given a reader asking why these four and not some other set
    When the article's opening is read
    Then it places the four around abundant generation as a loop
    And it names each position in that loop — deciding what is worth making, making candidates, keeping the whole coherent, making the learning compound

  # ── M3 — Place the Strategist ──

  Scenario: the model is two-tiered — three delivery actors and one foundation actor
    Given a reader laying out what depends on what between the actors
    When the article's tiering is read
    Then it states that Oracle, Builder, and Architect operate on the product
    And it states that the Strategist operates on the capacity to deliver
    And it states that every other actor's delegate reads from the corpus

  Scenario: the tiering yields a prediction about neglected infrastructure
    Given a reader weighing the cost of neglecting the corpus
    When the article's tiering is read
    Then it states that infrastructure is the first thing a team neglects
    And it states that a decaying corpus forces every delegate, in every role, to start cold
