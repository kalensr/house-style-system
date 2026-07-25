# House Style

Purpose: help people write prose that readers can understand, trust, and use.

Use this as a starter standard. It is ready to use as-is, but it should become more specific as your own work, audience, and review habits become clearer.

## Core Standard

Write for the reader's purpose, context, and time.

Every sentence should help the reader understand the point, make a decision, take action, or trust the work.

## Observable Client Outcomes

Use this rule for proposals, statements of work, and completion reports. It
also applies to client updates and other writing that explains what a client
will receive.

Describe the result from the client's working point of view. Name the people
who will use the result, what they will be able to do, what they will see or
receive, and how they can verify that the work is complete. Concrete operating
behavior should lead. Supporting artifacts, controls, and technical work
should explain how that behavior becomes trustworthy.

Avoid using an inventory of internal deliverables as a substitute for the
outcome. A list may include an `implementation brief`, `workflow map`,
`architecture decision record`, and `acceptance evidence`. The list may be
accurate without showing the client what changes in the working day.

Use this sequence when it fits:

```text
client or user
-> action or decision
-> concrete output or changed operating state
-> visible proof
-> safeguard or boundary
```

Before rewriting, build a source ledger. Record facts, commitments,
assumptions, and unresolved decisions. Preserve those facts exactly. Do not
make the prose more concrete by inventing a role or artifact. Do not invent
behavior, results, or acceptance conditions.

Review the draft in three passes:

1. **Factual preservation:** every material claim traces to the source, and no
   uncertainty has been converted into a promise.
2. **Client usefulness:** the reader can tell what changes, who acts, what they
   receive, and what decision or next step is required.
3. **Voice fit:** the writing is direct, concrete, and natural for the client
   relationship without sounding like an internal plan or a generic sales
   document.

The writer or assigned reviewer can perform these passes autonomously. A
separate client or owner review is required only when the engagement, approval
policy, or risk calls for it; it is not a default prerequisite for applying
this method.

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

### Client Proposal Or Client-Facing Artifact

- Start with the client's situation and the proposed change.
- Organize work around client-recognizable workstreams or operating outcomes.
- Explain what each workstream covers in plain language.
- State the agreed outcome as observable behavior, concrete output, or a
  decision the client can verify.
- Name supporting artifacts only when they help the reader understand or trust
  the result.
- Keep internal planning fields, agent activity, estimation mechanics, and
  repository language out of the client document unless they are explicitly
  part of the agreement.
- Preserve scope boundaries, assumptions, approval gates, and unresolved
  decisions.

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
- Simplify the operating claim, and preserve the reflective anchor. Keep an
  original sentence when its human question, image, tension, or cadence carries
  the idea. Revise surrounding sentences when they hide action, ownership, or
  practical meaning. Do not mechanically shorten or split every dense sentence.
- Keep a metaphor that gives the piece its meaning when a plainer replacement
  would flatten it. Make the next operating sentence direct instead: name what
  people will do, how AI helps, and who remains accountable for the decision.
- Treat this as a human-review question. Automated findings are prompts, not
  instructions to remove an intentional voice choice.
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
- For a client-facing artifact, can the reader see who will do what, what will
  change, and how the result will be verified?
- Did the review preserve every material fact, boundary, assumption, and open
  decision from the source?

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
