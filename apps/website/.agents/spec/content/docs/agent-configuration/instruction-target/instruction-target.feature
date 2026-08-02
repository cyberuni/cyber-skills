Feature: instruction-target — the "Target" article

  A reader finishes the article able to say, of any instruction they are about to write, who
  eventually reads it — and knowing which mechanism binds it there. The article's reason to
  exist is resolving why two contradictory instructions can both be correct.

  Scenarios assert the claims the article must land and the reader questions it must route.
  They freeze neither section order nor wording.

  # ── U1 — Orient ──

  Scenario: the article defines Target before naming any mechanism
    Given a reader unfamiliar with the term Target
    When the article is read from the top
    Then the opening states that Target is which of the agent's outputs an instruction governs
    And it states that this determines who eventually reads the instruction
    And the definition appears before any mechanism is named

  Scenario: the opening motivates Target with two values that contradict
    Given a reader who doubts that two contradictory instructions can both be correct
    When the article's opening is read
    Then it presents two instruction values that cannot both be one house style
    And it states that assigning them to separate targets lets them coexist

  Scenario: each of the three targets has its own section
    Given a reader who already knows what Target means
    When the article's headings are listed
    Then there is a section covering the Artifact target
    And there is a section covering the User target
    And there is a section covering the Agent target

  # ── U2 — Choose a mechanism ──

  Scenario: a mixed-target file routes to prose matching
    Given a file holding content governed by more than one target
    When the article's guidance on choosing a mechanism is read
    Then it directs that case to prose matching
    And it states that a path binds at file granularity while the targets vary inside the file

  Scenario: a glob-capable harness routes to file type matching
    Given a single-target file on a harness that supports path globs
    When the article's guidance on choosing a mechanism is read
    Then it directs that case to file type matching
    And it names at least one harness that provides a glob field

  Scenario: a harness without globs routes to description matching
    Given a single-target file on a harness that provides no path glob
    When the article's guidance on choosing a mechanism is read
    Then it directs that case to description matching

  Scenario: each mechanism states where the target lives, who decides, and what it settles
    Given the article's table of mechanisms
    When the table is inspected
    Then it lists file type matching, description matching, and prose matching
    And each row states where the target lives, who decides it, and what it settles

  # ── U3 — Identify the target ──

  Scenario: the Artifact section states it is the only target with a path
    Given an instruction governing content written to a file
    When the Artifact section is read
    Then it states that Artifact is the only target that has a path
    And it states that this is what makes file type matching possible

  Scenario: the User and Agent sections state that no path reaches them
    Given an instruction governing a reply or a brief
    When the User and Agent sections are read
    Then each states that no file path corresponds to its target
    And each states that description matching or prose matching carries the target instead

  Scenario: the Agent section distinguishes a brief from mail by the recipient's standing mission
    Given an instruction governing another agent's context
    When the Agent section is read
    Then it states that a brief becomes the recipient's mission
    And it states that mail arrives at an agent that already has a mission

  # ── U4 — Stop the bleed ──

  Scenario: the article attributes drift to accumulation of unlabeled examples
    Given a reader whose instruction is being ignored late in a session
    When the section on keeping targets apart is read
    Then it states that produced output accumulates as unlabeled examples
    And it states that drift runs toward whichever target was served most

  Scenario: the article recommends a separate session
    Given an artifact that can be specified in a brief
    When the article's closing recommendation is read
    Then it recommends producing that artifact in a separate session

  Scenario: the article recommends restating the target at production time
    Given an artifact that cannot be specified in a brief
    When the article's closing recommendation is read
    Then it recommends restating the target at the moment of production

  Scenario: the four arrangements are ranked by separation strength
    Given the section on keeping targets apart
    When its list of arrangements is inspected
    Then it presents four arrangements
    And they are ordered by how strongly each separates the targets
    And each carries the cost of adopting it
