---
name: house-style
description: >-
  Apply the House Style System to draft, revise, review, or humanize prose. Use
  for house style, style gate, plain language, clearer writing, and removing
  generic or AI-sounding business and recruiter prose. Covers executive memos,
  decision briefs, leadership reflection, blog and public essays, long-form
  reports, informal notes, social posts, and personal positioning or
  recruiter-facing writing. Runs the deterministic Vale style gate when a shell
  and the repo are available. Applies the same rules by judgment when they are
  not. Never used to detect authorship.
---

# House Style

Use this skill to make human-facing prose clear, direct, useful, and fitted to
its domain. Use it to remove the default AI business voice. It pairs a
deterministic style gate with judgment-based review.

## When To Use

Use this skill when the user asks for any of the following:

- house style, style gate, plain language, or a writing quality review,
- drafting, rewriting, editing, polishing, or humanizing prose,
- removing AI-sounding or generic business and recruiter voice,
- Center of Gravity review, human-centered framing, or actor/action clarity
  when AI or agents have become the protagonist,
- No Dramatic Punctuation review when short lines or fragments create drama
  without enough actor, action, standard, mechanism, or consequence,
- executive memo, decision brief, or leadership update,
- leadership reflection, public essay, or personal voice review,
- blog, report, business doc, social post, or informal note,
- personal positioning, recruiter-facing, or cover-letter writing,
- checking for repeated words, verbal tics, or filler.

Do not use it on rough working notes unless the user asks for style review.

## Two Layers, One Boundary

Automation owns repeatable surface checks. Human review owns truth and
evidence. It also owns judgment, audience fit, and final approval. A clean gate
means the text avoided known style risks. It does not prove the writing is true.

This skill never detects authorship. Style signals are review prompts. Do not
use them to accuse anyone of using AI or to prove who wrote a text. See
`reference/house-style-core.md` for the full boundary.

## Runtime Awareness

Detect what the runtime allows, then choose the strongest available path.

Claude Code and Claude Cowork usually have a shell and the repo folder. When
they do, run the deterministic gate on files you edit.

Claude Chat usually has no shell and no repo. There, apply the rules by
judgment, and tell the user which local command to run before final handoff.

Use this source-priority ladder:

1. If the project has `HOUSE_STYLE.md`, follow it.
2. If it has `docs/domain-modes.md`, use it for domain checks.
3. If it has `docs/examples.md`, use it for rewrite patterns.
4. If it has `docs/chatgpt-project/ai-voice-avoidance-runbook.md`, use it for AI
   voice avoidance in executive, recruiter-facing, public, and leadership
   writing.
5. If it has `docs/research/center-of-gravity-writing-eval.md`, use it for
   Center of Gravity review when people, teams, customers, organizations,
   decisions, or workflows should stay visible as the subject.
6. If it has `docs/research/no-dramatic-punctuation-eval.md`, use it for
   short-line, fragment, and staccato-emphasis review.
7. If it has a style gate script and you edited files, run the gate at the
   checkpoint (see Deterministic Gate below).
8. If none of these are present, use the self-contained rules in this skill and
   its reference files. This is the normal case in Claude Chat.

## Domain Selection

If the user names a domain, use it. If not, default to `plain`. When the domain
is unclear and the choice would change the result, ask one short question.
Otherwise pick the closest domain and state the choice.

| User says | Domain |
| --- | --- |
| executive memo, leadership update, decision brief | `executive` |
| leadership reflection, personal essay, voice review | `leadership-reflection` |
| recruiter, executive search, cover letter, career positioning | `personal-positioning` |
| business doc, recommendation, status update | `business` |
| blog, public writing, article, essay | `blog` |
| report, research brief, analysis package | `long-form-report` |
| student essay, academic essay, class paper | `student-essay` |
| LinkedIn, X, social post, announcement | `social-post` |
| note, message, casual, friendly | `informal` |

Full per-domain checks are in `reference/domain-modes.md`.

## Core House Style Rules

These apply in every domain and work with no repo present.

- Lead with the main point.
- Write for the reader's purpose, context, and time.
- Use short, direct sentences and concrete nouns, numbers, dates, and owners.
- Keep paragraphs short, one main idea each.
- Define acronyms on first use or remove them.
- Separate facts, assumptions, inferences, recommendations, and open questions
  when it matters.
- Prefer plain words: `use` over `utilize`, `help` or `improve` over vague
  `drive`, `clear` or `specific` over `robust`.
- Avoid filler, weak modifiers, jargon, and stock conclusions.
- Do not use Unicode em dash characters. Use a comma, colon, or sentence break.
- Avoid repeated contrast scaffolds such as `not X, but Y` or paired
  `can / cannot` lines. State the point directly.
- Do not add unsupported claims. Preserve the author's meaning and uncertainty.

More before-and-after patterns are in `reference/house-style-core.md`.

## Remove The Default AI Voice

Do not only match the author's voice. Also strip the generic AI business
register. AI voice is a pattern, not one word list. Watch for abstract labels
before concrete facts, polished but impersonal phrasing, and broad diagnosis
before proof. Also watch role-fit framing and nouns stacked in place of visible
action.

Watch these abstract nouns and confirm each names a concrete system, symptom,
owner, or before-and-after change:

- `ownership`
- `visibility`
- `alignment`
- `strain`
- `friction`
- `complexity`
- `modernization`

Also watch role-fit openings such as `the roles that fit me best`.
Watch familiar-pattern openings such as `the pattern I am most useful in is
familiar`. Watch empty work nouns such as `the work is not only...`.

Repair a flagged sentence by naming the real thing: actor, action, and system or
workflow. Also name the before state, friction or risk, decision, and result.
The full seven stop patterns are in
`reference/ai-voice-patterns.md`. That file also includes the watchword list,
repair recipe, and recruiter sentence order. Read that
file when doing executive, recruiter-facing, public, or leadership writing.

## Check Center Of Gravity

When writing about people adapting to AI, teams changing work, or organizations
making decisions, keep the human actor visible. Do not let AI, agents,
abstract work, or nominalized actions become the protagonist unless they are
truly the actor.

Ask:

- Sentence: who is the subject, and should they be?
- Paragraph: what entity controls the paragraph?
- Topic: what is the piece actually about?

Watch for:

- `AI is...`
- `agents are...`
- `the work is...`
- `this work...`
- `the pattern...`

Also watch nominalized subjects such as `adoption`, `implementation`,
`alignment`, or `modernization`. Repair by naming the person, team, customer,
or organization. You can also name the decision, workflow, or concrete change.

## Check No Dramatic Punctuation

Kalen's public and leadership voice does not use short declarative lines as
dramatic punctuation. Watch for vague pronoun punchlines, abstract subject
punchlines, fragments, and one-sentence paragraphs that imply significance
without explaining it.

Ask:

- Does the line name the actor and action?
- Does it explain the standard, mechanism, or consequence?
- Is it doing meaning work, or only adding rhythm?

Keep a short line when it states a concrete fact, decision, or boundary. Cut it
or fold it into the fuller sentence when it only adds drama.

## Deterministic Gate

Run these only when a shell and the repo are available, and only on files you
actually edited. Check that each script exists first.

```sh
# Default house style gate
./scripts/style_gate.sh path/to/draft.md

# Opt-in AI voice avoidance review
./scripts/review-ai-voice.sh path/to/draft.md

# Opt-in leadership and reflection voice review
./scripts/review-kalen-voice.sh path/to/draft.md

# Opt-in Center of Gravity review
./scripts/review-center-of-gravity.sh path/to/draft.md

# Opt-in No Dramatic Punctuation review
./scripts/review-dramatic-punctuation.sh path/to/draft.md
```

If the gate reports issues, rewrite only the flagged text, preserve meaning, and
rerun. If Vale is not installed, say so, apply the rules by judgment, and let the
user run the gate later. Never treat a clean gate as proof the draft is ready.
Vale coverage is format-dependent. If the edited file is `.mdx` and the gate
output omits it, run the host repository's build and tests for that format and
inspect the
rendered output. Report the omitted file instead of claiming complete Vale
coverage.

## Workflow

1. Identify the deliverable and domain. State the domain you chose.
2. Read local style files when present, per the source-priority ladder.
3. Revise for substance first, then style.
4. For executive, recruiter, public, or leadership work, apply the AI voice
   patterns from the reference file.
5. When AI, agents, abstract work, or nominalized actions may have become the
   protagonist, apply the Center of Gravity check.
6. When public, leadership, blog, social, or personal-positioning prose uses
   short lines as punchlines, apply No Dramatic Punctuation review.
7. For publishable or long-form prose, scan for repeated words and verbal tics.
8. Preserve meaning, facts, and uncertainty.
9. If you edited repo files and a gate script exists, run it at the checkpoint.
10. In your final reply, state the domain used and whether the gate ran.

## Stop Rules

Stop and ask when:

- the requested domain is ambiguous and materially changes the output,
- factual claims lack support and the user wants accuracy,
- the user needs exact legal, compliance, academic, or quoted text preserved,
- a voice rewrite would require inventing personal facts, quotes, dates, or
  results,
- a style fix would change the meaning.

Never invent biography, quotes, or dates to satisfy a voice or style goal.
Never invent citations or business results either.
