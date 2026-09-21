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
- Avoid negation-first framing such as `The value is not X. It is Y.` State Y
  directly, then explain why it matters.
- Do not use a run of parallel questions or short sentences merely to create
  cadence. Keep a question when it frames a real inquiry. Otherwise, combine
  related details into a natural explanatory sentence or paragraph.
- Do not use Unicode em dash characters.

## Spoken-Voice And Anti-Cadence Rules

These are hard rules for authored prose in every domain. Leave quoted text and
code unchanged. Keep commands and citations exact. Preserve required legal
language, product names, and technical terms. Preserve facts and evidence
boundaries. Keep uncertainty and necessary distinctions. When the reader needs
a comparison or statement of uncertainty, give the concrete evidence, scope,
or condition directly.

- **No antithesis.** Do not frame a point through balanced opposition.
- **No corrective negation.** Do not reject one formulation so a second
  formulation can replace it. State the intended claim first.
- **No paragraph pinning.** Do not open a paragraph with a claim and close by
  restating or intensifying the same claim.
- **No parataxis.** Do not place independent clauses or short declarative
  sentences side by side for cadence. Explain the relationship between ideas.
- **No summary beats.** Do not add a sentence that recaps the sentence,
  example, paragraph, or section that came immediately before it.
- **No rhetorical crutches.** Remove framing such as `Here is the thing`,
  `What matters is`, `The key is`, or `It is worth noting`.
- **No negative parallelisms.** Do not build parallel clauses around repeated
  negation.
- **No negative anaphoras.** Do not begin successive sentences or clauses with
  `No`, `Not`, `Never`, or another repeated negative opening.
- **No contrasting pairs.** Do not organize an idea as a rhetorical binary.
  Present necessary comparisons as concrete facts, conditions, or tradeoffs.
- **No rule of three.** Do not manufacture triads for rhythm or memorability.
  Include the number of items the subject requires.
- **No em dashes.** Use a comma, colon, parentheses, or a sentence break.
- **No throat-clearing openers.** Begin with the subject, situation, decision,
  or request.
- **No landing sentences.** Do not add a final sentence whose only purpose is
  to restate significance, deliver a punchline, or create closure.
- **No setup/payoff constructions.** Do not withhold the main point to stage a
  reveal. Give the reader the point when it becomes relevant.
- **No parallel sentence structures within a paragraph.** Change syntax and
  sentence movement instead of repeating the same grammatical frame.
- **Vary sentence length unpredictably.** Let meaning determine length. Avoid
  a recurring short-medium-long pattern or a run of similar lengths.
- **No stacked noun phrases.** Name an actor, use a finite verb, and make the
  object or result concrete.
- **No filler intensifiers.** Remove `genuinely`, `really`, `truly`, and
  `actually` unless the word changes the literal meaning of quoted material.
- **No corporate-register verbs.** Replace `leverage`, `underscore`, and
  `reflect` with the specific action or claim.
- **No nominalization.** Use a named actor and a finite verb when an action is
  available. Keep fixed technical terms when precision requires them.
- **No hedging qualifiers.** Do not use a qualifier to avoid making the claim.
  Name the evidence limit, unknown, condition, or confidence level directly.
- **Write for the spoken voice.** Prefer words and sentence movement the writer
  would use aloud with the intended reader.
- **No performed enthusiasm.** Do not add excitement or uplift. Preserve
  gratitude and confidence only when the writer expressed them. State interest
  or appreciation plainly when it is real.

## Natural Voice And Sloganized Synthesis

Treat **sloganized synthesis** as an umbrella review finding. It appears when a
draft compresses a concrete situation into a polished formula that sounds more
finished than the underlying reasoning. Review these four demonstrated forms:

- **Abstract causal formula.** Two abstract ideas are connected through a
  spatial or causal metaphor, such as one idea being upstream or downstream of
  another, without explaining the actual sequence.
- **Sloganized parallelism.** Repeated words, mirrored clauses, or wordplay make
  a sentence memorable while leaving the practical claim unclear.
- **Depersonalized case narration.** A generic consultant, company, or team
  appears in a case-study voice even when the source permits clearer
  attribution of who observed, decided, or acted.
- **Authoritative solution label.** Phrases such as `The fix was`, `The answer
  is`, or `The lesson is` announce a clean conclusion before the evidence has
  earned it.

Start with the person, situation, observation, or decision. Explain the real
sequence before drawing a lesson. Preserve friction, uncertainty, and causal
gaps that remain in the source. Do not force a list of three or a neat ending.
Read the passage aloud and ask whether the writer would explain it that way in
conversation.

Nominate these passages for review instead of rejecting them automatically.
Technical uses of terms such as `upstream` and `downstream` may remain. Factual
lists and source-required anonymity may remain. The same exception applies to
quotations, legal language, and precise technical terms. Resolve each
nomination as `revised`,
`retained_with_reason`, or `protected_source`. A disposition applies only to
the exact passage and rule reviewed.
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
- Does the prose use repeated sentence openings or question chains for
  manufactured cadence?
- Does career language preserve the author’s intended leadership scope?

Do not use this layer to imitate private writing samples, certify authorship, or
claim that a clean gate means a draft is ready. It is a review aid.

## Center Of Gravity Review Layer

Use this layer when a draft may be making the wrong thing the subject. It is
especially useful for AI-assisted writing about teams and engineering work. It
also helps with leadership, adoption, operating change, and people adapting to
AI.

The core question:

```text
What is the real subject of this sentence, paragraph, and topic?
```

Watch for:

- AI, agents, automation, or systems as the protagonist when people are doing
  the work,
- vague subjects such as `the work`, `this work`, `the pattern`, `this`, or
  `it`,
- nominalized actions such as `adoption`, `implementation`, `alignment`, or
  `modernization` carrying the sentence,
- paragraphs where tools dominate subject position while people disappear.

Prefer sentences where the actor and action are visible:

```text
Engineering teams are changing how they use AI to review architecture
decisions.
```

When a workflow is the topic, make a concrete actor the subject of the
sentence. Name the team or leader involved. Name the customer, system, or
decision involved.
A workflow can be the object being examined; phrases such as `the work can stay
connected` leave the actor hidden.

Run the optional checks with
`./scripts/review-center-of-gravity.sh <file>`.

Human review owns paragraph and topic fit. Automation only catches repeatable
surface signs.

## No Dramatic Punctuation Review Layer

Use this layer when a draft uses short lines as drama instead of explanation.
It is especially useful for public essays and leadership reflection. It also
applies to social posts, personal positioning, and blog drafts.

Watch for:

- vague pronoun punchlines such as `This matters.`,
- abstract subject punchlines such as `The standard rises.`,
- fragments such as `No shortcuts.` when they do not carry a concrete fact,
- one-sentence paragraphs that imply significance without explaining it.

Prefer sentences that name who acts and what happens. They should also name the
standard, mechanism, or consequence. A short sentence can stay when it states a
concrete fact. It can also stay when it states a decision or boundary. Cut it or
fold it into a fuller sentence when it only adds rhythm.

Run the optional checks with
`./scripts/review-dramatic-punctuation.sh <file>`.

Human review owns rhythm, audience fit, and final judgment. Automation only
catches repeatable surface signs.

## AI-Assisted Writing Rules

AI output is draft material.

Do not only imitate Kalen's voice. Remove the default AI business voice.

Default AI voice often shows up as:

- abstract labels before concrete facts,
- polished but impersonal business language,
- broad diagnosis before proof,
- nouns stacked in place of visible action,
- claims that compress several real events into one vague phrase.

When a sentence sounds generated, repair it by naming the real thing:

1. actor,
2. action,
3. system or workflow,
4. before state,
5. friction or risk,
6. decision or ownership,
7. result or after state.

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

## Release Review And Outcome Evaluation

For a publishable Markdown draft, run the required multi-layer review:

```sh
./scripts/review-release-writing.sh path/to/draft.md
./scripts/review-release-writing.sh --kalen-voice path/to/draft.md
```

The default release review runs the core House Style, AI Voice, Center of
Gravity, and No Dramatic Punctuation layers together. Add `--kalen-voice` when
Kalen's leadership, reflection, or public-essay review applies. Fix or record
an intentional exception for every alert before release.

The release review checks known patterns. It does not measure whether the
revision improved a real draft. Do not claim that a rule, evaluator, or workflow
improved writing quality until an independent evaluator completes a blind A/B
outcome review. The evaluator needs the source packet for factual checks, must
not have authored the revision, and must attest to independence.

Record factual and meaning preservation with evidence integrity. Also record
voice fit, reader usefulness, and generic-pattern reduction. Record the blind
A/B preference and revision mapping after unblinding. Keep the completed packet
private and validate its structure with `./scripts/check-outcome-evaluation.sh`.

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

### Personal Positioning Or Recruiter-Facing Writing

- Open politely.
- State the role family directly.
- Show the before state.
- Name what changed.
- Prove the pattern across career stages.
- State the current search boundary.
- Close with a plain invitation.
- Do not over-teach the fit.
- Avoid role-fit framing such as `the opportunities that match my background`.

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
- State the positive claim directly instead of opening with a negation.
- Use questions for genuine inquiry. Summarize related operating details in
  prose when a question chain would create artificial rhythm.
- When career positioning belongs in the article, describe the leadership scope
  the author intends to communicate. Do not narrow it to a single engagement
  model unless that focus is deliberate.

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
