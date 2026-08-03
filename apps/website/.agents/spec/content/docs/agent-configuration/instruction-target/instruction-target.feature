Feature: instruction-target — the "Target" article

  Target exists to make agent configuration composable. An author splits config into
  single-target units that do not fight; a user combines those units freely, because values
  contradicting on paper coexist when they govern different outputs.

  Scenarios assert the claims the article must land and the reader questions it must route,
  for both audiences. They freeze neither section order nor wording.

  # ── A1 — Decide whether to split a file ──

  Scenario: the article stands alone without prerequisite reading
    Given a reader who has read the section's entry page and nothing else
    When the article is read end to end
    Then every term it relies on is defined within it or linked at its first use
    And no section directs the reader to read another document first

  Scenario: the article names separation by target as the seam that splits config
    Given an author holding one config file that shapes several kinds of output
    When the article is read
    Then it states that separating instructions by target makes them reusable independently
    And it states that mixing targets in one unit is what forces it to be adopted whole

  Scenario: a mixed-target file routes to a separate unit or to prose matching
    Given a file holding content governed by more than one target
    When the article's guidance on mixed-target files is read
    Then it states that a path binds at file granularity while the targets vary inside the file
    And it directs a target whose rules can stand as their own unit to description matching
    And it reserves prose matching for variants that splitting would duplicate

  Scenario: the article defines Target before naming any mechanism
    Given an author unfamiliar with the term Target
    When the article is read from the top
    Then the opening states that Target is which of the agent's outputs an instruction governs
    And it states that this determines who eventually reads the instruction
    And the definition appears before any mechanism is named

  Scenario: the opening motivates Target with two values that contradict
    Given an author who doubts that two contradictory instructions can both be correct
    When the article's opening is read
    Then it presents two instruction values that cannot both be one house style
    And it states that assigning them to separate targets lets them coexist

  # ── A2 — Bind a unit to its target ──

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

  # ── A3 — Stop a unit bleeding ──

  Scenario: the article attributes drift to accumulation of unlabeled examples
    Given an author whose instruction is being ignored late in a session
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

  # ── C1 — Predict whether two configs will fight ──

  Scenario: the article addresses the user combining units, not only the author writing them
    Given a reader who enables existing configuration rather than writing it
    When the article is read
    Then it states that units governing different targets can be enabled together
    And it gives that reader a way to tell whether two units govern the same output

  Scenario: two units on different targets are shown coexisting
    Given two configuration units whose stated values contradict each other
    And the two units govern different targets
    When the article's treatment of coexistence is read
    Then it names a concrete pair of units in that position
    And it states that both may be in force at once

  Scenario: two units on the same target are named a real conflict
    Given two configuration units whose stated values contradict each other
    And the two units govern the same target
    When the article's treatment of coexistence is read
    Then it states that this case is a genuine conflict rather than a coexistence

  # ── C2 — Diagnose over-reach ──

  Scenario: each of the three targets has its own section
    Given a user whose enabled unit shapes output they did not intend
    When the article's headings are listed
    Then there is a section covering the Artifact target
    And there is a section covering the User target
    And there is a section covering the Agent target

  Scenario: two units sharing a purpose do not compete on that account
    Given a user checking what an enabled unit actually governs
    When the article's treatment of coexistence is read
    Then it states that a block's purpose is unchanged by which target receives it
    And it states that only a shared target puts two units in conflict
