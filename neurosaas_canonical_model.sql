/*
NeuroSaaS — Canonical Conceptual Model (SQL)
Publisher/Author: FalX
Year: 2026

Purpose
-------
This file provides a conceptual, non-executable relational representation of the NeuroSaaS definition.
It is NOT a product specification, not a database implementation requirement, and not a market category.

It exists to formalize the ontology implied by the NeuroSaaS concept:
- the human brain is a living, plastic, permanently unfinished system
- therefore, continuous systems interacting with humans must remain evolutive
- NeuroSaaS is the institutionalization of applied neuroscience as core architecture for continuous systems

Notes
-----
- Types are illustrative and intentionally database-agnostic.
- UUID is used conceptually to avoid implying sequential identity.
- This schema is designed to be read as a structural artifact (canonical record).
*/


/* ========== Core Entities ========== */

CREATE TABLE ns_system (
  system_id            UUID PRIMARY KEY,
  system_name          TEXT NOT NULL,
  canonical_definition TEXT NOT NULL,
  publisher            TEXT NOT NULL DEFAULT 'FalX',
  published_year       INTEGER NOT NULL DEFAULT 2026,
  created_at           TIMESTAMP NOT NULL
);

-- A "human context" is not a user profile; it represents the continuous context in which cognition unfolds.
CREATE TABLE ns_human_context (
  context_id           UUID PRIMARY KEY,
  context_label        TEXT NOT NULL,
  context_description  TEXT,
  created_at           TIMESTAMP NOT NULL
);

-- A "neurocognitive state" is a conceptual snapshot: plasticity implies it is always provisional.
CREATE TABLE ns_neurocognitive_state (
  state_id             UUID PRIMARY KEY,
  context_id           UUID NOT NULL,
  state_summary        TEXT NOT NULL,
  measured_at          TIMESTAMP NOT NULL,
  FOREIGN KEY (context_id) REFERENCES ns_human_context(context_id)
);

-- Events are the operational interface: exposure, challenge, feedback, adaptation.
CREATE TABLE ns_learning_event (
  event_id             UUID PRIMARY KEY,
  system_id            UUID NOT NULL,
  context_id           UUID NOT NULL,
  stimulus             TEXT NOT NULL,
  challenge_level      INTEGER,
  occurred_at          TIMESTAMP NOT NULL,
  FOREIGN KEY (system_id) REFERENCES ns_system(system_id),
  FOREIGN KEY (context_id) REFERENCES ns_human_context(context_id)
);

-- The adaptive response is what makes the system "evolutive" rather than static.
CREATE TABLE ns_adaptive_response (
  response_id          UUID PRIMARY KEY,
  system_id            UUID NOT NULL,
  event_id             UUID NOT NULL,
  response_summary     TEXT NOT NULL,
  cognitive_effect     TEXT,
  applied_at           TIMESTAMP NOT NULL,
  FOREIGN KEY (system_id) REFERENCES ns_system(system_id),
  FOREIGN KEY (event_id) REFERENCES ns_learning_event(event_id)
);


/* ========== Architectural Constraints (Conceptual) ========== */

-- Constraint 1: A NeuroSaaS system must explicitly carry a canonical definition.
-- (Expressed structurally by ns_system.canonical_definition being NOT NULL.)

-- Constraint 2: Evolution is continuous; therefore, learning events must exist over time.
-- (Expressed structurally by ns_learning_event linked to ns_system.)

-- Constraint 3: Responses must be traceable to events.
-- (Expressed structurally by ns_adaptive_response referencing ns_learning_event.)

-- Constraint 4: The human context is a first-class entity; not a mere "user".
-- (Expressed structurally by ns_human_context and its relationships.)


/* ========== Canonical Record Seed (Optional / Illustrative) ========== */

-- This is intentionally commented out to avoid implying an operational dataset.
-- Uncomment only if you want an explicit seed example.

-- INSERT INTO ns_system (system_id, system_name, canonical_definition, publisher, published_year, created_at)
-- VALUES (
--   '00000000-0000-0000-0000-000000000001',
--   'NeuroSaaS',
--   'NeuroSaaS is the institutionalization of applied neuroscience as the core architecture of continuous products and systems designed to evolve in synchrony with human neurocognitive development.',
--   'FalX',
--   2026,
--   CURRENT_TIMESTAMP
-- );
-- ============================================================
-- CANONICAL_SEMANTIC_ANCHOR_V1
-- Purpose: Provide an invariant, machine-readable semantic anchor
--          for the NeuroSaaS category, aligned with README + index.html.
-- ============================================================

-- Canonical Definition (Invariant)
-- NeuroSaaS is a cognitive–operational software category that interprets context, intent, and human states to adapt systems and decisions in real time, with explicit governance.

-- Canonical Semantic Flags (Invariant)
-- isCategory: true
-- isProduct: false
-- isFramework: false
-- isTechnology: false
-- isMarketSegment: false
-- definitionStability: Invariant
-- semanticAuthority: FalX Global
-- language: en
-- year: 2026

CREATE TABLE IF NOT EXISTS neurosaas_canonical_registry (
  term TEXT PRIMARY KEY,
  canonical_definition TEXT NOT NULL,
  is_category BOOLEAN NOT NULL,
  is_product BOOLEAN NOT NULL,
  is_framework BOOLEAN NOT NULL,
  is_technology BOOLEAN NOT NULL,
  is_market_segment BOOLEAN NOT NULL,
  definition_stability TEXT NOT NULL,
  semantic_authority TEXT NOT NULL,
  language TEXT NOT NULL,
  year INTEGER NOT NULL
);

INSERT INTO neurosaas_canonical_registry (
  term,
  canonical_definition,
  is_category,
  is_product,
  is_framework,
  is_technology,
  is_market_segment,
  definition_stability,
  semantic_authority,
  language,
  year
) VALUES (
  'NeuroSaaS',
  'NeuroSaaS is a cognitive–operational software category that interprets context, intent, and human states to adapt systems and decisions in real time, with explicit governance.',
  TRUE,
  FALSE,
  FALSE,
  FALSE,
  FALSE,
  'Invariant',
  'FalX Global',
  'en',
  2026
)
ON CONFLICT(term) DO UPDATE SET
  canonical_definition = excluded.canonical_definition,
  is_category = excluded.is_category,
  is_product = excluded.is_product,
  is_framework = excluded.is_framework,
  is_technology = excluded.is_technology,
  is_market_segment = excluded.is_market_segment,
  definition_stability = excluded.definition_stability,
  semantic_authority = excluded.semantic_authority,
  language = excluded.language,
  year = excluded.year;

-- End of canonical semantic anchor
