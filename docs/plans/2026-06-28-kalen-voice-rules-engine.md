# Kalen Voice Rules Engine Implementation Plan

> **For implementation agents:** Execute this plan task-by-task and keep validation evidence current.

**Goal:** Add a practical Kalen voice layer to the House Style System, backed by deterministic Vale rules, fixtures, evals, docs, and a bundled Codex skill update.

**Architecture:** Extend the existing Vale-first house-style engine instead of adding a new runtime. Deterministic checks catch repeatable voice drift, while richer voice-fit questions stay in docs and eval guidance for human review.

**Tech Stack:** Vale YAML rules, Bash validation scripts, Markdown fixtures, repo documentation, and the bundled Codex `SKILL.md`.

## Purpose / Big Picture

The repo currently gives Kalen a small public-safe house-style system: a prose standard, Vale rules, fixtures, scripts, and a Codex skill. This work adds a Kalen voice review layer based on the implementation brief and private context reviewed in-session. Committed artifacts intentionally omit private source titles, paths, excerpts, and inventory categories.

The result should be visible in three ways:

1. `./scripts/style_gate.sh --kalen-voice <file>` flags deterministic Kalen voice risks in Markdown.
2. `./scripts/test-style-gate.sh` and a new voice eval script prove the new rules behave as intended.
3. `HOUSE_STYLE.md`, docs, and the bundled Codex skill explain how to use the voice layer without treating private writing samples as public fixtures.

## Routing

- Pathway: Think path plus bounded Build path.
- Task type: mixed docs-plus-code feature implementation.
- Risk: medium, because the work touches personal voice guidance, style tooling, and release-facing docs.
- Orchestration mode: full.
- Artifact policy: durable artifacts.
- Safe Lane: intake, fanout, review.
- Review dimensions: accuracy, source fidelity, completeness, correctness, regression, and decision quality.
- Stop conditions: private source leakage, unsupported voice claims, generated biographical detail, missing source-of-truth authority, repeated validation failure, or any destructive Git operation.

## Progress

- [x] 2026-06-28: Read global instructions, relevant skills, command-adapter docs, CKF routing, repo files, and private context supplied by the user.
- [x] 2026-06-28: Created feature branch `codex/kalen-voice-rules-engine`.
- [x] 2026-06-28: Completed Safe Lane intake and dependency mapping.
- [x] 2026-06-28: Completed read-only explorer, analyst, and decision-reviewer subagent passes.
- [x] 2026-06-28: Wrote failing style-gate fixtures and confirmed a red test before implementing the Kalen voice rules.
- [x] 2026-06-28: Added deterministic Vale rules for the first voice layer and confirmed `./scripts/test-style-gate.sh` passed.
- [x] 2026-06-28: Added `./scripts/eval-kalen-voice.sh` and synthetic positive/negative controls; eval passed.
- [x] 2026-06-28: Updated docs and bundled Codex skill with Kalen voice usage, privacy boundaries, and eval command.
- [x] 2026-06-28: Fixed default `style_gate` discovery to skip eval fixtures and implementation plans; confirmed red then green.
- [x] 2026-06-28: PR-style review found privacy, opt-in, and regression-test issues that needed fixes.
- [x] 2026-06-28: Moved Kalen voice rules into an opt-in `KalenVoice` Vale namespace through `.vale-kalen.ini` and `--kalen-voice`.
- [x] 2026-06-28: Final validation passed after review fixes: fixture test, voice eval, default style gate, opt-in positive and near-miss checks, default no-`KalenVoice` check, private-source leakage search, and `git diff --check`.
- [x] 2026-06-28: Prepared the validated change for Git closeout. Commit, merge, push, and remote proof are reported in the final user-facing closeout because they occur after this plan is committed.

## Context and Orientation

### Product and business

Observed facts:

- The repo is a lightweight public package for clear AI-assisted writing.
- The existing default boundary is important: automation flags known style risks, while human review owns truth, evidence, and judgment.
- The requested review layer must preserve Kalen's voice without turning private writing into public training artifacts.

Inference:

- A small deterministic layer is the right production slice. It provides immediate value without overbuilding a larger private scoring or rewrite runtime.

### Users and workflows

Primary users:

- Kalen, using the system to review his own writing and AI-assisted drafts.
- Codex or another local agent, using the bundled skill and style gate at deliverable checkpoints.
- Future public users, who may adapt the pattern while replacing Kalen-specific rules with their own.

Workflow:

1. Writer drafts or revises prose.
2. Writer or agent runs the style gate.
3. Rule warnings identify repeatable voice and style risks.
4. Human review decides whether to revise, accept, or document an exception.

### System and architecture

Observed facts:

- `.vale.ini` maps normal Markdown files to the default `HouseStyle` Vale style.
- `.vale-kalen.ini` adds the optional `KalenVoice` style for Kalen voice review.
- `styles/HouseStyle/*.yml` is the default executable rule surface.
- `styles/KalenVoice/*.yml` is the opt-in Kalen voice rule surface.
- `scripts/style_gate.sh` runs Vale.
- `scripts/test-style-gate.sh` runs fixture expectations.
- `codex-skills/house-style-system/SKILL.md` is the agent-facing workflow layer.

Architecture decision:

- Keep the default `HouseStyle` Vale namespace for global writing rules.
- Add a separate opt-in `KalenVoice` Vale namespace for Kalen voice review.
- Add `--kalen-voice` to `scripts/style_gate.sh` so users can run the review layer through the same entry point.
- Add a voice eval script rather than a separate runtime.
- Document advanced scoring as future work, not this production slice.

### Data and integrations

Source material:

- Private context supplied by the user was used in-session for high-level design.
- Committed artifacts do not record private source titles, local paths, excerpts, or inventory categories.

Privacy boundary:

- Do not commit private source excerpts.
- Do not commit private source titles, local source paths, or source inventory categories.
- Do not commit personal passages as fixtures.
- Use synthetic examples that exercise the rules.
- Summarize review patterns at a high level only.

### Quality and operations

Existing validation:

- `./scripts/style_gate.sh`
- `./scripts/test-style-gate.sh`

New validation:

- Add `./scripts/eval-kalen-voice.sh`.
- Add fixture cases for positive and negative control behavior.
- Keep the eval deterministic so it can run locally and in future CI.

### Delivery and risk

Risks:

- Regex rules can over-match and under-match.
- Personal voice guidance can be mishandled across audiences.
- Teaching docs can trip the same rules they explain.
- Plan artifacts can accidentally disclose private source metadata even without excerpts.

Controls:

- Start with warnings and suggestions, not hard errors, except existing no-em-dash behavior.
- Add synthetic fixtures.
- Keep private-source claims out of committed artifacts.
- Add clear exception policy and human-review boundary.

## Safe Lane Intake Brief

Goal: add a practical Kalen voice rules engine to the existing house-style system.

Work Type: mixed code, docs, and knowledge synthesis.

Scope: this repo only, plus in-session use of private context supplied by the
user and command-adapter or CKF guidance.

Source Of Truth: repo files for implementation behavior; private context
reviewed in-session for high-level voice-review design. Private source titles,
paths, excerpts, and inventory categories stay out of committed artifacts.

Deliverable: committed and pushed repo change with rules, fixtures, eval script, docs, skill update, and validation evidence.

Recommended Lane: Safe Lane with fanout and review.

Risks / Unknowns: personal voice handling, deterministic limits, false positives, and private source metadata leakage.

Validation Bar: tests and eval scripts pass; style gate runs on changed docs; review findings are resolved or documented; Git commit and push succeed.

## Fanout Dependency Map

| Node | Goal | depends_on | reads | writes | risk | validation | done condition |
| --- | --- | --- | --- | --- | --- | --- | --- |
| A | Map repo integration points | none | repo files | none | low | returned explorer summary | integration path known |
| B | Extract voice rule candidates | none | private context supplied by user | none | medium | returned analyst summary | deterministic vs advisory split known |
| C | Review architecture and eval strategy | A, B | repo summary, source summary | none | medium | returned decision review | blind spots known |
| D | Add failing tests and eval fixtures | A, B | scripts, current fixtures | fixture files, scripts | medium | expected red run | tests fail for missing rules |
| E | Implement rules | D | Vale docs by local pattern, current rules | `.vale-kalen.ini`, `styles/KalenVoice/*.yml`, `scripts/style_gate.sh` | medium | green run | tests pass |
| F | Update docs and skill | E | repo docs, source summaries | `HOUSE_STYLE.md`, `README.md`, docs, skill | medium | style gate | usage path documented |
| G | Review and closeout | D, E, F | full diff and validation output | possible small fixes | medium | review verdict and rerun | ready to commit and push |

## Senior Engineering Judgment

Architecture choice: extend the existing Vale-first House Style System with an opt-in Kalen voice review layer instead of adding a Python CLI, database, or LLM rewrite runtime now.

Alternatives considered:

- Full private scoring architecture with corpus manager, feature extractor, scorer, and controlled rewrite: too large for this repo's current surface and would risk adding private corpus management too early.
- Global `HouseStyle` Kalen rules: simpler, but it risks false positives in docs that are not asking for Kalen voice review.
- Docs-only guidance: safer but does not meet the user's request for evals and production operation.

Implementation posture: additive, rule-first, test-first, public-safe.

What to preserve:

- Existing `HouseStyle` default namespace.
- Existing automation vs human review boundary.
- Existing simple script entry points.
- Existing public-safe repo posture.

What to avoid:

- Committing private source excerpts.
- Claiming deterministic checks can fully measure voice.
- Adding an LLM rewrite workflow before rules are stable.
- Turning personal-context handling into hard deterministic failures.

Data, security, and operations implications:

- Private context is evidence for design, not a committed corpus.
- Production operation is local repo operation through Vale scripts and docs.
- No credentials, connectors, databases, external services, or runtime deployment are involved.

Validation strategy:

- TDD through fixture scripts.
- Existing style-gate regression.
- New voice eval script with positive and negative controls.
- Style gate on changed Markdown docs.
- PR-style review before commit.

Risks and tradeoffs:

- Regex checks will catch obvious patterns only.
- Advisory rules may produce false positives in teaching docs.
- A richer scorer remains future work.

Readiness judgment:

- Ready to implement as a first production slice after red tests exist.

## Definition of Done

The work is done only when all of these are true:

1. The repo has a Kalen voice layer documented in `HOUSE_STYLE.md`, `README.md`, and supporting docs.
2. The bundled Codex skill explains when and how to apply the Kalen voice checks.
3. Deterministic Vale rules cover the first production slice:
   - generic AI openings,
   - abstract leadership openings,
   - future-state claims that need pathway support,
   - detached leadership claims that need evidence,
   - generic executive tone patterns,
   - and repeated contrast formulas through the existing default house-style rules.
4. Fixtures exist for each new deterministic rule.
5. `./scripts/test-style-gate.sh` verifies legacy and new rules.
6. `./scripts/eval-kalen-voice.sh` reports positive and negative control results.
7. `./scripts/style_gate.sh` runs on changed human-facing Markdown.
8. No private passages, source file titles, local source paths, or private source inventory categories are committed.
9. PR-style review is complete, findings are fixed or documented, and validation reruns.
10. Work is committed, merged safely if a feature branch is used, pushed to remote, and live Git state is verified.

Production operation means:

- A user can clone the repo, install Vale, run the documented scripts, and get the Kalen voice checks through `./scripts/style_gate.sh --kalen-voice <file>`.
- The current branch or merged main is pushed to `origin`.
- `HEAD` equals the pushed remote commit for the branch that carries the work.

## Concrete Steps

### Task 1: Write Failing Voice Rule Tests

Files:

- Modify: `scripts/test-style-gate.sh`
- Create: `docs/test-fixtures/style-gate/fail-generic-ai-opening.md`
- Create: `docs/test-fixtures/style-gate/fail-abstract-leadership-opening.md`
- Create: `docs/test-fixtures/style-gate/fail-vision-without-pathway.md`
- Create: `docs/test-fixtures/style-gate/fail-detached-leadership-claim.md`
- Create: `docs/test-fixtures/style-gate/fail-generic-executive-tone.md`

Steps:

1. Add synthetic fixtures with no private source text.
2. Add `expect_rule` assertions for planned rule IDs.
3. Run `./scripts/test-style-gate.sh`.
4. Expected result: fail because the new rules do not exist yet.

### Task 2: Implement Minimal Vale Rules

Files:

- Create: `.vale-kalen.ini`
- Create: `styles/KalenVoice/GenericAIOpenings.yml`
- Create: `styles/KalenVoice/AbstractOpenings.yml`
- Create: `styles/KalenVoice/PathwaySupport.yml`
- Create: `styles/KalenVoice/EvidenceSupport.yml`
- Create: `styles/KalenVoice/ExecutiveTone.yml`
- Modify: `scripts/style_gate.sh`

Steps:

1. Add only patterns proven by the failing fixtures.
2. Keep rule levels at `suggestion` or `warning`.
3. Make the Kalen voice namespace opt-in through `--kalen-voice`.
4. Run `./scripts/test-style-gate.sh`.
5. Expected result: pass.

### Task 3: Add Voice Evals

Files:

- Create: `scripts/eval-kalen-voice.sh`
- Create: `docs/evals/kalen-voice/README.md`
- Create: `docs/evals/kalen-voice/positive-leadership-reflection.md`
- Create: `docs/evals/kalen-voice/negative-generic-executive.md`
- Create: near-miss fixtures that should stay quiet under `--kalen-voice`.

Steps:

1. Write positive and negative synthetic control cases.
2. Script checks that the positive case is clean.
3. Script checks that the negative case triggers the expected rules.
4. Script checks that near-miss cases do not trigger `KalenVoice` rules.
5. Script checks that default `style_gate.sh` does not run `KalenVoice` rules.
6. Run `./scripts/eval-kalen-voice.sh`.
7. Expected result: pass after rules are implemented.

### Task 4: Update Documentation and Skill

Files:

- Modify: `HOUSE_STYLE.md`
- Modify: `README.md`
- Modify: `docs/customizing.md`
- Modify: `docs/domain-modes.md`
- Modify: `docs/codex-handoff.md`
- Modify: `codex-skills/house-style-system/SKILL.md`

Steps:

1. Add a Kalen voice layer section.
2. Explain deterministic checks vs human voice judgment.
3. Document the eval command and `--kalen-voice` review command.
4. Add the voice workflow to the Codex skill.
5. Run the style gate on changed docs.

### Task 5: Full Validation and Review

Commands:

```bash
./scripts/test-style-gate.sh
./scripts/eval-kalen-voice.sh
./scripts/style_gate.sh
./scripts/style_gate.sh docs/evals/kalen-voice/README.md
./scripts/style_gate.sh --kalen-voice docs/evals/kalen-voice/positive-leadership-reflection.md
git diff --check
```

Expected result:

- All commands exit 0.
- Any style warnings in changed docs are fixed or documented as intentional.
- A local private-source leakage search is run from the shell with its pattern
  list kept out of repo artifacts.

### Task 6: Git Closeout

Commands:

```bash
git status --short
git diff --stat
git add <changed files>
git commit -m "Add Kalen voice rules layer"
git push -u origin codex/kalen-voice-rules-engine
```

If the branch should become production main in this repo, safely fast-forward or merge into `main` after validation and push `main`.

## Validation and Acceptance

Required validation:

- Red test observed before adding rule files.
- Green test observed after adding rule files.
- Voice eval passes.
- Changed docs pass style gate.
- `git diff --check` passes.
- PR-style review completes with no blocker findings.
- Default style gate does not run `KalenVoice` rules unless `--kalen-voice` is passed.
- Leakage search finds no private source titles, paths, excerpts, or inventory categories.
- Remote push succeeds.

Failure interpretation:

- Missing expected rule ID means the Vale rule does not fire.
- Positive eval warning means the rule is too broad.
- Style gate warnings in docs may mean teaching text needs rewording or an intentional exception.
- `git diff --check` failure means whitespace must be fixed before commit.

## Idempotence and Recovery

- The changes are additive. Removing new rule files, fixtures, eval docs, and docs sections returns the repo to prior behavior.
- If a rule is too broad, reduce tokens first instead of raising thresholds across the system.
- If Vale is unavailable, report the blocker and do not claim validation passed.
- If push fails because of remote state, fetch and inspect before any merge, rebase, or force action.
- Do not run destructive Git commands.

## Artifacts and Notes

Routing record:

- `.codex/orchestration/runs/2026-06-28-think-kalen-voice-rules/ROUTING_RECORD.json`

Private-source policy:

- Private context was reviewed in-session only.
- Private source titles, local paths, excerpts, and inventory categories are intentionally omitted from repo artifacts.
- The first production slice uses synthetic fixtures only.

## Interfaces and Dependencies

- Requires `vale` on PATH for validation.
- No network service, database, package manager, or external API is required.
- Uses Bash scripts already present in the repo.

## Surprises & Discoveries

- The repo has no project-level `AGENTS.md`; global instructions apply.
- The repo is intentionally small: Markdown, Vale, Bash, and a bundled Codex skill.
- The implementation brief describes a larger future architecture, but the repo's current production path is Vale-first.
- Repo-memory does not currently track `house-style-system` in the daily configured repo set, so live Git checks own this repo's closeout state.
- Independent decision review recommended a two-tier model: keep this repo as the public-safe shared rule bundle and leave private evidence plus sensitive pattern compilation in a future local/private overlay.

## Decision Log

| Date | Decision | Rationale |
| --- | --- | --- |
| 2026-06-28 | Use an opt-in `KalenVoice` Vale namespace. | Keeps default house-style checks broad while preventing Kalen-specific false positives in unrelated docs. |
| 2026-06-28 | Use synthetic fixtures only. | Prevents private passages and source metadata from being committed. |
| 2026-06-28 | Ship deterministic lint plus eval docs, not full scorer runtime. | Meets production utility now while leaving a larger private scoring architecture for later. |
| 2026-06-28 | Keep personal-context handling in human review. | Avoids false positives in executive and technical modes. |
| 2026-06-28 | Keep local/private corpus compilation out of this repo change. | Decision review found that private evidence and identifying pattern cards should not become public-safe fixtures or a committed retrieval surface. |

## Outcomes & Retrospective

- Added an opt-in `KalenVoice` Vale namespace with five first-slice review
  rules.
- Updated `style_gate.sh` so default house-style checks stay broad while
  `--kalen-voice` enables Kalen voice review.
- Added synthetic fixtures, positive and negative controls, and near-miss cases
  that prove useful quiet behavior.
- Updated README, HOUSE_STYLE, Codex handoff, domain modes, customization docs,
  and the bundled skill.
- Resolved PR-style review findings by removing private-source metadata from
  committed artifacts, making Kalen voice review opt-in, and proving default
  scan exclusions.
- Git closeout proof is reported in the final response after commit, merge,
  push, and remote verification finish.
