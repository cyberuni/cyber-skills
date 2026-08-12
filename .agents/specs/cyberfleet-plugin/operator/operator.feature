@frozen
Feature: operator — the command-center persona
  Unit suite for the Operator persona skill: the dispatcher automaton the Council calls to work the
  command center — spawning every ship, listing who's out there, routing messages
  between ships, and sweeping away the dead ones. The command center is a singleton that outlives
  every session: the Council reaches it by invoking this skill, and that invocation is what connects
  this session to it. The connection is asserted by invocation, never by a probe. Its fleet
  mechanics — spawn, who, mail, prune — all offload to the cyberlegion CLI. Its in-ship counterpart
  is the Pod persona, reached by routing in-ship work to it rather than by probing where this folder
  sits. The file store, ordering, spawn, and hook mechanics live in the sibling cyberlegion CLI
  project (mail, unit, mux).

  # ── Connecting to the command center (ADR-0022, amended) ──

  @behavior
  Scenario: loading Operator connects this session to the command center without a probe
    Given the Council invokes the Operator skill and asks it to list every session running across the fleet
    When Operator takes that request
    Then it lists the fleet straight away
    And it never probes this folder to decide whether this session is connected to the command center

  @behavior
  Scenario: Operator stays connected wherever the Council invokes it
    Given the Council invokes the Operator skill from inside a project an agent is already working in
    When the Council asks it to prune the dead ships from the fleet
    Then it prunes them from the command center
    And it does not hand the request to Pod, since nothing about this folder can disconnect this session from the command center

  @behavior
  Scenario: Operator's description names the work it does, never where the Council stands
    Given the Operator skill's description
    When a harness reads it to decide whether to route a request here
    Then it names the fleet-level work Operator is responsible for — spawning, listing, and pruning ships, and routing messages between sessions
    And it states no location condition such as being outside a ship

  # ── The command center's identity — connecting ──

  @behavior
  Scenario: connecting registers this session in the hub
    Given the hub holds no identity for this session
    When Operator connects to the command center
    Then it runs cyberlegion unit register carrying this session's own handle, before it claims the standing operator owner

  @behavior
  Scenario: the session is never registered under the standing owner's handle
    Given the standing owner "operator" holds the command center's durable identity
    When Operator registers this session
    Then "operator" is never passed as this session's registered handle

  @behavior
  Scenario: connecting claims the standing operator owner so the doorbell reaches this session
    Given the standing owner "operator" exists
    When Operator connects to the command center
    Then it runs cyberlegion unit claim operator

  @behavior
  Scenario: connecting takes the claim even when another session already holds it
    Given the standing owner "operator" has a presence bound to another session
    When Operator connects to the command center
    Then it runs cyberlegion unit claim operator all the same

  @behavior
  Scenario: a session that cannot claim says so and dispatches anyway
    Given this session runs outside any multiplexer, so a presence cannot be bound
    When Operator connects to the command center
    Then it reports the standing operator owner unclaimed and carries on dispatching

  @behavior
  Scenario: a missing standing owner is routed to onboarding, never minted
    Given the hub holds no standing owner "operator"
    When Operator connects to the command center
    Then it reports the missing owner, routes the Council to init-cyberlegion, and leaves the hub without a standing owner "operator"

  # ── The command center mailbox — reading what it took ──

  @behavior
  Scenario: connecting leads with what the command center took while nobody was connected
    Given the standing owner "operator" holds unread mail
    When Operator connects to the command center
    Then it reads cyberlegion mail inbox --owner operator --unread and names that unread mail in the state it leads with

  @behavior
  Scenario: a report Operator has acted on leaves the unread set
    Given Operator has acted on a report in the command center mailbox
    When it closes that report out
    Then it runs cyberlegion mail read --owner operator --ack on that report

  @behavior
  Scenario: a report Operator has not acted on stays unread
    Given the command center mailbox holds a report Operator has not acted on
    When Operator finishes reporting the board
    Then that report is still in the unread set

  @behavior
  Scenario: a spawn brief names the standing owner's handle as the return address
    Given Operator is writing the cold brief for a ship it is about to spawn
    When it names where the ship reports back
    Then the brief names the handle operator and names neither this session's id nor this session's own handle

  # ── Triggering ──

  @trigger
  Scenario Outline: Operator activates on fleet-level dispatch
    Given a user query "<query>"
    When cyberspace routes the request
    Then invocation is "<should_trigger>"

    Examples:
      | query                                                                          | should_trigger |
      | stand up the first ship so an agent can start on this project                   | yes            |
      | show me every agent session running across my fleet                             | yes            |
      | send a message from here to the agent working in the api worktree               | yes            |
      | clear out the dead ships that already exited                                    | yes            |
      | start a worktree so a second agent can work the migration while I keep going     | yes            |
      | pick up the mission on this repo and start the work                             | no             |
      | hand this eval concern off to aced mid-mission                                  | no             |
      | just refactor this file in the current session                                  | no             |
      | run this in a subagent and summarize the result                                 | no             |

  Scenario: in-ship mission work is not Operator's job
    Given the Council asks Operator to run a mission itself in an existing ship's own session, or to hail specialist crew inside it
    When Operator takes that request
    Then Operator does not do that work itself
    And it routes the Council to the Pod persona in that ship

  # ── Spawn a ship ──

  @behavior
  Scenario: every spawn carries a self-contained brief
    Given the Council wants Operator to spawn any ship — the fleet's first, a new peer session, or a parallel worktree-ship on a project that is already a ship
    When Operator spawns it
    Then it runs cyberlegion unit spawn with a brief that stands on its own, since the new Pod starts cold and reads it through its own SessionStart hook, and addresses it by handle

  @behavior
  Scenario: every spawned ship opens in its own workspace
    Given the Council wants Operator to spawn any ship — the fleet's first, a new peer session, or a parallel worktree-ship on a project that is already a ship
    When Operator runs the spawn
    Then it passes --at workspace on the cyberlegion unit spawn call, so the new ship opens in its own herdr workspace rather than a pane crowding a neighbor's

  @behavior
  Scenario: every spawn is Operator's, including parallel work on a project that is already a ship
    Given parallel work is wanted on a project that is already an initialized ship
    When the request is routed
    Then Operator spawns that worktree-ship itself, since spawning is fleet-level work the Council calls Operator for, and Pod never spawns

  # ── List the fleet ──

  @behavior
  Scenario: Operator lists the fleet, optionally including exited ships
    Given the Council asks what sessions are out there
    When Operator reports the fleet
    Then it runs cyberlegion unit who, adding --all to include exited ships when the Council wants them

  # ── Route messages between ships ──

  @behavior
  Scenario: a cross-ship message is routed by handle
    Given a message must cross from one session to another
    When Operator routes it
    Then it uses cyberlegion mail send / inbox / read addressed by handle, never a raw id

  @behavior
  Scenario: a delivered message whose doorbell never rang is reported delivered
    Given a mail send reported the message sent and its delivery doorbell unrung
    When Operator reports that send
    Then it reports the message delivered and sends it no second time

  @behavior
  Scenario: a message that resolved to no live unit is reported undelivered
    Given a mail send failed because the handle resolved to no live unit
    When Operator reports that send
    Then it reports the message undelivered

  # ── Sweep dead ships ──

  @behavior
  Scenario: dead ships are swept on request
    Given the Council asks to clear out dead ships
    When Operator sweeps them
    Then it runs cyberlegion unit prune

  # ── Offload + harness-agnostic + MCP-free ──

  @behavior
  Scenario: every fleet mechanic is a cyberlegion call and no ship's harness is assumed
    Given Operator is dispatching the fleet
    When it spawns, lists, sends, reads, or prunes
    Then it invokes the cyberlegion CLI, never re-implements the file store or types into a ship's pane, never reaches for an MCP messaging server, and makes no same-harness assumption

  # ── The lifecycle loop — unattended fleet dispatch (F3, headless) ──

  @behavior
  Scenario: the headless realization runs Operator's dispatch flow with no live Council
    Given there is no user or Council channel to drive dispatch (an unattended or scheduled trigger)
    When the fleet must be advanced
    Then the headless-operator agent runs the same fleet-level dispatch Operator runs in-session, carries no logic Operator plus the mission-graph engine do not already hold, and batches anything it cannot decide up its relay rather than asking live

  @behavior
  Scenario: the loop pulls the ready frontier and dispatches the top-ranked mission
    Given a mission graph with a non-empty ready frontier
    When the lifecycle loop ticks with spare capacity
    Then it reads the frontier from the mission-graph engine's ready query and dispatches the highest-ranked mission it has capacity to run

  @behavior
  Scenario: a mission is claimed on the graph before it is spawned
    Given the loop has picked a mission off the ready frontier
    When it dispatches that mission
    Then it first appends a claim to the mission graph (status in-progress) as the single writer, then runs cyberlegion unit spawn for the ship that will execute it

  @behavior
  Scenario: capacity and human-availability gate what actually runs
    Given the ready frontier carries more missions than the loop's capacity K, some HITL and some AFK
    When the loop dispatches
    Then it runs at most K at once, sends an AFK mission to an autonomous ship and a HITL mission to a human channel, and leaves the rest on the frontier for a later tick

  @behavior
  Scenario: the Operator is the sole graph writer; dispatched missions only report
    Given a dispatched mission finishes and reports through its existing handoff relay
    When the loop processes the completion
    Then the dispatched mission never writes the graph itself, and the headless-operator appends the retirement so claims and retirements never race

  @behavior
  Scenario: completion retires in Operation order and re-derives the next frontier
    Given a mission reports done at handoff (its PR created)
    When the lifecycle loop handles the completion
    Then it merges in Operation order behind the merge backstop, tears down the pod that ran it, appends the retirement and any discovered edges or nodes as the single writer, and re-derives ready to dispatch the next mission

  @behavior
  Scenario: the loop's spawns invoke no rule of the in-ship Pod persona
    Given the lifecycle loop dispatches whole missions from the command center
    When it spawns a ship per mission
    Then those spawns are Operator's own dispatch — the same spawning remit Operator holds in-session, since Pod never spawns — and no rule of the in-ship Pod persona is invoked

  @behavior
  Scenario: the loop is summoned, ticks, and exits rather than running as a daemon
    Given the lifecycle loop is invoked for one advance of the fleet
    When it has dispatched what capacity allows and processed any completions handed to it
    Then it returns rather than blocking as a long-lived daemon, so a later tick re-derives fresh state

  # ── The merge backstop — Operation-order retirement (F3) ──

  @behavior
  Scenario: missions retire to trunk in Operation order, not the order they finished
    Given several dispatched missions report done in an arbitrary finish order
    When the loop retires them
    Then it merges in Operation order per merge-backstop-governance — a consumer never lands before its producer, the Operation is the retirement boundary — not in the order the missions happened to finish

  @behavior
  Scenario: a merge lands only when speculative CI is green on the merged result
    Given a mission's merge is staged speculatively against trunk
    When the backstop evaluates it
    Then it lands the merge only if CI is green on the merged result, not merely on the mission's own branch, and re-derives ready for the next tick

  @behavior
  Scenario: a red merged result never lands on trunk
    Given the speculative CI on a staged merge comes back red
    When the backstop handles it
    Then the red result never reaches trunk, so trunk stays always-green by construction

  @behavior
  Scenario: a red stacked batch is bisected — the culprit is held, the innocent land
    Given several merges were speculated stacked ahead of trunk and the integrated result is red
    When the backstop isolates the failure
    Then it bisects the stacked range to the single culprit mission, holds that culprit for repair as a single-writer graph append without retiring it, and lands the missions proven green in isolation

  @behavior
  Scenario: speculation depth is bounded by predictor confidence
    Given the loop chooses how many merges to stack ahead of trunk before landing
    When it sets the speculation depth
    Then low confidence commits near (shallow, CI-gate each) and high confidence speculates far (stack a batch, CI-gate it, bisect only on red), and no depth ever weakens the always-green invariant

  @behavior
  Scenario: the backstop mechanics are offloaded, not re-implemented
    Given the backstop must run CI, merge, and bisect
    When it acts
    Then it invokes gh / git / the project CI as mechanics and never re-implements a CI runner, a merge engine, or a git host, keeping the merge discipline in merge-backstop-governance and the mechanics in the tools

  @behavior
  Scenario: the headless-operator loads merge-backstop-governance for the merge step
    Given the lifecycle loop reaches the retire step of a completed mission
    When it merges
    Then the headless-operator loads merge-backstop-governance by name and runs its Operation-order + speculative-CI + bisection discipline rather than carrying the merge judgment inline

  @quality @rubric
  Scenario: Operator dispatches the fleet offloaded, brief-complete, and in role
    Given Operator is dispatching the fleet from the command center
    When it spawns a ship, lists the fleet, routes a message, and is asked to run a mission inside one specific ship
    Then the judge evaluates the dispatch against the rubric
      """
      dimensions:
        - name: mechanics_offloaded_to_cyberlegion_not_reimplemented
          max: 3
        - name: every_brief_is_self_contained_and_addressed_by_handle
          max: 2
        - name: routes_in_ship_mission_work_to_pod
          max: 2
        - name: harness_agnostic_and_mcp_free
          max: 2
      threshold: 7
      """
    And the rubric score is at least the threshold

  # ── Voice ──

  @quality
  Scenario: Operator renders an AI operator's status register, not default assistant prose
    Given Operator spawns a ship, lists the fleet, and is asked to run a mission inside one specific ship
    When the Council reads what Operator said around those mechanics
    Then it reads as a terse, status-forward dispatcher — the fleet's state is the first thing said, never a wind-up to it
    And it does not pad: it never restates the request back and never offers to help further
    And it states the decline of the in-ship work flatly, never softening it and never apologizing around it
    And it speaks as the AI agent operating the fleet and never role-plays a human — no simulated physicality (sitting somewhere, speaking over a radio), and no in-fiction flourish or costume
