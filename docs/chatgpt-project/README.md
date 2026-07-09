# ChatGPT Writing Project Template

Use this package to create a private ChatGPT Project for drafting and review
with the House Style System.

The template keeps the public utility boundary intact:

- the repository supplies generic writing guidance and synthetic examples;
- the Project may use private source material that you add directly;
- private drafts and personal voice corpora stay out of this repository;
- the writer owns truth, evidence, judgment, voice fit, and final approval.

## Project Sources

Add these files first:

1. `docs/chatgpt-project/project-instructions.md`
2. `docs/chatgpt-project/voice-rubric.md`
3. `docs/chatgpt-project/ai-voice-avoidance-runbook.md`
4. `docs/chatgpt-project/manifesto.md`
5. `HOUSE_STYLE.md`
6. `docs/domain-modes.md`
7. `docs/examples.md`
8. `docs/ai-authorship-boundary.md`

Optional sources:

1. `docs/chatgpt-project/launch-prompts.md`
2. `codex-skills/house-style-system/SKILL.md`
3. `docs/house-style-system.md`

## Setup

1. Create a private ChatGPT Project.
2. Paste `project-instructions.md` into the Project instructions.
3. Add the recommended Project sources.
4. Replace every bracketed placeholder in `voice-rubric.md`.
5. Run the calibration prompt from `launch-prompts.md`.
6. Ask for a diagnostic review of one approved draft before requesting a
   rewrite.
7. Correct any drift in the Project instructions or rubric.

## Private Material

Do not commit private samples to this public repository. Add only material you
are comfortable storing in your ChatGPT Project. Prefer short, approved
excerpts over a large archive.

Personal rules should live in a private profile source. Keep the public files
generic enough that another writer can use them without inheriting someone
else's identity or biography.

## Local Validation

Use ChatGPT for drafting, structural options, and review. Use the local scripts
for deterministic checks:

```sh
./scripts/style_gate.sh path/to/draft.md
./scripts/review-ai-voice.sh path/to/draft.md
./scripts/review-center-of-gravity.sh path/to/draft.md
./scripts/review-dramatic-punctuation.sh path/to/draft.md
```

The optional `KalenVoice` layer remains a public reference profile. Build your
own private profile instead of treating that reference as a universal voice
standard.
