# Codex Handoff

Use this document to hand the House Style System repo to Codex and get set up.

## What This Repo Gives Codex

This repo gives Codex three useful things:

1. A written style standard in `HOUSE_STYLE.md`.
2. A repeatable Vale style gate in `scripts/style_gate.sh`.
3. An optional Codex skill in `codex-skills/house-style-system/SKILL.md`.

The skill teaches Codex when to use the style system, how to choose a writing
domain, how to handle repeated phrasing, and when to run validation.

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
```

Expected result:

- the style gate finishes without errors,
- the fixture test prints `test-style-gate: passed`.

## Paste-Ready Codex Prompt

Use this prompt in a new Codex session after installing the skill:

```text
Use the house-style-system skill.

Read this repo's README.md, HOUSE_STYLE.md, docs/domain-modes.md,
docs/examples.md, and docs/ai-authorship-boundary.md.

Then help me apply the House Style System to my writing. When I give you a
draft, identify the writing domain, revise for substance first, check for
repeated phrasing, preserve my meaning, and run ./scripts/style_gate.sh when
you edit files in this repo.

Do not treat style signals as proof of authorship. Use them as review prompts.
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

## What Codex Should Not Do

Codex should not:

- use this repo as an AI detector,
- infer authorship from style signals,
- rewrite source quotes just to satisfy a style rule,
- treat a clean style gate as proof that a document is true or ready,
- add broad rules that are hard to test.

## Handoff Checklist

Before you rely on the setup:

- `codex-skills/house-style-system/SKILL.md` has been copied into
  `~/.codex/skills/house-style-system/SKILL.md`.
- Codex was restarted after installation.
- Vale is installed.
- `./scripts/style_gate.sh HOUSE_STYLE.md docs/examples.md` passes.
- `./scripts/test-style-gate.sh` passes.
- The user understands the boundary: automation checks style risks; human
  review owns truth, evidence, judgment, and final accountability.
