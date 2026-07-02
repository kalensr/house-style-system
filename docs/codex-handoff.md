# Codex Handoff

Use this document to hand the House Style System repo to Codex and get set up.

## What This Repo Gives Codex

This repo gives Codex five useful things:

1. A written style standard in `HOUSE_STYLE.md`.
2. A repeatable Vale style gate in `scripts/style_gate.sh`.
3. An optional Codex skill in `codex-skills/house-style-system/SKILL.md`.
4. A public-safe Kalen voice rules eval in `scripts/eval-kalen-voice.sh`.
5. An optional AI voice review layer in `scripts/eval-ai-voice.sh`.

The skill teaches Codex when to use the style system and how to choose a
writing domain. It also covers repeated phrasing, stock AI business voice, and
validation.

## One-Time Setup

From the repo root:

```sh
mkdir -p ~/.codex/skills
rm -rf ~/.codex/skills/house-style-system
cp -R codex-skills/house-style-system ~/.codex/skills/
```

Install Vale if you do not already have it:

macOS with Homebrew:

```sh
brew install vale
```

Other platforms: use the official Vale install instructions for your operating
system, then confirm `vale --version` works in your terminal.

Then restart Codex so it can discover the new skill.

## Quick Verification

Run:

```sh
./scripts/style_gate.sh HOUSE_STYLE.md docs/examples.md
./scripts/test-style-gate.sh
./scripts/eval-kalen-voice.sh
./scripts/eval-ai-voice.sh
./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md
./scripts/review-ai-voice.sh docs/test-fixtures/style-gate/fail-ai-empty-work-noun.md
```

Expected result:

- the style gate finishes without errors,
- the fixture test prints `test-style-gate: passed`.
- the voice eval prints `eval-kalen-voice: passed`.
- the AI voice eval prints `eval-ai-voice: passed`.
- the Kalen voice wrapper finishes without errors on the positive control.
- the AI voice wrapper flags the stock AI voice fixture.

## Paste-Ready Codex Prompt

Use this prompt in a new Codex session after installing the skill:

```text
Use the house-style-system skill.

Read this repo's README.md, HOUSE_STYLE.md, docs/domain-modes.md,
docs/examples.md, docs/ai-authorship-boundary.md, and
docs/chatgpt-project/ai-voice-avoidance-runbook.md.

Then help me apply the House Style System to my writing. When I give you a
draft, identify the writing domain, revise for substance first, check for
repeated phrasing, remove stock AI business voice, preserve my meaning, and run
./scripts/style_gate.sh when you edit files in this repo.

Do not treat style signals as proof of authorship. Use them as review prompts.
When Kalen asks for voice review on leadership, strategy, reflection, public
essay, or executive prose, apply the Kalen voice review layer. Treat it as a
set of prompts, not a model or score. Run ./scripts/review-kalen-voice.sh on
the draft when a file path is available. Do not invent personal details.

When Kalen asks for personal positioning, recruiter-facing writing, cover
letters, or AI voice review, apply the AI voice review layer. Run
./scripts/review-ai-voice.sh on the draft when a file path is available.
```

## Common Workflows

### Review A Draft

Tell Codex:

```text
Use the house-style-system skill. Review this draft as a blog post. Preserve my
meaning, flag unsupported claims, reduce generic phrasing, and run the style
gate if you edit the file.
```

### Add A New Style Rule

Tell Codex:

```text
Use the house-style-system skill. I keep seeing this writing pattern: <pattern>.
Add a fixture, add or adjust a Vale rule only if the pattern is checkable, and
run ./scripts/test-style-gate.sh.
```

### Customize The System

Tell Codex:

```text
Use the house-style-system skill. Help me adapt HOUSE_STYLE.md and the Vale
rules for my audience. Keep the rules small, explain what automation can check,
and leave truth, evidence, and judgment with human review.
```

### Run The Kalen Voice Eval

Tell Codex:

```text
Use the house-style-system skill. Run ./scripts/eval-kalen-voice.sh and explain
whether the synthetic positive and negative controls behaved as expected.
```

### Review Kalen Voice On A Draft

Tell Codex:

```text
Use the house-style-system skill. Review this draft with the Kalen voice review
layer, treat the rules as prompts, and run ./scripts/review-kalen-voice.sh
<file> if you edit or inspect a repo file.
```

### Run The AI Voice Eval

Tell Codex:

```text
Use the house-style-system skill. Run ./scripts/eval-ai-voice.sh and explain
whether the fail fixtures and near-miss controls behaved as expected.
```

### Review AI Voice On A Draft

Tell Codex:

```text
Use the house-style-system skill. Review this draft for stock AI business
voice, treat the rules as prompts, and run ./scripts/review-ai-voice.sh <file>
if you edit or inspect a repo file.
```

## What Codex Should Not Do

Codex should not:

- use this repo as an AI detector,
- infer authorship from style signals,
- rewrite source quotes just to satisfy a style rule,
- treat a clean style gate as proof that a document is true or ready,
- add broad rules that are hard to test,
- commit private writing samples as fixtures.

## Handoff Checklist

Before you rely on the setup:

- `codex-skills/house-style-system/SKILL.md` has been copied into
  `~/.codex/skills/house-style-system/SKILL.md`.
- Codex was restarted after installation.
- Vale is installed.
- `./scripts/style_gate.sh HOUSE_STYLE.md docs/examples.md` passes.
- `./scripts/test-style-gate.sh` passes.
- `./scripts/eval-kalen-voice.sh` passes.
- `./scripts/eval-ai-voice.sh` passes.
- The user understands the boundary: automation checks style risks; human
  review owns truth, evidence, judgment, and final accountability.
