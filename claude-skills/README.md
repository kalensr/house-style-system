# Claude Skill: House Style

This directory holds the House Style System packaged as a Claude skill. It works
in Claude Chat, Claude Cowork, and Claude Code from one source.

```text
claude-skills/
└── house-style/
    ├── SKILL.md
    └── reference/
        ├── ai-voice-patterns.md
        ├── domain-modes.md
        └── house-style-core.md
```

## What It Does

The skill applies the House Style System. It helps produce clear, direct,
plain-language prose fitted to its domain. It removes the default AI business
voice and checks whether the right human actor stayed in subject position. It
pairs a deterministic style gate with judgment-based review. It also checks
short-line punchlines and never detects authorship.

`SKILL.md` is self-contained. The three reference files add depth and load only
when needed. The core rules, domain modes, AI voice patterns, and Center of
Gravity checks are embedded. That means the skill works even with no repo and
no shell, which is the normal case in Claude Chat.

## How Each Surface Uses It

Claude Code and Claude Cowork usually have a shell and this repo folder. There
the skill runs the deterministic gate on files it edits:

```sh
./scripts/style_gate.sh path/to/draft.md
./scripts/review-ai-voice.sh path/to/draft.md
./scripts/review-kalen-voice.sh path/to/draft.md
./scripts/review-center-of-gravity.sh path/to/draft.md
./scripts/review-dramatic-punctuation.sh path/to/draft.md
```

Claude Chat usually has no shell or repo. There the skill applies the same rules
by judgment and tells you which local command to run before final handoff.

## Install

### Claude Code

Copy the skill into your project or personal skills directory so Claude Code can
discover it:

```sh
mkdir -p ~/.claude/skills
cp -R claude-skills/house-style ~/.claude/skills/
```

You can also keep it in-repo under a project `.claude/skills/` directory if you
prefer per-project skills. Restart or reload Claude Code after installing.

### Claude Cowork

Add this repo as a connected folder. Cowork can read the skill from
`claude-skills/house-style/` and run the gate scripts when Vale is installed in
the environment.

### Claude Chat

Upload `SKILL.md` and the three reference files to a Project, or paste
`SKILL.md` into the Project instructions. Chat applies the rules as guidance and
points you to the local gate for deterministic checks.

## Deterministic Gate Requirement

The gate scripts need Vale. Install it with `brew install vale` on macOS, or use
the official Vale install steps for your platform, then confirm `vale --version`
works. Without Vale, the skill still reviews by judgment and says the gate did
not run.

## Boundary

Automation checks style risks. Human review owns truth, evidence, judgment, and
final accountability. A clean gate means the draft avoided known style risks. It
does not prove the draft is true, useful, or ready. This skill is not an AI
detector.

## Relationship To The Codex Skill

`codex-skills/house-style-system/SKILL.md` is the Codex version of the same
system. This `claude-skills/house-style/` package is the Claude version, adapted
for three runtimes with a self-contained fallback and runtime-aware gate
handling.
