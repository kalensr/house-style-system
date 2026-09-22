---
name: house-style-system
description: Use when drafting, revising, reviewing, or polishing prose with the House Style System and its style gate.
---

# House Style System

Use this skill to make human-facing prose clear, direct, useful, and fitted to
the writing domain. It works best with this repo's `HOUSE_STYLE.md`, Vale
rules, examples, and test fixtures.

## When To Use This Skill

Use this skill when the user asks for:

- house style, style gate, plain language, or writing quality review,
- drafting, rewriting, editing, polishing, or humanizing prose,
- repeated words, repeated phrases, verbal tics, or phrase balance,
- Kalen voice review, leadership reflection, public essay voice, or personal
  voice preservation,
- blog, public essay, business, executive, report, student, social, or
  informal writing,
- client proposal, statement of work, completion report, client update, or
  client-facing artifact,
- AI voice avoidance, common AI phrases, recruiter-facing voice drift, or
  personal positioning prose,
- Center of Gravity review, human-centered framing, actor/action clarity, or
  keeping people and teams as the subject when writing about AI,
- No Dramatic Punctuation review, short declarative punchlines, staccato
  emphasis, or fragment lines that imply significance without explanation.

Do not use it for rough notes unless the user asks for style review.

## Domain Selection

If the user names a domain, use it. If not, default to `plain`.

| User says | Domain |
| --- | --- |
| executive memo, leadership update, decision brief | `executive` |
| client proposal, statement of work, completion report, client update | `client-facing` |
| Kalen voice review, leadership reflection, personal essay | `kalen-leadership-reflection` |
| recruiter, executive search, cover letter, career positioning | `personal-positioning` |
| business doc, recommendation, status update | `business` |
| blog, public writing, article, essay for publication | `blog` |
| report, research brief, analysis package | `long-form-report` |
| student essay, academic essay, class paper | `student-essay` |
| LinkedIn, X, social post, announcement | `social-post` |
| note, message, casual, friendly | `informal` |

When the domain is unclear and the choice would change the result, ask one
short question. Otherwise choose the closest domain and state the choice.

## Source Priority

1. If the active project has `HOUSE_STYLE.md`, follow it.
2. If the active project has `docs/domain-modes.md`, use it for domain checks.
3. If the active project has `docs/examples.md`, use it for rewrite patterns.
4. If the active project has `docs/chatgpt-project/ai-voice-avoidance-runbook.md`,
   use it for AI voice avoidance in executive, recruiter-facing, public, and
   leadership writing.
5. If the active project has `docs/client-facing-artifacts.md`, use it for
   proposals, completion reports, statements of work, and client updates.
6. If the active project has `./scripts/style_gate.sh`, run it at deliverable
   checkpoints when files were edited. Prefer project-local specialized
   wrappers when they exist. Otherwise use the system-wide commands:
   `review-kalen-voice.sh`, `review-ai-voice.sh`,
   `review-center-of-gravity.sh`, `review-dramatic-punctuation.sh`, and
   `review-release-writing.sh`. For publishable Markdown, prefer
   `review-release-writing.sh`; add `--kalen-voice` when the Kalen profile
   applies.
   Vale coverage is format-dependent. If the edited file is `.mdx` and the
   review output omits it, run the host repository's build and tests for that
   format and
   inspect the rendered output. Report the omitted file instead of claiming
   complete Vale coverage.
7. If no local files exist, use the fallback rules in this skill.

## Release And Outcome Evidence

For publishable Markdown, run the multi-layer release review before release.
It combines the core, AI Voice, Center of Gravity, and No Dramatic Punctuation
layers; add `--kalen-voice` when that profile applies.

Do not claim a system change improved writing quality from gate alerts alone.
Require a completed independent draft-outcome packet. It needs an independence
attestation and evidence-backed scores. Score factual and meaning preservation,
evidence integrity, and voice fit. Score reader usefulness and generic-pattern
reduction. Also record a blind A/B preference and the post-unblinding revision
mapping.
Use `check-outcome-evaluation.sh` for a packet and
`eval-outcome-evaluation.sh` for the public fixture and negative controls. Do
not publish real draft packets unless the underlying draft and sources are
approved for publication.

## Fallback Core Rules

- Lead with the main point.
- Write for the reader's purpose, context, and time.
- Use short, direct sentences.
- Keep paragraphs short.
- Use concrete nouns, strong verbs, dates, owners, numbers, and examples.
- Avoid jargon when simple words work.
- Define acronyms on first use or remove them.
- Separate facts, assumptions, inferences, recommendations, and open questions
  when it matters.
- Do not use Unicode em dashes.
- Avoid repeated contrast formulas such as `not X, but Y` or repeated
  `can/cannot` sentence scaffolds.
- Avoid negation-first framing such as `The value is not X. It is Y.` State the
  positive claim directly, then explain why it matters.
- Do not use a run of parallel questions or short sentences merely to create
  cadence. Keep questions that frame genuine inquiry. Otherwise, combine
  related details into natural explanatory prose.
- Do not add unsupported claims.
- Watch for repeated vocabulary. Keep terms that carry the argument, but vary
  or cut repeated framing words that stop adding meaning.
- Remove the default AI business voice. Watch for abstract labels before
  concrete facts, role-fit framing, polished but impersonal business language,
  broad diagnosis before proof, and nouns stacked in place of visible action.
- Test whether each noun and verb belong together in natural speech. A phrase
  can be grammatical and still sound synthetic when it makes people depend on,
  support, confront, or transform an abstraction they would not normally
  describe that way. Name the business, person, operation, system, or service
  actually involved. Do not invent an abstract object merely to complete a
  polished sentence.
- Keep the right grammatical center of gravity. When the topic is people,
  teams, customers, decisions, workflows, or organizations adapting to AI, do
  not make AI, agents, abstract work, or nominalized actions the protagonist.
- Do not use short lines as dramatic punctuation. Keep them only when they
  state a concrete fact, decision, or boundary.
- For client-facing work, describe the outcome from the client's working point
  of view. Name who acts, what they can do, the concrete output or changed
  state, and how the result is verified. Use internal artifacts as supporting
  evidence, not as a substitute for the outcome.
- Before rewriting client-facing work, create or inspect a source ledger of
  facts, commitments, assumptions, approval gates, and unresolved decisions.
  Do not invent specificity.

## Spoken-Voice And Anti-Cadence Rules

Treat these as hard rules for authored prose in every domain. Leave quoted text
and code unchanged. Keep commands and citations exact. Preserve required legal
language, product names, and technical terms. Preserve facts and evidence
boundaries. Keep uncertainty and necessary distinctions. When a comparison or
uncertainty matters, state the concrete evidence, scope, or condition directly.

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

Automation catches only high-confidence surface patterns. Human review owns
antithesis and cadence. It also owns paragraph structure, spoken fit, evidence
limits, and whether a necessary technical construction should remain.

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
## Kalen Voice Review Checks

Use these checks when the user asks for Kalen voice review. Treat them as
review prompts, not as a full voice model or score.

A recurring pattern Kalen may choose to preserve:

```text
concrete pressure or opportunity
-> reflective question
-> discernment, thinking, or strategy
-> principle
-> path or next step
-> service horizon when the piece calls for it
```

Check:

- Treat human irregularity as part of the voice, not an automatic defect.
  Distinguish grammatical errors and confusing language from conversational
  awkwardness, familiar phrasing, repetition, and mild redundancy that sound
  natural to the writer. Do not smooth those qualities away unless they impede
  meaning or the user asks for a more polished register.
- Start from the real situation, not a broad abstraction.
- Keep the unresolved question or pressure visible when it matters.
- Preserve first-person inquiry in reflective writing.
- Preserve discernment language when it belongs to the source and audience.
- Show the path from insight to action.
- Require support for claims about groups: evidence, example, lived
  observation, or explicit assumption.
- Read public prose aloud for manufactured cadence. Rework repeated sentence
  openings and question chains when the pattern carries the argument more than
  the meaning does.
- Keep career scope accurate. When fractional work is one part of a broader
  technology-leadership direction, preserve that broader scope unless the
  piece is specifically about fractional work.
- Do not invent biographical details, family details, spiritual experiences,
  dates, quotes, accomplishments, citations, or business results.

### No Dramatic Punctuation Sentences

Kalen's voice does not use short declarative sentences as dramatic
punctuation. Treat this as a hard review rule for public writing and personal
reflection. It also applies to blog drafts, social posts, and leadership
writing.

Flag and rewrite sentences that combine these traits:

- short declarative sentence used for rhythm or drama;
- abstract noun or vague pronoun as the subject;
- implied significance without explanation;
- missing actor, object, standard, mechanism, or consequence;
- sentence sounds quotable but cannot answer "what exactly do you mean?"

Prefer sentences that carry a complete thought. An average sentence length near
or above 12 syllables is acceptable in Kalen's voice. Sentences under 8
syllables should be rare, and usually should be cut or folded into a fuller
sentence unless they state a concrete fact, decision, or boundary.

Before keeping a short sentence, ask:

- Does this sentence name the actor and the action?
- Does it explain the standard, mechanism, or consequence?
- Is it doing meaning work, or only adding rhythm?
- Would Kalen say this plainly in conversation?

Rewrite dramatic compression into concrete operating language. For example,
replace a line like "It raises the standard" with a fuller claim such as:
"I built a system I can trust because I know where the information came from,
I reviewed it, and I know why it is still valuable."

Use automation for repeatable surface signals only. Human review owns audience
fit, evidence, judgment, and whether the draft still sounds right to Kalen.

## Center Of Gravity Review

Use this check when a draft may be putting the wrong thing in subject position.
It applies most often to AI-assisted writing about people and teams. It also
applies to engineering work and leadership. Use it for adoption, operating
change, and organizations adapting to AI.

Ask three questions:

- Sentence: who is the grammatical subject, and should they be?
- Paragraph: what entity controls the paragraph?
- Topic: what is the piece actually about?

Watch for:

- AI, agents, automation, systems, or platforms as the protagonist when people
  are doing the work;
- vague subjects such as `the work`, `this work`, `the pattern`, `this`, or
  `it`;
- nominalized actions such as `adoption`, `implementation`, `alignment`,
  `modernization`, or `evaluation` carrying the sentence;
- paragraphs where tools dominate subject position while people disappear.

Repair by naming the person, team, customer, or organization. You can also name
the decision, workflow, or concrete change. Keep AI or agents in the sentence
when they matter. Make them tools or constraints unless they are truly the
actor.

When a workflow is the topic, make a concrete actor the subject of the
sentence. Name the team or leader involved. Name the customer, system, or
decision involved.
A workflow can be the object being examined; phrases such as `the work can stay
connected` leave the actor hidden.

## Domain Checks

`plain`: make the text clear, direct, and usable.

`kalen-leadership-reflection`: preserve concrete pressure, reflection, and
discernment or thinking when they belong. Keep the principle and path to action
visible. Do not turn personal reflection into generic executive prose.

`executive`: state the answer or recommendation early. Make tradeoffs and risks
visible. Name owners, dates, and next steps. Remove throat-clearing.

`client-facing`: start from the client's situation and proposed change.
Organize the document around recognizable workstreams. For each workstream,
state what it covers and the agreed outcome. The outcome should name the
client or user and the action. It should state the concrete output or changed
operating state, visible proof, and any safeguard or boundary. Keep internal planning fields,
agent activity, estimation mechanics, and repository language out unless they
are explicitly part of the agreement.

Review client-facing work in three passes: factual preservation, client
usefulness, and voice fit. The assigned agent completes those passes and leaves
a short review record. Do not make a separate user review a completion gate
unless the task, engagement, or risk explicitly requires it.

`personal-positioning`: open politely. State the role family directly. Show the
before state and what changed. Use proof across career stages. State the current
search boundary and close with a plain invitation. Do not over-teach the fit.

`business`: clarify the decision, update, recommendation, and risk. Name the
owner and next step. Separate facts from judgment.

`blog`: make one strong idea visible. Preserve the author's voice. Explain the
problem, solution, evidence, and implication without sounding corporate.

State positive claims directly. Use questions sparingly and for genuine
inquiry. Summarize related operating details in prose when a question chain
would create artificial rhythm. When career positioning belongs in the article,
describe the leadership scope the author intends to communicate. Do not narrow
it to a single engagement model unless that focus is deliberate.

For a short practical article about operating change, use this sequence when it
fits the source material:

1. Open with the concrete decision or workflow question.
2. Establish the current state before recommending a tool or solution.
3. Name the people, information, controls, and decisions inside the work.
4. Give AI a specific supporting role and keep accountable people as the actors.
5. Explain where an explicit rule, system, or human judgment governs the outcome.
6. End with one practical first move.

The result should give the reader a usable way to think about the work. Avoid
résumé inventory, transformation language, generic advocacy for AI, and a sales
pitch. Keep the structure compact, with each section advancing the argument.

`long-form-report`: give each section a purpose. Lead sections with claims.
Connect evidence to implications. End with a decision path or research
conclusion.

`student-essay`: preserve the student's level and voice. State the claim.
Connect cited evidence to the claim. Never treat style as proof of authorship.

`social-post`: make one clear point for a specific audience. Include one
concrete detail. Avoid generic uplift and stock conclusions.

`informal`: put the practical context first. Allow contractions and short
fragments. Keep warmth without filler.

## Repetition And House Vocabulary Check

Use this check for blog posts, essays, long-form reports, and executive
writing. It also applies when repeated wording makes an argument feel circular.

Goal:

- Preserve terms that carry the argument.
- Reduce words that become verbal wallpaper.
- Replace repetition only when the replacement keeps the meaning precise.

Workflow:

1. Scan the draft for repeated words and repeated phrases.
2. Separate core terms from overused framing words.
3. Keep core terms when consistency helps the reader.
4. Vary or cut words that repeat without adding meaning.
5. Prefer stronger nouns and verbs over generic substitutes.
6. Re-read the changed paragraph for rhythm and meaning.

Common public-writing terms that may need balancing:

| Term pattern | Keep when it means | Possible alternatives |
| --- | --- | --- |
| `important` | real priority or consequence | specific, urgent, high-risk, useful, central |
| `clear` | reader comprehension | direct, specific, plain, visible, easy to follow |
| `system` | a real set of rules or parts | process, method, standard, checklist, tool |
| `framework` | an organized way to think or act | model, guide, structure, method, starter kit |
| `quality` | a defined standard | clarity, evidence, accuracy, usefulness, fit |
| `value` | a concrete benefit | time saved, risk reduced, better decision, clearer draft |
| `review` | a check before use | edit, critique, fact check, readiness check |
| `AI` | the tool or workflow truly depends on AI | model, draft, assistant, automation, tool |

Do not replace terms mechanically. If a named concept matters, keep the name
and balance the surrounding prose.

## Workflow

1. Identify the deliverable and domain.
2. Read local style files when present.
3. Draft or revise for substance first, then style.
4. For publishable or long-form prose, run the Repetition And House Vocabulary
   Check before final polish.
5. Preserve meaning, facts, and uncertainty.
6. For client-facing work, complete the factual-preservation,
   client-usefulness, and voice-fit passes described in
   `docs/client-facing-artifacts.md` when that file is available.
7. If editing files and a local `style_gate.sh` exists, run it at the
   checkpoint. For publishable Markdown, run the local release-review wrapper
   instead of a single optional layer.
8. If a specialized review applies and a file path is available, prefer its
   project-local `./scripts/review-*.sh` wrapper. Otherwise run the matching
   system-wide `review-*.sh` command.
9. If specialized rules were changed or reviewed, prefer the project-local
   `./scripts/eval-*.sh` wrapper. Otherwise run the matching system-wide
   `eval-*.sh` command.
10. If the gate reports issues, rewrite only the violating text and rerun.
11. If an edited `.mdx` file was skipped by Vale, state that limitation and name
   the build, test, or rendered-output validation that covered it.
12. For a system-quality claim, require an independent outcome-evaluation packet
    with an independence attestation, factual and meaning preservation,
    evidence integrity, voice fit, reader usefulness, generic-pattern-reduction,
    and blind-preference scores. Record the revision mapping after unblinding.
    Do not claim that a clean release review proves quality improved.
13. In the final response, state the domain used and whether validation ran.

## Stop Rules

Stop and ask when:

- the requested domain is ambiguous and materially changes the output,
- factual claims lack support and the user asks for accuracy,
- the user asks to preserve exact legal, compliance, academic, or quoted text,
- a Kalen voice rewrite would require inventing personal facts or spiritual
  experiences,
- style cleanup would change the meaning.
