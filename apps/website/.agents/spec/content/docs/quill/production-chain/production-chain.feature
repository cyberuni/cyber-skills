@frozen
Feature: quill/production-chain — the page of record for Quill's role and bar bindings

  The reference page a reader consults to look up which agent or default acts at each SDD
  production-chain slot, where each Quill agent sits in the mission loop, and which agent writes a
  document versus which one only runs the checks on it.

  # ── MR1 — Name the agent acting at the phase the mission is in ──

  Scenario: the page places each Quill agent at the phase that dispatches it
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader running a documentation mission who has seen a Quill agent name in the transcript
    When they look up the phase the mission is currently in
    Then the page names quill-spec-writer as the agent acting during explore
    And it names quill-doc-writer as the agent acting during deliver
    And it names quill-judge as the agent acting at the impl gate

  Scenario: a phase that dispatches no Quill agent names what acts there instead
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader at a point of the mission loop where no Quill agent appeared
    When they look that point up
    Then the page lists the spec gate and the design fork alongside the phases that do dispatch a Quill agent
    And for each of them it names the actor that acts in place of a Quill agent
    And it states that a role Quill leaves empty falls back to the SDD default rather than to nothing

  # ── MR2 — Decide whether to invoke a Quill agent by hand ──

  Scenario: the page states the three agents are conductor-dispatched and not reader-invocable
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader looking for a way to run one of the three agents themselves
    When they look up how an agent is invoked
    Then the page states that quill-spec-writer, quill-doc-writer, and quill-judge are dispatched by the SDD conductor
    And it states that a reader does not invoke them directly

  # ── MR3 — Weigh an impl-gate verdict ──

  Scenario: the page separates the agent that authors a document from the agent that runs its checks
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader holding an impl-gate verdict on a document
    When they look up who produced the verdict
    Then the page states that quill-doc-writer authors both the documents and their per-scenario acceptance checks
    And it states that quill-judge runs those checks and authors no criteria of its own

  Scenario: the page enumerates the three frozen anchors the judge runs from
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader asking what the judge is entitled to report as a finding
    When they look up the judge's basis
    Then the page names the frozen .feature, the frozen document-scoped rule, and the frozen defect catalog
    And it states that each of the three is an artifact the judge did not write

  Scenario: an impression matching none of the anchors is stated not to be a finding
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader holding a reported finding that matches none of the three anchors
    When they look up whether it counts
    Then the page states that there is no fourth anchor
    And it states that an impression matching none of the three is not a finding

  Scenario: the page states what the judge's independence rests on
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader who has noticed that the producer wrote the checks the judge runs
    When they look up why the verdict is still independent
    Then the page attributes the independence to the anchors being artifacts the judge did not write
    And it attributes the independence to the judge being a separate runner from the author

  # ── MR4 — Follow up a question this page defers ──

  Scenario: a deferred claim is named with its owning page rather than developed here
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader whose lookup succeeded and raised a question this page does not own
    When they look for what a check verifies, what a bar contains, or how a registry entry is written
    Then the page names each of those claims together with the page that owns it
    And it links to that page instead of restating the claim

  # ── PI1 — Audit the role bindings ──

  Scenario: the page presents all five production-chain roles as one lookup
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader auditing a squad entry rather than tracking a live mission
    When they look up which roles the production chain has
    Then the page lists spec-producer, solution-producer, spec-judge, impl-producer, and impl-judge
    And it states that the five roles are SDD's closed set, of which a plugin fills a subset
    And it binds quill-spec-writer to spec-producer, quill-doc-writer to impl-producer, and quill-judge to impl-judge

  Scenario: every unfilled role row names the SDD default that fills it
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader reading the role table straight through
    When they reach a row whose value in the registry is null
    Then the page shows solution-producer and spec-judge as the roles Quill leaves unbound
    And it names, for each of those two rows, the actor that fills it in Quill's absence
    And no role row is left without either a Quill agent or a named filler

  # ── PI2 — Decide which bars to write ──

  Scenario: the page separates the bars Quill binds from the bars it leaves to SDD
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader deciding whether a documentation-specific bar already exists for a gate
    When they look up the bar governance slots
    Then the page binds builder-spec to quill-builder-spec and names the spec gate as where it acts
    And it binds builder-impl to quill-builder-impl and names the impl gate as where it acts
    And it shows oracle-spec, architect-spec, and architect-impl as left to the SDD defaults

  # ── PI3 — Check the table is still true ──

  Scenario: the page names the registry file and the entry that decides every binding
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader who needs the bindings to be current, reading either the role table or the bar table
    When they look for what settles a binding
    Then the page names .agents/universal-plugin.json as the authority for every binding it reports
    And it names the quill squad entry's roles and governances objects as where a reader reads them
    And it states that the page reports the bindings and the registry decides them

  # ── PI4 — Get the bindings into a project ──

  Scenario: a reader who needs the bindings created is routed to the page that writes them
    Given the reference page exists at apps/website/src/content/docs/quill/production-chain.md
    And a reader whose project has no quill entry in its registry yet
    When they look for how a project comes to have these bindings
    Then the page directs the question of creating an entry to the page that writes one
    And it keeps the question of what an existing entry currently binds
