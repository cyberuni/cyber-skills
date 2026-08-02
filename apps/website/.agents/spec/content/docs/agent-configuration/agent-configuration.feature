Feature: agent-configuration — the instruction-writing section

  The section gets a reader from "I want to write better instructions" to the axis that
  answers their question, and back out to the sibling axis. It owns reachability from its
  entry page and the integrity of its internal cross-references; it owns neither the prose
  nor the site's frontmatter, routing, or sidebar.

  # ── U1 — Reach an axis from the hub ──

  Scenario: the hub links a topic that has its own page
    Given the section's entry page lists "Purpose" as a row in its instruction-topics table
    And the section contains an axis page titled "Purpose"
    When the entry page's cross-references are inspected
    Then that row contains a link to the "Purpose" axis page

  Scenario: the hub covers a page-less topic inline
    Given the section's entry page lists "Word choice" as a row in its instruction-topics table
    And the section contains no axis page titled "Word choice"
    When the entry page's cross-references are inspected
    Then that row contains no link
    And that row carries a description of the topic

  Scenario: every axis page is reachable from the hub
    Given the section contains the axis pages titled "Purpose" and "Target"
    When the entry page's instruction-topics table is inspected
    Then the table contains a row linking to each of those axis pages

  # ── U2 — Follow an internal link ──

  Scenario: a route-form link resolves under the base path
    Given a section page contains the internal link "/agent-configuration/instruction-purpose/"
    And the site is built with the base path "/cyberplace/"
    When the built output is inspected
    Then the link points at a page that exists in the built output

  Scenario: a relative link whose target is missing is broken
    Given the section's entry page contains the internal link "../instructions.md"
    And the content collection contains no file named "instructions.md" at that location
    When the section's cross-references are inspected
    Then the link is reported as broken

  Scenario: a relative link is flagged even when its target exists
    Given a section page contains an internal link written as a relative file path
    And the content collection contains the file that link names
    When the section's cross-references are inspected
    Then the link is reported as violating the section's route-form convention

  # ── U3 — Return from an axis page ──

  Scenario: an axis page routes the reader to its sibling axis
    Given the axis page titled "Target" carries a "Related" list
    When that list is inspected
    Then it contains a link to the "Purpose" axis page
    And it contains a link to the section's entry page

  Scenario: an axis page without a Related list is a dead end
    Given the section contains an axis page consisting of a title and body prose only
    When the section's cross-references are inspected
    Then that page is reported as a dead end
