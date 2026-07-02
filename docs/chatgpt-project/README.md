# ChatGPT Writing Project Setup

Purpose: create a private ChatGPT Project that helps Kalen draft, revise, and
review writing in his house style.

This package translates the House Style System into a ChatGPT Project setup.
The repo's core boundary stays intact. ChatGPT can draft and review. The style
rules can flag repeatable risks. Kalen owns truth, judgment, and evidence. He
also owns voice fit and final approval.

## Research Summary

The current OpenAI guidance points to a Project as the best fit for this work.
Projects support project-specific instructions, uploaded files, saved project
sources, and project memory. Project instructions apply only inside that
project and override global custom instructions there.

Custom instructions still matter for account-wide preferences, but they are too
broad for a writing workspace. Their longer text field is limited to 1500
characters, and they apply across chats. A writing Project gives this work a
clearer boundary.

Uploaded files are useful for this case because ChatGPT can synthesize,
transform, extract, and rewrite from uploaded documents. That matches the
intended workflow: apply a rubric from one source to a draft. Then revise
without changing meaning and compare the draft against a voice standard.

ChatGPT skills may become useful if this writing workflow needs executable
steps inside ChatGPT Business, Enterprise, or Edu. They may also help in
Teachers or Healthcare plans. For now, a Project with source files is the right
first version.

Sources:

- [Projects in ChatGPT](https://help.openai.com/en/articles/10169521-projects-in-chatgpt)
- [ChatGPT Custom Instructions](https://help.openai.com/en/articles/8096356-chatgpt-custom-instructions)
- [File uploads](https://help.openai.com/en/articles/8555545-file-uploads-faq)
- [Memory](https://help.openai.com/en/articles/8590148-memory-faq)
- [ChatGPT Skills](https://help.openai.com/en/articles/20001066-skills-in-chatgpt)
- [OpenAI model optimization: Write effective prompts](https://developers.openai.com/api/docs/guides/model-optimization#write-effective-prompts)

## Repo Evaluation For This Use

The repo is a strong source package for a ChatGPT writing Project.

Strengths:

- `HOUSE_STYLE.md` gives the durable writing standard.
- `docs/domain-modes.md` gives mode-specific checks for business, executive,
  blog, report, informal, and learning use.
- `docs/examples.md` gives concrete before and after patterns.
- `docs/ai-authorship-boundary.md` keeps the safety boundary explicit.
- `styles/HouseStyle/`, `styles/KalenVoice/`, and `styles/AIVoice/` make
  repeatable risks visible.
- `scripts/review-kalen-voice.sh` gives a local check for Kalen voice risks.
- `scripts/review-ai-voice.sh` gives a local check for stock AI voice risks.
- `codex-skills/house-style-system/SKILL.md` already explains the operating
  workflow in a reusable agent format.

Gaps to close for ChatGPT:

- The repo did not have a concise Project instruction block ready to paste.
- The voice layer was built for local review, not for ChatGPT Project use.
- There was no single setup checklist for creating the Project.
- There were no launch prompts for common writing modes.

This directory closes those gaps and connects them to the optional local voice
review layers.

## Recommended Project Sources

Upload or add these files to the ChatGPT Project first:

1. `docs/chatgpt-project/project-instructions.md`
2. `docs/chatgpt-project/voice-rubric.md`
3. `docs/chatgpt-project/ai-voice-avoidance-runbook.md`
4. `docs/chatgpt-project/manifesto.md`
5. `HOUSE_STYLE.md`
6. `docs/domain-modes.md`
7. `docs/examples.md`
8. `docs/ai-authorship-boundary.md`

Optional sources:

1. `codex-skills/house-style-system/SKILL.md`
2. `docs/chatgpt-project/launch-prompts.md`
3. `docs/house-style-system.md`

Keep private writing samples out of the public repo. If you add samples to the
Project, use only material you are comfortable storing in ChatGPT. Prefer short,
approved excerpts that show voice and structure over large private archives.

## Step-By-Step Setup

1. Create a new private Project in ChatGPT named `Kalen Writing Studio`.
2. Open Project settings.
3. Paste the full text from `project-instructions.md` into Project
   instructions.
4. Add the recommended Project sources above.
5. Start a new chat in the Project.
6. Paste the `Project calibration` prompt from `launch-prompts.md`.
7. Ask ChatGPT to summarize the writing rules it will apply.
8. Give it one old draft and ask for a diagnostic review only.
9. Compare the review to the rubric. Correct any drift in the Project
   instructions.
10. Use separate chats for major writing modes: blog, executive memo, formal
    writing, informal note, and long-form report.

## Operating Rule

Use ChatGPT for drafts, review passes, structural options, and mode-specific
rewrites.

Use the local repo for deterministic checks:

```sh
./scripts/style_gate.sh path/to/draft.md
./scripts/review-kalen-voice.sh path/to/draft.md
./scripts/review-ai-voice.sh path/to/draft.md
```

The Project should ask for proof when claims matter. It should also ask for the
local style gate result when a draft is close to handoff.
