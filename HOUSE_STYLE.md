# House Style

Purpose: help people write prose that readers can understand, trust, and use.

Use this as a starter standard. It is ready to use as-is, but it should become more specific as your own work, audience, and review habits become clearer.

## Core Standard

Write for the reader's purpose, context, and time.

Every sentence should help the reader understand the point, make a decision, take action, or trust the work.

## Default Rules

- State the main point early.
- Use plain language.
- Prefer short sentences and direct verbs.
- Keep paragraphs short.
- Use one main idea per paragraph when practical.
- Use concrete nouns, numbers, dates, owners, and examples when available.
- Define acronyms on first use.
- Separate facts, assumptions, inferences, recommendations, and open questions when it matters.
- Avoid filler phrases and weak modifiers.
- Avoid jargon unless the reader uses it.
- Avoid repeated contrast scaffolding such as `not X, but Y`, `X can do A. It cannot do B.`, or repeated `not the...` sentence clusters.
- Use direct claims, ownership language, or specific standards instead.
- Do not use Unicode em dash characters.

## Kalen Voice Review Layer

Use this first-slice review layer when Kalen asks for his leadership or
strategy prose to be checked against recurring voice risks. It can also support
reflection and public essays. Use it for speeches, books, and executive prose
when Kalen asks for that review.

This layer is a small set of review prompts. It points to a pattern Kalen may
choose to preserve:

```text
concrete pressure or opportunity
-> reflective question
-> discernment, thinking, or strategy
-> principle
-> path or next step
-> service or mission horizon when the piece calls for it
```

Automation checks only repeatable risks:

- generic openings,
- abstract leadership openings,
- future-state claims with no visible path,
- group claims without evidence or an explicit assumption,
- generic executive polish,
- repeated contrast formulas.

Run the optional checks with `./scripts/review-kalen-voice.sh <file>`.

Human review owns the deeper questions:

- Does the draft preserve the lived situation?
- Is the unresolved question still visible when it matters?
- Did editing remove real pressure, gratitude, uncertainty, or conviction?
- Does the piece move from insight to action?
- Does it fit the audience and domain?

Do not use this layer to imitate private writing samples, certify authorship, or
claim that a clean gate means a draft is ready. It is a review aid.

## AI-Assisted Writing Rules

AI output is draft material.

Human review owns:

- truth,
- evidence,
- judgment,
- recommendation quality,
- audience fit,
- tone,
- final accountability.

Automation owns repeatable checks.

A style gate flags known style risks. Human review proves claims, earns conclusions, and decides whether the work is ready.

## Preferred Patterns

Use:

- `use` instead of `utilize`
- `help` or `improve` instead of vague `drive`
- `clear` or `specific` instead of `robust`
- `Automation owns repeatable checks. Human review owns truth, judgment, recommendation quality, and tone.` instead of repeated `can/cannot` contrast lines
- direct standards instead of negative framing

## Domain Modes

Use the core rules everywhere. Add the right mode for the work.

### Business Document

- State the decision, update, or recommendation early.
- Name the owner, next step, and date when action is needed.
- Make risks and tradeoffs visible.
- Separate facts from judgment.

### Executive Memo

- Lead with the recommendation or decision.
- Keep evidence close to the claim it supports.
- State the tradeoff plainly.
- End with the action needed.

### Kalen Leadership Reflection

- Consider starting from a real situation, question, pressure, or opportunity.
- Let the reader see the tension before the conclusion when the piece is reflective.
- Preserve first-person inquiry when it helps the reader follow the thinking.
- Preserve discernment language when it belongs to the source and audience.
- Show the path from idea to action.
- Tie leadership to service, team, organization, community, or mission when that horizon matters.

### Blog Or Public Essay

- Make one strong idea visible.
- Preserve the writer's point of view.
- Use examples.
- Avoid generic uplift and stock conclusions.
- Do not overstate evidence.

### Long-Form Report

- Give each section a clear purpose.
- Lead each section with its main claim.
- Connect evidence to implications.
- Define technical terms.
- End with a decision path, recommendation, or research conclusion.

### Informal Note

- Put the practical context first.
- Use a natural tone.
- Allow contractions and short fragments when they help.
- Keep warmth without adding filler.

### Student Or Learning Use

- Treat style signals as review prompts, not proof of authorship.
- Preserve the student's voice and level.
- State the claim.
- Support claims with cited evidence.
- Explain how the evidence supports the claim.

## Review Checklist

Before handoff, ask:

- Is the main point visible in the first few lines?
- Is the reader clear?
- Does each paragraph have one job?
- Are acronyms defined or removed?
- Are facts, assumptions, and recommendations separated when needed?
- Does the tone fit the domain and channel?
- Does every important claim have support?
- Are next steps concrete when action is needed?
- Did the style gate run?
- Are accepted warnings intentional?

## Exception Policy

A warning can stand when the wording is necessary for:

- a quote,
- a source title,
- a product name,
- a technical term,
- a deliberate voice choice.

Keep the reason short. Do not rewrite source material only to satisfy a style rule.

## Important Boundary

This system improves writing quality. It does not detect authorship.

Do not use it to accuse someone of using AI. Do not use it to prove that a person wrote something. Use it to improve clarity, evidence, specificity, and judgment.
