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
- AI voice avoidance, common AI phrases, recruiter-facing voice drift, or
  personal positioning prose.

Do not use it for rough notes unless the user asks for style review.

## Domain Selection

If the user names a domain, use it. If not, default to `plain`.

| User says | Domain |
| --- | --- |
| executive memo, leadership update, decision brief | `executive` |
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
5. If the active project has `./scripts/style_gate.sh`, run it at deliverable
   checkpoints when files were edited.
   When Kalen voice review applies and `./scripts/review-kalen-voice.sh`
   exists, run `./scripts/review-kalen-voice.sh <file>`.
   When AI voice review applies and `./scripts/review-ai-voice.sh` exists, run
   `./scripts/review-ai-voice.sh <file>`.
6. If no local files exist, use the fallback rules in this skill.

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
- Do not add unsupported claims.
- Watch for repeated vocabulary. Keep terms that carry the argument, but vary
  or cut repeated framing words that stop adding meaning.
- Remove the default AI business voice. Watch for abstract labels before
  concrete facts, role-fit framing, polished but impersonal business language,
  broad diagnosis before proof, and nouns stacked in place of visible action.

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

- Start from the real situation, not a broad abstraction.
- Keep the unresolved question or pressure visible when it matters.
- Preserve first-person inquiry in reflective writing.
- Preserve discernment language when it belongs to the source and audience.
- Show the path from insight to action.
- Require support for claims about groups: evidence, example, lived
  observation, or explicit assumption.
- Do not invent biographical details, family details, spiritual experiences,
  dates, quotes, accomplishments, citations, or business results.

### No Dramatic Punctuation Sentences

Kalen's voice does not use short declarative sentences as dramatic
punctuation. Treat this as a hard review rule for public writing, personal
reflection, blog drafts, social posts, and leadership writing.

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

## Domain Checks

`plain`: make the text clear, direct, and usable.

`kalen-leadership-reflection`: preserve concrete pressure, reflection, and
discernment or thinking when they belong. Keep the principle and path to action
visible. Do not turn personal reflection into generic executive prose.

`executive`: state the answer or recommendation early. Make tradeoffs and risks
visible. Name owners, dates, and next steps. Remove throat-clearing.

`personal-positioning`: open politely. State the role family directly. Show the
before state and what changed. Use proof across career stages. State the current
search boundary and close with a plain invitation. Do not over-teach the fit.

`business`: clarify the decision, update, recommendation, and risk. Name the
owner and next step. Separate facts from judgment.

`blog`: make one strong idea visible. Preserve the author's voice. Explain the
problem, solution, evidence, and implication without sounding corporate.

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
6. If editing files and a local `style_gate.sh` exists, run it at the
   checkpoint.
7. If Kalen voice review applies and a file path is available, run
   `./scripts/review-kalen-voice.sh <file>` when available. If the wrapper is
   missing, run `./scripts/style_gate.sh --kalen-voice <file>`.
8. If AI voice review applies and a file path is available, run
   `./scripts/review-ai-voice.sh <file>` when available.
9. If Kalen voice rules were changed or reviewed, run
   `./scripts/eval-kalen-voice.sh` when available.
10. If AI voice rules were changed or reviewed, run
   `./scripts/eval-ai-voice.sh` when available.
11. If the gate reports issues, rewrite only the violating text and rerun.
12. In the final response, state the domain used and whether validation ran.

## Stop Rules

Stop and ask when:

- the requested domain is ambiguous and materially changes the output,
- factual claims lack support and the user asks for accuracy,
- the user asks to preserve exact legal, compliance, academic, or quoted text,
- a Kalen voice rewrite would require inventing personal facts or spiritual
  experiences,
- style cleanup would change the meaning.
