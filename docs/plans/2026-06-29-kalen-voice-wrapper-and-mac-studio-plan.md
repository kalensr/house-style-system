# Kalen Voice Wrapper And Mac Studio Update Plan

## Goal

Add a small wrapper so Kalen voice review can be run without remembering the
`--kalen-voice` flag. Also apply the house-style-system updates safely on Mac
Studio after Kalen approved the remote execution step. Public copies of this
plan summarize host-specific details instead of publishing aliases or local
paths.

The update path must not change credentials, broker policy, host services,
connector settings, or Model Context Protocol configuration.

## Context Orientation

### Product and business

- Observed: `house-style-system` is a public-safe writing quality framework.
- Observed: Kalen wants the Kalen voice rules available with less cognitive
  switching.
- Inference: A wrapper script is the smallest useful product change because it
  preserves the opt-in boundary while making the common command memorable.

### Users and workflows

- Primary user: Kalen, using the tool to check leadership, strategy,
  reflection, public essay, and executive prose.
- Agent user: Codex or another local agent, using the bundled skill and docs to
  choose the right command.
- Target workflow: run `./scripts/review-kalen-voice.sh <file>` instead of
  remembering `./scripts/style_gate.sh --kalen-voice <file>`.

### System and architecture

- Observed: `scripts/style_gate.sh` already owns Vale config selection.
- Observed: `.vale-kalen.ini` adds `KalenVoice` on top of `HouseStyle`.
- Decision: the wrapper delegates to `style_gate.sh --kalen-voice` rather than
  duplicating Vale logic.

### Data and integrations

- No new product data, credentials, or external product integrations.
- Execution used GitHub remote access and a bounded remote shell to a secondary
  workstation.
- The remote update plan began as documentation plus read-only host facts, then
  became the approved execution receipt for clone, validation, and skill refresh.
- Read-only remote evidence from 2026-06-29 confirmed the expected workstation,
  a missing repo checkout, and an existing local Codex skills directory.

### Quality and operations

- Existing validation: `./scripts/test-style-gate.sh`,
  `./scripts/eval-kalen-voice.sh`, `./scripts/style_gate.sh`, and
  `git diff --check`.
- New validation: test that the wrapper invokes `KalenVoice` rules and exits
  cleanly for the positive control.

### Delivery and risk

- Risk is low for repo behavior: wrapper delegates to existing script.
- Risk is medium for Mac Studio execution because it crosses host boundaries.
  The plan records clone-first, validate-first, and protected-system boundaries.

## Lifecycle Route

- Selected route: Mini ExecPlan plus goal-runner execution.
- Why this route: the wrapper is small, but the Mac Studio handoff needs a
  durable, safe, restartable plan.
- Stages required: orientation, Mini ExecPlan, critical review, implementation,
  validation, Git closeout if clean.
- Stages not required: product shaping, existing-code specification, Technical
  Design, subagent fanout.
- Material owner decisions: Kalen later approved the limited Mac Studio repo
  clone, validation, and skill refresh.
- Review point for Kalen: final closeout with commands, files, validation,
  Mac Studio proof, and plan path.

## Progress

- [x] 2026-06-29: Loaded requested `context-first-engineering` and
  `codex-goal-runner` skills.
- [x] 2026-06-29: Confirmed no project-level `AGENTS.md` or
  `AGENTS.override.md` in this repo.
- [x] 2026-06-29: Inspected current `README.md`, scripts, Codex handoff,
  customization docs, and broker handoff boundaries.
- [x] 2026-06-29: Ran repo-memory read-only checks. Output is advisory only and
  made no mutations.
- [x] 2026-06-29: Ran read-only secondary workstation reachability check.
- [x] 2026-06-29: Created `scripts/review-kalen-voice.sh`.
- [x] 2026-06-29: Added wrapper checks to `scripts/test-style-gate.sh`.
- [x] 2026-06-29: Updated README, house style, handoff docs, customization docs,
  eval docs, domain modes, and bundled skill to prefer the wrapper.
- [x] 2026-06-29: Wrote safe Mac Studio update plan at
  `docs/plans/2026-06-29-mac-studio-house-style-update.md`.
- [x] 2026-06-29: Validation passed: fixture test, Kalen voice eval, default
  style gate, explicit changed-docs style gate, wrapper positive smoke, and
  `git diff --check`.
- [x] 2026-06-29: Pull-request-style review of the wrapper found no blockers.
  Wrapper delegates to the existing `style_gate.sh --kalen-voice` path, and
  docs preserve opt-in scope.
- [x] 2026-06-29: Remote execution found a portability bug: Vale emitted
  colored counts remotely, which broke exact clean-output checks. Updated
  `scripts/style_gate.sh` to default automation output to `NO_COLOR=1`.
- [x] 2026-06-29: Committed and pushed portability fix as `263df61`.
- [x] 2026-06-29: Cloned repo on the secondary workstation, pulled `main`, ran validation,
  refreshed installed Codex skill with `rsync -a`, and confirmed wrapper
  reference in the installed skill.
- [x] 2026-06-29: Recorded summarized remote proof at
  `docs/evidence/2026-06-29-mac-studio-house-style-rollout.md`.
- [x] 2026-06-29: Prepared final execution receipt for commit and push after
  validation passed.

## Files To Inspect Or Edit

- `scripts/style_gate.sh`
- `scripts/test-style-gate.sh`
- `scripts/eval-kalen-voice.sh`
- `scripts/review-kalen-voice.sh`
- `README.md`
- `docs/codex-handoff.md`
- `docs/customizing.md`
- `codex-skills/house-style-system/SKILL.md`
- `docs/plans/2026-06-29-mac-studio-house-style-update.md`

## Constraints

- Keep Kalen voice rules opt-in.
- Do not duplicate Vale config logic in the wrapper.
- Do not commit private writing samples.
- Remote live changes are limited to cloning or updating this repo and refreshing
  the installed Codex skill from the validated checkout.
- Do not edit credentials, broker policy, host services, connector settings, or
  Model Context Protocol settings.
- Do not use destructive Git commands.

## Plan Of Work

1. Add `scripts/review-kalen-voice.sh`.
2. Extend `scripts/test-style-gate.sh` with wrapper behavior checks.
3. Update docs and the bundled skill to use the wrapper as the preferred command.
4. Add a Mac Studio update plan with clone-first, verify-first, and skill-install
   gates.
5. Run validation and critical review.
6. Apply the update on Mac Studio after approval and record execution evidence.
7. Commit and push if validation passes.

## Validation

Run:

```sh
./scripts/test-style-gate.sh
./scripts/eval-kalen-voice.sh
./scripts/style_gate.sh
./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md
git diff --check
```

Expected:

- Fixture tests pass.
- Voice eval passes.
- Default style gate has 0 errors, warnings, and suggestions.
- Wrapper positive control has 0 errors, warnings, and suggestions.
- Whitespace check passes.

## Acceptance Criteria

- `./scripts/review-kalen-voice.sh <file>` works as the memorable Kalen voice
  review entry point.
- The wrapper is tested through `scripts/test-style-gate.sh`.
- README, handoff docs, customization docs, and bundled skill point users and
  agents to the wrapper.
- Mac Studio update plan exists and has safe stop conditions.
- Mac Studio update is limited to the approved repo clone or fast-forward pull
  and installed skill refresh.
- Validation is recorded and green.
- Work is committed and pushed if the repo remains clean.

## Critical Review

### Findings

- No blocker: wrapper delegates to the existing tested `style_gate.sh` path.
- No blocker: remote workstation updates are limited to the approved repo and
  installed skill path.
- Risk: docs could make the wrapper sound global. Mitigation: keep wording
  explicit that Kalen voice review is still opt-in.

### Open Questions / Assumptions

- Assumption: the repo should live in the expected user project directory if
  Kalen later approves applying the update.
- Assumption: installing or refreshing the bundled Codex skill should use a
  controlled copy from the checked-out repo, not direct editing in the installed
  skill directory.

### Initial Readiness Verdict

The wrapper plan was ready to execute after the initial review. Kalen later
approved the bounded Mac Studio update, and this file now records that execution
path.

## Idempotence And Recovery

- Re-running the wrapper is read-only except for Vale output.
- If wrapper validation fails, inspect `scripts/style_gate.sh --kalen-voice`
  first because the wrapper delegates there.
- If remote clone or pull fails, stop before install and report the exact
  git state.
- Copy the installed skill from the validated checkout only after local and
  remote validation pass.

## Surprises And Discoveries

- 2026-06-29: Remote Vale output included terminal color codes in the
  clean summary. The wrapper itself was clean, but `scripts/test-style-gate.sh`
  could not match the colored text. Defaulting the style gate to `NO_COLOR=1`
  keeps automation output stable across hosts.

## Outcomes And Retrospective

- Added `scripts/review-kalen-voice.sh` as the memorable wrapper for Kalen voice
  review.
- Added wrapper regression checks to `scripts/test-style-gate.sh`.
- Updated docs and the bundled Codex skill to prefer the wrapper.
- Added `docs/plans/2026-06-29-mac-studio-house-style-update.md` as the safe
  remote apply plan.
- During remote execution, fixed host-portable Vale output by setting
  `NO_COLOR=1` in `scripts/style_gate.sh`.
- Cloned the repo on the secondary workstation, validated it, and refreshed the
  installed Codex skill from the validated checkout.
- Git closeout proof is recorded in the final user-facing closeout because the
  final commit and push occur after this plan is edited.
