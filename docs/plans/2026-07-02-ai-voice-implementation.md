# AI Voice Implementation Plan

Date: 2026-07-02

## Purpose / Big Picture

Implement the approved Definition of Done for AI voice avoidance in this repo.
The user-visible result is a separate deterministic `AIVoice` Vale layer, a
review wrapper, fixtures, evals, and aligned source documents for the ChatGPT
writing Project and Codex skills.

## Routing

- Pathway: Build
- Task type: docs and rules implementation
- Risk: medium
- Quality mode: deep review
- Specialist review: accuracy, completeness, quality
- Stop rules: stop for destructive commands, missing source of truth, repeated
  validation failure that is not understood, or owner decisions about merging
  `AIVoice` into another layer.

## Progress

- [x] Read project instructions and current assessment.
- [x] Verified repo state and remote state before durable edits.
- [x] Add `AIVoice` Vale layer and config.
- [x] Add wrapper and eval script.
- [x] Add fail fixtures and near-miss controls.
- [x] Update documentation and skill guidance.
- [x] Install the optional `house-style-system` Codex skill locally.
- [x] Run validation.
- [x] Complete specialist review and resolve findings.
- [x] Commit and push.

## Context and Source of Truth

Primary sources:

- `docs/runbook-integration-assessment.md`
- `docs/chatgpt-project/ai-voice-avoidance-runbook.md`
- `HOUSE_STYLE.md`
- `docs/domain-modes.md`
- `codex-skills/house-style-system/SKILL.md`
- `styles/HouseStyle/`
- `styles/KalenVoice/`
- `scripts/style_gate.sh`
- `scripts/test-style-gate.sh`
- `scripts/eval-kalen-voice.sh`
- installed local skill copied from `codex-skills/house-style-system/SKILL.md`

Observed implementation facts:

- `HouseStyle`, `KalenVoice`, and `AIVoice` are the current Vale layers.
- `PathwaySupport.yml`, `EvidenceSupport.yml`, and the new `AIVoice` rules are
  narrow and fixture-shaped.
- `docs/chatgpt-project/ai-voice-avoidance-runbook.md` is source guidance.
  Exact disliked phrases are enforced by deterministic rules. Context-sensitive
  cases stay in human review.
- The installed local skill now matches
  `codex-skills/house-style-system/SKILL.md`.

## Constraints

- Keep style warnings as review prompts. Do not claim AI authorship detection.
- Keep `AIVoice` separate from `HouseStyle` and `KalenVoice` unless the owner
  later approves merging.
- Do not commit private writing samples.
- Do not use destructive commands.
- Keep default `./scripts/style_gate.sh` clean.

## Plan of Work

1. Add `styles/AIVoice/` rules for the runbook patterns.
2. Add `.vale-ai-voice.ini` and `scripts/review-ai-voice.sh`.
3. Add deterministic fixtures under `docs/test-fixtures/style-gate/`.
4. Add `docs/evals/ai-voice/` near-miss controls and `scripts/eval-ai-voice.sh`.
5. Extend `scripts/test-style-gate.sh`.
6. Update `HOUSE_STYLE.md`, `docs/domain-modes.md`, ChatGPT Project docs, and
   `codex-skills/house-style-system/SKILL.md`.
7. Clean `docs/runbook-integration-assessment.md` so default style gate passes.
8. Run validation and specialist reviews.
9. Commit and push.

## Validation and Acceptance

Required commands:

```sh
./scripts/style_gate.sh
./scripts/test-style-gate.sh
./scripts/eval-kalen-voice.sh
./scripts/eval-ai-voice.sh
git diff --check
```

Acceptance criteria:

- AI voice runbook patterns are represented by deterministic rules or documented
  as human-only.
- Each new deterministic rule has a failing fixture and a near-miss control.
- Default style gate passes cleanly.
- Kalen voice eval still passes.
- AI voice eval passes and catches the bracketed examples.
- `HOUSE_STYLE.md`, `docs/domain-modes.md`, ChatGPT Project docs, repo skill,
  and installed-skill plan agree.
- No rule claims to detect authorship.

## Surprises & Discoveries

- Source-fidelity review found that broad ownership and `the work` rules
  overreached the runbook caveats. The rules were narrowed and new near-miss
  controls were added.
- Quality review found a Kalen voice regression around supported
  `future state` language. The broad token was removed and a supported
  future-state control was added.
- `scripts/style_gate.sh` needed safer flag parsing after adding `--ai-voice`.
  The script now rejects mixed voice layers instead of silently choosing the
  last one.

## Decision Log

- 2026-07-02: Keep `AIVoice` as a separate optional Vale layer to preserve
  boundaries and reduce default false positives.
- 2026-07-02: Keep the deterministic `EmptyWorkNouns` rule tied to the exact
  lesson-frame phrase from the runbook. Leave broader `the work` cases to human
  review.

## Idempotence and Recovery

- New rules and fixtures are additive.
- If a rule is too noisy, lower its scope or leave the pattern as human-only in
  docs.
- If validation fails, inspect exact Vale output before changing rules.
- If remote changes appear before push, fetch and rebase only when the working
  tree is safely committed.

## Outcomes & Retrospective

- Added an optional `AIVoice` Vale layer, `.vale-ai-voice.ini`,
  `scripts/review-ai-voice.sh`, and `scripts/eval-ai-voice.sh`.
- Added canonical disliked phrases to the AI voice runbook and covered them
  with deterministic fail fixtures.
- Added grounded near-miss controls for ownership, movement language, role-fit
  wording, contextual `the work`, and supported future-state language.
- Updated `HOUSE_STYLE.md`, `docs/domain-modes.md`, ChatGPT Project docs,
  repo handoff docs, customization docs, and the repo Codex skill.
- Validation passed:
  - `./scripts/style_gate.sh`
  - `./scripts/test-style-gate.sh`
  - `./scripts/eval-kalen-voice.sh`
  - `./scripts/eval-ai-voice.sh`
  - `git diff --check`
- Source-fidelity, quality, and completeness reviews reported ready after
  fixes.
