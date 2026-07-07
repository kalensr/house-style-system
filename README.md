# House Style System

A practical starter system for clearer AI-assisted writing.

The goal is simple: keep human judgment in the writing loop, and make the
repeatable checks easy to run.

This repo gives you a working house style guide and a small Vale style gate. It
also includes test fixtures, examples, and optional assistant skills. Start with
the defaults. Then tune the rules to your own voice, audience, and risk.

![House Style Rules Engine Map](assets/house-style-rules-engine-map.png)

## Start Here

Core files:

- Writing standard: [HOUSE_STYLE.md](HOUSE_STYLE.md)
- Style gate: [scripts/style_gate.sh](scripts/style_gate.sh)
- Examples: [docs/examples.md](docs/examples.md)
- Domain modes: [docs/domain-modes.md](docs/domain-modes.md)
- Authorship boundary: [docs/ai-authorship-boundary.md](docs/ai-authorship-boundary.md)

Optional review layers:

- Kalen voice review: [scripts/review-kalen-voice.sh](scripts/review-kalen-voice.sh)
- AI voice review: [scripts/review-ai-voice.sh](scripts/review-ai-voice.sh)
- Kalen voice eval: [scripts/eval-kalen-voice.sh](scripts/eval-kalen-voice.sh)
- AI voice eval: [scripts/eval-ai-voice.sh](scripts/eval-ai-voice.sh)

Assistant setup:

- Codex skill: [codex-skills/house-style-system/SKILL.md](codex-skills/house-style-system/SKILL.md)
- Claude skill: [claude-skills/house-style/SKILL.md](claude-skills/house-style/SKILL.md)
- ChatGPT Project setup: [docs/chatgpt-project/README.md](docs/chatgpt-project/README.md)

## What This Is

House Style System is a lightweight writing quality framework.

It helps writers and teams:

- make writing clearer,
- reduce generic AI-sounding prose,
- separate facts from assumptions,
- define what automation checks,
- define what human review owns,
- test style rules with examples.

It also includes public-safe optional review layers. Those layers use synthetic
fixtures and deterministic rules to flag repeatable review risks without
committing private writing samples.

## What This Is Not

This is not an AI detector.

It does not prove whether a person or model wrote a sentence. It does not score authorship. It does not help disguise AI use.

Style signals are review prompts. They are not proof.

## Quick Start

Install Vale.

macOS with Homebrew:

```sh
brew install vale
```

Other platforms: use the official Vale install instructions for your operating
system, then confirm `vale --version` works in your terminal.

Run the style gate:

```sh
./scripts/style_gate.sh HOUSE_STYLE.md docs/examples.md
```

Run the full fixture test:

```sh
./scripts/test-style-gate.sh
```

Run the optional evals when you change voice rules:

```sh
./scripts/eval-kalen-voice.sh
./scripts/eval-ai-voice.sh
```

Run Kalen voice review on a specific draft:

```sh
./scripts/review-kalen-voice.sh path/to/draft.md
```

Run AI voice review on a specific draft:

```sh
./scripts/review-ai-voice.sh path/to/draft.md
```

With no file arguments, `style_gate.sh` scans normal Markdown docs and skips
test fixtures, eval fixtures, and implementation plans. Pass explicit paths
when you want to check one of those files. The Kalen voice layer is opt-in and
only runs when you use `review-kalen-voice.sh` or pass `--kalen-voice` to
`style_gate.sh`. The AI voice layer is also opt-in and only runs when you use
`review-ai-voice.sh` or pass `--ai-voice` to `style_gate.sh`.

Use [HOUSE_STYLE.md](HOUSE_STYLE.md) as your starter standard. Edit the rules,
examples, and fixtures as your own house style becomes clearer.

## Review Layers

The default `HouseStyle` rules run when you call `style_gate.sh`.

Use the optional layers only when they fit the work:

| Layer | Command | Use When |
| --- | --- | --- |
| House style | `./scripts/style_gate.sh <file>` | General writing quality checks |
| Kalen voice | `./scripts/review-kalen-voice.sh <file>` | Leadership, reflection, public essay, or Kalen voice review |
| AI voice | `./scripts/review-ai-voice.sh <file>` | Generic AI business or recruiter prose needs review |

The optional layers are review aids. They do not detect authorship.

## Optional Codex Skill

This repo includes an optional Codex skill:

```text
codex-skills/house-style-system/SKILL.md
```

The skill helps Codex:

- recognize when to apply the House Style System,
- choose the right writing domain,
- preserve meaning while revising,
- apply Kalen voice review prompts when that layer applies,
- apply AI voice avoidance prompts when that layer applies,
- check repeated words and repeated phrases,
- use repo docs in the right priority order,
- run the style gate at deliverable checkpoints,
- keep authorship detection out of scope.

Install it:

```sh
mkdir -p ~/.codex/skills
rm -rf ~/.codex/skills/house-style-system
cp -R codex-skills/house-style-system ~/.codex/skills/
```

Restart Codex after installing the skill.

Then use a prompt like:

```text
Use the house-style-system skill. Review this draft as a blog post. Preserve my
meaning, flag unsupported claims, reduce generic phrasing, and run the style
gate if you edit the file.
```

For a complete setup handoff, see [docs/codex-handoff.md](docs/codex-handoff.md).

## Optional Claude Skill

This repo also includes a Claude skill that works across Claude Chat, Claude
Cowork, and Claude Code from one source:

```text
claude-skills/house-style/SKILL.md
```

The skill is self-contained. It embeds the core rules, domain modes, and AI
voice patterns. It works even with no repo and no shell. When a shell and the
repo are available, it runs the deterministic style gate on files it edits. It
never detects authorship.

Install it for Claude Code:

```sh
mkdir -p ~/.claude/skills
cp -R claude-skills/house-style ~/.claude/skills/
```

For setup on all three surfaces, see
[claude-skills/README.md](claude-skills/README.md).

## ChatGPT Project Package

The [docs/chatgpt-project](docs/chatgpt-project) package turns this repo into a
private ChatGPT writing workspace.

It includes:

- Project instructions,
- a voice rubric,
- an AI voice avoidance runbook,
- launch prompts,
- a short manifesto.

Keep private writing samples out of this public repo. If you add samples to a
ChatGPT Project, use only material you are comfortable storing there.

## Validation

Run these before publishing changes:

```sh
./scripts/style_gate.sh
./scripts/test-style-gate.sh
./scripts/eval-kalen-voice.sh
./scripts/eval-ai-voice.sh
git diff --check
```

## Repo Map

```text
house-style-system/
├── README.md
├── HOUSE_STYLE.md
├── assets/
│   └── house-style-rules-engine-map.png
├── docs/
│   ├── ai-authorship-boundary.md
│   ├── chatgpt-project/
│   ├── codex-handoff.md
│   ├── customizing.md
│   ├── domain-modes.md
│   ├── evidence/
│   ├── evals/
│   ├── examples.md
│   ├── house-style-system.md
│   ├── plans/
│   ├── repo-evaluation.md
│   └── test-fixtures/style-gate/
├── codex-skills/
│   └── house-style-system/SKILL.md
├── claude-skills/
│   └── house-style/
│       ├── SKILL.md
│       └── reference/
├── research/
│   └── house-style-system-assessment.pdf
├── scripts/
│   ├── style_gate.sh
│   ├── review-kalen-voice.sh
│   ├── review-ai-voice.sh
│   ├── eval-kalen-voice.sh
│   ├── eval-ai-voice.sh
│   └── test-style-gate.sh
├── styles/
│   ├── AIVoice/
│   ├── HouseStyle/
│   └── KalenVoice/
├── .vale.ini
├── .vale-kalen.ini
└── .vale-ai-voice.ini
```

## The Default Operating Rule

Automation owns repeatable checks.

Human review owns truth, evidence, and judgment. It also owns recommendation
quality and tone.

That boundary matters. A clean style gate means the text avoided known style
risks. It does not prove the writing is true, useful, or ready to publish.

## How To Use This With AI

1. Draft with AI when it helps.
2. Read every line.
3. Cut anything you are not willing to stand behind.
4. Check facts, assumptions, sources, and recommendations.
5. Run the style gate.
6. Fix warnings that weaken clarity or trust.
7. Add new examples when you see the same failure twice.

## Public-Safe Defaults

The default rules are conservative. They flag common writing risks:

- filler phrases,
- weak modifiers,
- jargon,
- em dashes,
- stock conclusions,
- overloaded sentences,
- undefined acronym candidates,
- repeated contrast scaffolding.

The optional Kalen voice layer flags public-safe review patterns only when you
run `./scripts/review-kalen-voice.sh <file>` or explicitly pass
`--kalen-voice` to `style_gate.sh`.

The optional AI voice layer flags common generated business and recruiter voice
patterns only when you run `./scripts/review-ai-voice.sh <file>` or explicitly
pass `--ai-voice` to `style_gate.sh`.

Warnings are meant to slow you down, not force mechanical rewrites.

## Customize It

Your house style should reflect your readers and your work.

Start by changing:

- the jargon list,
- preferred replacements,
- domain-mode checks,
- fixture examples,
- warning levels.

See [docs/customizing.md](docs/customizing.md).

## Research Note

Read the public research artifact as a browser-friendly PDF:
[House Style System Assessment](research/house-style-system-assessment.pdf).

It explains the style-risk taxonomy behind this system and credits the research,
synthesis, and AI-collaboration process used to prepare the assessment.

## License

MIT. See [LICENSE](LICENSE).
