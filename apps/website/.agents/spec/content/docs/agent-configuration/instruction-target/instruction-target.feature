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

  Scenario: file type matching is reserved for content a path can name
    Given a single-target file on a harness that supports path globs
    When the article's guidance on choosing a mechanism is read
    Then it reserves file type matching for the case where the harness offers a path glob and a path names the content the instruction governs
    And it states that file type matching is deterministic, because the harness evaluates the glob rather than the agent judging the situation
    And it names at least one harness that provides a glob field

  Scenario: description matching is reserved for content no path can name
    Given a single-target file on a harness that provides no path glob
    When the article's guidance on choosing a mechanism is read
    Then it reserves description matching for the case where no path names the content the instruction governs, including where the harness offers no glob and where the output is not a file at all
    And it states that description matching is a semantic judgment the agent makes rather than a rule the harness evaluates

  Scenario: each mechanism states where the target lives, who decides, and what it settles
    Given an author comparing the three mechanisms
    When the article's account of the mechanisms is read
    Then it names file type matching, description matching, and prose matching
    And for each it states where the target lives, who decides it, and what it settles

  Scenario: a target needing a substantial body of instruction is isolated rather than scoped
    Given an author whose single target needs a substantial body of instruction
    When the article's account of the limit of specifying a target is read
    Then it states that where one target needs a substantial body of instruction, isolating it in its own subagent or session beats scoping it in place
    And it states that isolation removes the competing target from context
    And it states that a scope statement instead asks the agent to honor a boundary on every turn

  Scenario: a target needing a short instruction is bound by a scope statement in the body
    Given an author whose single target needs a few lines of instruction inside an existing file
    When the article's account of specifying a target is read
    Then it states that a target needing only a scope statement rather than a substantial body of instruction is specified by writing the target into the instruction body
    And it states that no harness setting enforces that boundary

  Scenario: the Artifact section states it is the only target with a path
    Given an instruction governing content written to a file
    When the Artifact section is read
    Then it states that Artifact is the only target that has a path
    And it states that having a path is what makes file type matching possible
    And it states that having a path is why a single file can hold content governed by several targets at once

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
    And it states that mail therefore competes for attention rather than setting the agenda
    And it states that mail must therefore stand on its own, carrying the context the recipient needs to act without access to the sender's session

  Scenario: the User section states that every purpose applies to it, not only Tone
    Given an instruction for the user that carries a procedure rather than a rule about phrasing
    When the User section is read
    Then it states that every purpose applies to the User target, not only Tone
    And it gives an example of a User instruction that is not about how something is said

  Scenario: the User section states that the user can answer back
    Given an instruction for the user that could leave a detail to a later turn
    When the User section is read
    Then it states that the user can respond, which no other target can
    And it states that a brief must instead anticipate what would have been asked

  # ── A3 — Stop a unit bleeding ──

  Scenario: the article attributes drift to accumulation of unlabeled examples
    Given an author whose instruction is being ignored late in a session
    When the section on keeping targets apart is read
    Then it states that produced output accumulates as unlabeled examples
    And it states that drift runs toward whichever target was served most

  Scenario: a separate session is reserved for an artifact a brief can specify
    Given an artifact that can be specified in a brief
    When the article's account of the arrangements is read
    Then it reserves producing in a separate session for an artifact that can be specified in a brief
    And it states that a freshly spawned session has accumulated nothing that can bleed
    And it states that its cost is starting with no context, which fits poorly when the artifact is the residue of a long discussion

  Scenario: restating the target is reserved for an artifact a brief cannot specify
    Given an artifact that cannot be specified in a brief
    When the article's account of the arrangements is read
    Then it directs an artifact that cannot be specified in a brief to restating the target at the moment of production
    And it states that its cost is having to remember to do it

  Scenario: producing early is reserved for a session that knows its artifact upfront
    Given an author who knows at the outset which artifact the session will produce
    When the article's account of the arrangements is read
    Then it reserves producing the artifact early for a session that knows at the outset which artifact it will produce
    And it states that producing early works because less output for another target has accumulated
    And it states that its cost is nothing to apply, but that it depends on that foreknowledge

  Scenario: scoping the instruction is reserved for a session that discovers its artifacts as it runs
    Given an author whose session discovers as it runs which artifacts it will produce
    When the article's account of the arrangements is read
    Then it reserves scoping the instruction for a session that does not know at the outset which artifact it will produce
    And it states that scoping the instruction separates the targets least of the four
    And it states that a scope statement is exactly what accumulation erodes
    And it states that it is nonetheless the only arrangement asking nothing at production time

  Scenario: the four arrangements are ranked by separation strength
    Given an author comparing the arrangements that keep targets apart
    When the article's list of arrangements is read
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
    Then it states the test as comparing what each of the two units governs
    And it states that two contradicting units whose targets differ never meet, so both may be in force at once
    And it names a concrete pair of units in that position

  Scenario: two units on the same target are named a real conflict
    Given two configuration units whose stated values contradict each other
    And the two units govern the same target
    When the article's treatment of coexistence is read
    Then it states that two contradicting units governing the same target is a genuine conflict rather than a coexistence
    And it states that one of them has to win, because there is no second target to separate them onto

  Scenario: two units sharing a purpose do not compete on that account
    Given two units that serve the same purpose
    And the two units govern different targets
    When the article's treatment of coexistence is read
    Then it states that a block's purpose is unchanged by which target receives it
    And it states that only a shared target puts two units in conflict

  # ── C2 — Diagnose over-reach ──

  Scenario: each of the three targets has its own section
    Given a user whose enabled unit shapes output they did not intend
    When the article's headings are listed
    Then there is a section covering the Artifact target
    And there is a section covering the User target
    And there is a section covering the Agent target

  Scenario: each target names where its output goes, the forms it covers, and an example
    Given a user placing an unexpected output among the three targets
    When the article's account of the three targets is read
    Then for each of Artifact, User, and Agent it states where that output goes
    And for each it states the forms of output it covers
    And for each it gives an example of a unit governing that target

  Scenario: a unit bound to the target the user intended is diagnosed as drift
    Given a user whose enabled unit names the target they intended it for
    And that unit is shaping output for a second target late in the session
    When the article's account of drift is read
    Then it states that a scope statement made once competes against the examples the session accumulates
    And it states that the longer the session runs the weaker that scope statement's position
    And it points a reader who has diagnosed drift to the arrangements that keep targets apart

  Scenario: an instruction that names no target is placed on the user by default
    Given a user whose enabled unit is shaping their chat replies
    And that unit's body and description name no target
    When the article's account of the User target is read
    Then it states that everything the agent produces other than a file or a brief goes to the user
    And it states that the User target is therefore always in force
