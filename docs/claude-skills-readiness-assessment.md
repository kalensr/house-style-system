# Claude Skills Readiness Assessment

Date: 2026-07-02

Purpose: assess whether the `house-style-system` repo holds enough to build a
Skills package for Claude Chat, Claude Cowork, and Claude Code. Report the full
state of the directory, the deterministic style engine, and the AI voice
handling approach.

## Short Answer

Yes. There is enough here to build the package, and most of the design work is
already done. The existing Codex skill at
`codex-skills/house-style-system/SKILL.md` is the blueprint. Its format is
already Claude-compatible. The main work is packaging, path handling for three
runtimes, and one honest fix to how the AI voice rules detect patterns.

## What The Directory Contains

The repo is a three-layer writing quality system with a clear boundary.

1. Written standard: `HOUSE_STYLE.md`, `docs/domain-modes.md`,
   `docs/examples.md`, `docs/ai-authorship-boundary.md`,
   `docs/customizing.md`.
2. Deterministic style gate: Vale rules in `styles/`, three config files, and
   six scripts.
3. Human review boundary: stated repeatedly. The system never claims to detect
   authorship. Style signals are review prompts.

The Vale engine now has three rule families:

- `styles/HouseStyle/` (9 rules): em dashes, filler, weak modifiers, jargon,
  stock conclusions, sentence complexity, acronym candidates, and two contrast
  scaffolds. These run by default.
- `styles/KalenVoice/` (5 rules): generic openings, abstract leadership
  openings, pathway support, evidence support, executive tone. Opt-in through
  `--kalen-voice`.
- `styles/AIVoice/` (7 rules): role-fit framing, abstract business need,
  pattern-recognition opening, diagnostic adjective stack, vague consequence,
  coordinated abstraction, empty work nouns. Opt-in through `--ai-voice`.

Scripts:

- `style_gate.sh`, now a mode dispatcher for house, kalen, and ai layers
- `review-kalen-voice.sh`
- `review-ai-voice.sh`
- `eval-kalen-voice.sh`
- `eval-ai-voice.sh`
- `test-style-gate.sh`

The two voice layers are mutually exclusive. `style_gate.sh` rejects passing
both at once.

Fixtures and evals: 16 fail fixtures under `docs/test-fixtures/style-gate/`,
plus positive and near-miss controls under `docs/evals/kalen-voice/` and
`docs/evals/ai-voice/`. `test-style-gate.sh` and the two eval scripts assert on
all three families.

The AI voice layer is new. Git shows it landed today in commit `6d9acb7`
(`feat: add AI voice review layer`). It closes the implementation gap flagged in
`docs/runbook-integration-assessment.md`. The working tree is clean.

## The AI Voice Handling Approach

The approach is documented in three places that agree with each other:

- `docs/chatgpt-project/ai-voice-avoidance-runbook.md` holds the full method:
  the seven stop patterns, the watchword list, the seven-part repair recipe, and
  the recruiter-facing sentence order.
- `docs/chatgpt-project/project-instructions.md` and the Codex `SKILL.md`
  translate the runbook into operating instructions, including a
  `personal-positioning` mode that matches the runbook's recruiter order.
- `styles/AIVoice/` encodes the seven patterns as Vale rules with fixtures and
  near-miss controls.

The design principle is sound and consistent across the repo. Automation flags
repeatable surface patterns. Human review owns truth, evidence, judgment, and
voice fit. The `personal-positioning` mode correctly encodes form only, so it
stays reusable across any role.

## Honest Caveat: The AIVoice Vale Rules Are Brittle

The seven AIVoice rules match the runbook's literal example strings rather than
the general pattern. Examples:

- `CoordinatedAbstraction` fires only on the exact phrase `leadership visibility
  move together`.
- `DiagnosticAdjectiveStack` fires only on the exact sentence `technology was
  small, reactive, and heavily dependent on outside vendors`.
- `VagueConsequence` fires only on `created operating strain`. The runbook's
  wider watchwords (`strain`, `friction`, `complexity`, `risk`, `ownership`,
  `visibility`, `alignment`, `modernization` used as bare nouns) are not covered.
- `EmptyWorkNouns` fires only on the literal `the work is not only selecting or
  replacing systems`.

These rules pass their fixtures and the eval, but they will miss the same
pattern in real drafts that use different words. This is the exact brittleness
the runbook warns against: checking for a label instead of the observable
pattern. `RoleFitFraming` and `PatternRecognitionOpening` are the two most
generalizable of the set. The others are close to fixture-only.

This matters for the Skills package in a useful way. A Claude skill does not
depend on regex. Claude can apply the runbook's judgment directly and catch
these patterns semantically. That is stronger than the Vale rules for this
family. So the skill should treat the AIVoice Vale rules as a fast deterministic
first pass. The model should carry the general detection. The deterministic gate
stays the right tool for the mechanical HouseStyle checks, where regex is
reliable.

## Fit For Each Runtime

The one Codex `SKILL.md` can serve all three Claude surfaces from a single
source, with runtime-aware behavior.

- Claude Code: full fidelity. It has a shell and file access, so it can run
  `style_gate.sh`, `review-ai-voice.sh`, and the evals exactly as written.
- Claude Cowork: same, when the repo is in a connected folder and Vale is
  installed in the environment. When Vale is absent, the skill should fall back
  to model-based review and say the gate did not run.
- Claude Chat: no shell and no repo. The skill runs as guidance only. It applies
  the standard, the domain modes, and the runbook judgment, and it tells the
  user which local command to run for the deterministic gate.

The current `SKILL.md` already anticipates this with its source-priority ladder
(use local files when present, fall back to embedded rules when not). That ladder
is the right pattern for graceful degradation.

## What A Claude Skills Package Needs

The content is ready. The packaging work is small and specific.

1. Frontmatter. The existing `name` and `description` are compatible. Widen the
   description with trigger terms (house style, style gate, AI voice, recruiter
   voice, plain language, humanize) so the skill activates reliably.

2. Self-contained fallback. Claude Chat has no repo. Bundle the core rules, the
   domain-mode checklists, and a condensed AI voice pattern list inside the
   skill or its reference files so the skill works with zero local files. The
   embedded fallback in the current `SKILL.md` is a good start and should absorb
   the runbook's seven patterns and watchwords in plain language.

3. Runtime detection and paths. Add explicit guidance: run scripts only when a
   shell and the repo are present, otherwise review by judgment. Do not hardcode
   `~/.codex` paths. Reference repo-relative script paths and check existence
   first.

4. Reference files. Package the durable inputs as skill references:
   - `HOUSE_STYLE.md`
   - `domain-modes.md`
   - `examples.md`
   - the runbook
   - the voice rubric

   This source set is small enough to bundle.

5. Boundary text. Carry the authorship boundary verbatim. The skill must never
   position itself as an AI detector.

6. Naming. Ship one skill (for example `house-style`) with modes inside it,
   rather than separate skills per layer. The domain table in the current
   `SKILL.md` already handles mode selection.

## Recommended Next Steps

1. Decide the target: a single portable skill directory with `SKILL.md` plus
   bundled references.
2. Adapt the Codex `SKILL.md` into that structure with runtime-aware script
   handling and a self-contained fallback.
3. Fold the runbook's seven patterns and watchwords into the fallback so Claude
   Chat gets full AI voice coverage without the repo.
4. Optional but recommended: generalize the most brittle AIVoice Vale rules
   (`CoordinatedAbstraction`, `DiagnosticAdjectiveStack`, `VagueConsequence`,
   `EmptyWorkNouns`) so the deterministic gate matches the skill's semantic
   coverage. Keep each new rule at suggestion level with a fixture and a
   near-miss control.
5. Verify by running `test-style-gate.sh`, `eval-kalen-voice.sh`, and
   `eval-ai-voice.sh` in a runtime that has Vale installed.

## Note On Verification

I could not run the gate or evals here. Vale is not installed in this
environment, so the pass or fail state of the three test scripts is unverified.
The rule, fixture, and eval wiring reads as internally consistent, but a run on
a machine with Vale should confirm it before the package ships.

## Implementation Status (2026-07-02)

The recommended next steps are now implemented in this repo.

Claude skill package. Added `claude-skills/house-style/` with a self-contained
`SKILL.md` and three reference files: `ai-voice-patterns.md`, `domain-modes.md`,
and `house-style-core.md`. The skill is runtime-aware. It runs the gate when a
shell and repo are present and reviews by judgment when they are not. The
runbook's seven patterns and watchwords are folded into the reference set, so
Claude Chat gets full AI voice coverage with no repo. The main `README.md` now
registers the skill.

Generalized AIVoice rules. Rebuilt the four most brittle rules
(`CoordinatedAbstraction`, `DiagnosticAdjectiveStack`, `VagueConsequence`,
`EmptyWorkNouns`) so they match the pattern rather than the runbook's literal
example. Each keeps its original literal token for backward compatibility and
adds generalized tokens. Added one variant fail fixture per rule, worded
differently from the runbook example, and wired all four into
`eval-ai-voice.sh` and `test-style-gate.sh`.

Verification. Vale was not installable in the build environment, so the Vale
scripts were not run. A Python harness replicated Vale `existence` matching
against every fixture and near-miss control. Result: all eleven fail fixtures
(seven original plus four variants) trigger their own rule, and all eleven
near-miss controls stay AIVoice-clean. A real Vale run on a machine with Vale is
still the final confirmation before shipping.
