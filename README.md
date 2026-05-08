# House Style System

A practical starter system for clearer, more trustworthy AI-assisted writing.

The goal is simple: keep human judgment in the writing loop.

This repo gives you a working house style guide, a small Vale style gate, test fixtures, and examples you can use immediately. Start with the defaults. Then tune the rules to your own voice, audience, and risk.

![House Style Rules Engine Map](assets/house-style-rules-engine-map.png)

## Start Here

- Use the writing standard: [HOUSE_STYLE.md](HOUSE_STYLE.md)
- Run the style gate: [scripts/style_gate.sh](scripts/style_gate.sh)
- Read the Codex setup guide: [docs/codex-handoff.md](docs/codex-handoff.md)
- Install the optional Codex skill: [codex-skills/house-style-system/SKILL.md](codex-skills/house-style-system/SKILL.md)
- Review repo readiness: [docs/repo-evaluation.md](docs/repo-evaluation.md)

## What This Is

House Style System is a lightweight writing quality framework.

It helps writers and teams:

- make writing clearer,
- reduce generic AI-sounding prose,
- separate facts from assumptions,
- define what automation checks,
- define what human review owns,
- test style rules with examples.

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

Run the fixture test:

```sh
./scripts/test-style-gate.sh
```

Use `HOUSE_STYLE.md` as your starter standard. Edit the rules, examples, and fixtures as your own house style becomes clearer.

## Optional Codex Skill

This repo includes an optional Codex skill:

```text
codex-skills/house-style-system/SKILL.md
```

The skill helps Codex:

- recognize when to apply the House Style System,
- choose the right writing domain,
- preserve meaning while revising,
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

## Repo Map

```text
house-style-system/
├── README.md
├── HOUSE_STYLE.md
├── assets/
│   └── house-style-rules-engine-map.png
├── docs/
│   ├── ai-authorship-boundary.md
│   ├── codex-handoff.md
│   ├── customizing.md
│   ├── domain-modes.md
│   ├── examples.md
│   ├── house-style-system.md
│   ├── repo-evaluation.md
│   └── test-fixtures/style-gate/
├── codex-skills/
│   └── house-style-system/SKILL.md
├── research/
│   └── house-style-system-assessment.pdf
├── scripts/
│   ├── style_gate.sh
│   └── test-style-gate.sh
├── styles/
│   └── HouseStyle/
└── .vale.ini
```

## The Default Operating Rule

Automation owns repeatable checks.

Human review owns truth, evidence, and judgment. It also owns recommendation quality and tone.

That boundary matters. A clean style gate means the text avoided known style risks. It does not prove the writing is true, useful, or ready to publish.

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

Read the public research artifact as a browser-friendly PDF: [House Style System Assessment](research/house-style-system-assessment.pdf).

It explains the style-risk taxonomy behind this system and credits the research, synthesis, and AI-collaboration process used to prepare the assessment.

## License

MIT. See [LICENSE](LICENSE).
