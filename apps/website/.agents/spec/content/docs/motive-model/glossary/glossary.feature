Feature: glossary — the Motive Model glossary

  A reference page. The Motive Model is a vocabulary before it is an argument, and this is
  where each term's sense is settled: the section pages spend the vocabulary, this page holds
  it. A reader resolves any term from this page alone, following only backward references.

  Scenarios assert which terms are defined, that each resolves on the page, and that the
  dependency-order guarantee holds. They freeze neither the order of the terms, the wording of
  any definition, nor which examples an entry reaches for.

  # ── T1 / T2 — Mid-read term-checker ──

  Scenario: the glossary resolves without prerequisite reading
    Given the reference page exists at apps/website/src/content/docs/motive-model/glossary.md
    And a reader who has read no other page of the Motive Model
    When a reader looks up any single term
    Then the entry is intelligible without having read another document first
    And no entry instructs the reader to read another page before it can be understood

  Scenario: every term an entry leans on is defined on the page
    Given an entry whose definition uses another term of the model
    When that entry is read
    Then each model term it uses has its own entry on this page
    And resolving it requires opening no other document

  Scenario: each term is defined in exactly one entry
    Given the page's set of entries
    When the terms they define are listed
    Then no two entries define the same term
    And a term already defined may still appear inside other entries' definitions

  Scenario: each entry states its kind and what separates it from its nearest neighbor
    Given a reader who cannot tell two terms of the model apart
    When either term's entry is read
    Then it states what kind of thing the term is
    And it names a neighboring term and states what separates the two

  # ── B1 / B2 — Vocabulary bootstrapper ──

  Scenario: no entry relies on a term defined later on the page
    Given a reader reading the page forward from the top
    When each entry is checked against the entries preceding it
    Then every model term it relies on has already been defined above it
    And no entry forward-references a term defined below it

  Scenario: every load-bearing term the model names has an entry
    Given the term set named by the project spec's Glossary at artifacts/specs/motive-model/spec.md
    When the page's entries are compared against that set
    Then each term in that set has an entry on this page

  Scenario: the page states that its entries run in dependency order and each word means one thing
    Given a reader who does not yet know how the page is organized
    When the page is opened
    Then it states that the entries run in dependency order, earlier terms grounding later ones
    And it states that each term carries a single meaning
    And that statement is retrievable before the first entry is read

  # ── A1 / A2 / A3 — Vocabulary adopter ──

  Scenario: an entry whose sense departs from an established one names the departure
    Given a term the model reuses from an established outside usage
    When that term's entry is read
    Then it states that the model's sense differs from the established one
    And it states what the difference is

  Scenario: the four actors carry the names the project spec's body uses
    Given the four base actors as named in the body of artifacts/specs/motive-model/spec.md
    When the page's actor names are compared against those names
    Then each of the four actors appears under the same name
    And no alternative name is used for any of the four anywhere on the page

  Scenario: the page defines without re-running the argument
    Given a reader who wants the case for a claim rather than its definition
    When an entry compressing that claim is read
    Then the entry states the claim without reproducing the argument that establishes it
    And the case for it remains the business of the section page that owns it
