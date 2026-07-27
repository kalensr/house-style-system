# Voice and Anti-AI Style Assessment

## Bottom Line

The House Style System favors writing that helps a reader understand a real
situation, judge the evidence, and see the next action. Kalen's voice adds a
reflective dimension: it can begin with pressure or opportunity, show the
question being worked through, state the principle that emerged, and then show
the path forward.

The system does not aim for a synthetic "human" sound. It rejects generic
business prose that hides people, facts, decisions, or consequences. It also
does not use style signals to determine authorship. They are review prompts.

## Evidence Used

This assessment treats the current repository behavior as the source of truth.
It draws from the core style guide, optional Vale rule sets, their negative and
near-miss fixtures, and the review wrappers. The [public research
assessment](../research/house-style-system-assessment.pdf) is useful context,
but it is not a current scorecard: its provenance note says that implementation
may have evolved after it was prepared. That distinction matters because the
current repository now includes domain modes, expanded plain-language checks,
and four opt-in review layers.

The two current research notes explain the linguistic rationale for the newer
layers: [Center of Gravity](research/center-of-gravity-writing-eval.md) for
actor and subject position, and [No Dramatic
Punctuation](research/no-dramatic-punctuation-eval.md) for unsupported
emphasis.

## Training-Handoff Role

This document provides public-safe behavioral guidance for voice-model
training. It does not contain or authorize use of private writing. The training
workflow needs three separate inputs, each with a different job:

| Input | Training role | Do not treat it as |
| --- | --- | --- |
| Private, owner-approved authored corpus | The source for language, cadence, perspective, and domain variation | Automatically safe, representative, or approved merely because it is authored |
| Positive Kalen voice controls | A compact expression of the desired reflective pattern | A substitute for the broader authored corpus |
| Negative fixtures and AI-style controls | Rejected behavior, rewrite guidance, and regression tests | Positive assistant targets or proof that a phrase is always wrong |
| Near-miss controls | Protected examples that prevent overcorrection | A comprehensive list of permissible language |
| Core and optional style rules | Explicit preference constraints for evaluation and review | An authorship detector or a complete model of personal voice |

The training objective is a model that defaults to concrete, evidence-aware,
human-centered writing and avoids generic executive polish. It should learn
that the four optional layers are complementary preference checks:

1. Kalen voice preserves reflection, pressure, discernment, and an actionable
   path.
2. AI voice avoidance rejects abstraction-first and formulaic business prose.
3. Center of Gravity keeps people, teams, customers, decisions, and workflows
   in the grammatical center when they are the real subject.
4. No Dramatic Punctuation rejects unearned emphasis while preserving concrete
   facts, decisions, boundaries, and natural informal brevity.

Use negative fixtures as rejected responses in a preference or evaluation
workflow, never as desired assistant completions. Use the corresponding
near-miss controls to verify that the model does not overcorrect into sterile
or unnatural prose. The private corpus and owner review determine whether any
real example is eligible for training.

## What the Voice Favors

| Preference | What it means in practice |
| --- | --- |
| Start with the real situation | Open with a concrete pressure, decision, question, opportunity, or before state. Do not begin with a large claim about leadership, change, or technology. |
| Let the thinking show | In reflective work, preserve first-person inquiry, discernment, uncertainty, gratitude, or conviction when it helps the reader follow the reasoning. Do not polish those qualities away merely because they are less formal. |
| Move from insight to a path | A principle, vision, or future state earns its place when the draft shows steps, owners, evidence, timing, rationale, risks, or a sequence that readers can inspect. |
| Keep people and work visible | Name the person, team, customer, organization, decision, workflow, or operating change that carries the action. Use active verbs and specific objects. |
| Put evidence close to the claim | Distinguish fact, observation, inference, assumption, recommendation, and open question when the distinction affects trust or action. Support broad claims about groups with evidence, an example, a lived observation, or an explicit assumption. |
| Explain the mechanism | When a change matters, show the before state, friction or risk, decision or ownership, and the resulting condition. A reader should not have to guess what changed. |
| Respect the reader's purpose | State the main point early, use plain language, define acronyms, make tradeoffs visible, and choose the appropriate domain mode rather than forcing every piece into executive-memo form. |
| Preserve useful human variation | Mild redundancy, familiar phrasing, and conversational irregularity may belong in the voice. They should change only when they impede meaning or the writer wants a more polished register. |

The Kalen voice fixture shows the preferred reflective sequence:
specific decision and pressure, a question, the principle that follows from the
thinking, then an actionable path. See [the positive
control](evals/kalen-voice/positive-leadership-reflection.md).

## What the Voice Rejects

| Drift pattern | Why it fails | Preferred repair |
| --- | --- | --- |
| Generic or abstract openings | A broad statement about leadership, innovation, or change delays the situation that gives the statement meaning. | Lead with the decision, pressure, observable symptom, or question. |
| Polished executive fog | Phrases about initiatives, alignment, value, stakeholders, or transformation can sound authoritative while hiding the work. | Name who made which decision, what they changed, and the consequence. |
| Diagnosis before proof | Labels such as fragmented, reactive, or inefficient compress several possible facts into a tidy verdict. | Show the systems, handoffs, incidents, dates, or ownership gaps that justify the diagnosis. |
| Empty work nouns and coordinated abstractions | References to the work, alignment, ownership, or execution can substitute categories for actions. | Name the task, team, system, decision, reviewer, or customer. |
| AI or automation as the default protagonist | When people are adapting, deciding, reviewing, or owning work, a tool should not displace them as the grammatical center. | Keep AI in the sentence when it matters, but make the human or organizational actor the subject unless the tool is truly acting. |
| Future-state claims without a route | A vision is not yet guidance if the draft gives no way to judge or follow it. | Add a pathway, including the relevant owner, steps, evidence, timing, or risks. |
| Role-fit framing | Phrases about roles or opportunities that match a background can make career writing sound generated and indirect. | State the role family directly, then show proof through concrete experience and operating results. |
| Dramatic compression | Vague punchlines, abstract one-line paragraphs, and fragments can imply importance without supplying meaning. | Fold the idea into a complete sentence that names the actor, action, standard, mechanism, or consequence. Keep short sentences for concrete facts, decisions, or boundaries. |
| Mechanical contrast and typographic drama | Repeated contrast formulas and Unicode em dashes can make prose feel constructed around cadence instead of meaning. | State the positive claim, ownership, or standard directly. |

The system does not ban a word, a short sentence, an abstraction, or AI as a
subject in every context. Each is a risk signal. Precision, quotation,
technical necessity, and deliberate voice can justify an exception.

## How the Evals Turn the Style Into Reviewable Behavior

| Layer | It checks | What the fixtures prove | What remains human judgment |
| --- | --- | --- | --- |
| Core house style | Plain language, filler, jargon, acronym candidates, sentence complexity, stock conclusions, contrast patterns, and em dashes | The default gate catches defined surface risks | Reader usefulness, factuality, and whether a necessary technical term should remain |
| Kalen voice | Generic openings, abstract leadership openings, unsupported group claims, unsupported future-state language, and generic executive polish | The negative control alerts and the positive and near-miss controls stay clean | Whether the draft preserves lived context, reflection, discernment, and a genuine fit with Kalen's voice |
| AI voice avoidance | Abstract business needs, empty work nouns, pattern-first openings, flattened before states, vague consequences, coordinated abstractions, and role-fit language | Expected patterns alert, including wording variants, while grounded near misses stay clean | Whether the prose is true, useful, original, or authored by a person |
| Center of Gravity | Tool protagonists, vague work subjects, and nominalized actions in subject position | Level 1 rules distinguish the targeted sentences from human-actor and named-work near misses | Whether a paragraph and the full topic are centered on the right entity |
| No Dramatic Punctuation | Vague pronoun punchlines, abstract punchlines, and selected emphasis fragments | Known high-risk short lines alert while concrete boundaries and complete standards stay clean | Rhythm, channel fit, and whether a short sentence carries enough meaning in context |

The fixtures are an important strength. Each optional layer has both failure
controls and near misses, so the intended behavior includes what should remain
unflagged. The Kalen voice controls are synthetic and public-safe; they do not
copy private source writing or claim to authenticate a writer.

## Research Correlation

| Research finding or caution | Current house-style response | Assessment |
| --- | --- | --- |
| The PDF assessment uses AI-detection taxonomy as a diagnostic lens, not an authorship test. It identifies generic vocabulary, sentence patterns, polish, introductions, conclusions, tone, factual texture, and topic avoidance as relevant risks. | The core guide and AI voice layer turn a small, concrete subset into suggestions. The repository also states the authorship boundary in its main guide and eval documentation. | This is the right operating stance. Quality review is useful; authorship claims would exceed the evidence. |
| The PDF recommends small, objective warnings, domain modes, examples, and an exception policy rather than a large compliance system. | The current repository contains domain modes, examples, deterministic Vale rules, optional layers, fixtures, and an exception policy. | The implementation has addressed much of the PDF's recommended direction. Its older numeric coverage scores should not be reused without a fresh assessment. |
| Research on nominalization and subject position explains why noun-heavy prose can hide actor and action. Theme and thematic progression extend that issue beyond a sentence. | Center of Gravity makes actor and action a sentence-level rule and documents paragraph and topic review as later levels. | The current Level 1 automation is appropriate. The more consequential paragraph and topic questions correctly remain human review until an entity-role method is proven useful. |
| Research on sentence fragments, topic control, cohesion, and sentence rhythm supports skepticism toward emphasis without explanation. | No Dramatic Punctuation flags a narrow set of vague or abstract short lines and asks a reviewer to check actor, action, mechanism, standard, or consequence. | The narrow scope reduces false positives. It should stay a prompt rather than a blanket ban on short sentences. |
| Detection research warns that models and detectors are unreliable, domain-bound, and potentially unfair, especially across different writers and use cases. | The public assessment, core guide, and evaluation documentation repeatedly limit the gate to style risks. | This boundary is essential for student, hiring, public, and cross-cultural writing. |

## Current Assessment

The rules have a coherent point of view: clear writing should expose the real
subject and action rather than decorate an abstraction. They work best when an
author needs to support a decision, show evidence, explain operating change, or
carry leadership reflection without collapsing into generic executive language.

Its technical design is sound for that purpose. Optional layers keep the
default gate lightweight, and test fixtures define both intended alerts and
protected near misses. This is better than a broad list of prohibited words
because it is focused on repeatable patterns with a clear repair move.

The important limits are also clear:

- The optional Vale layers run one at a time. A full review of a public
  leadership or AI-related draft requires separate passes, followed by a human
  read for interactions across layers.
- Most rules are surface patterns. They cannot verify facts, infer whether
  evidence is adequate, assess a paragraph's real protagonist, or decide that
  a reflection is genuinely earned.
- The research taxonomy reaches areas that deterministic rules should not try
  to solve alone, including originality, quotation use, factual texture, tone,
  and domain conventions.
- Kalen voice is deliberately a thin public-safe profile. It preserves
  high-level tendencies without attempting to imitate private writing or make
  an authorship claim.

## Practical Review Order

For a human-facing draft, review substance before style:

1. Confirm the reader, purpose, facts, claims, evidence, and decision or
   action requested.
2. Apply the core house style gate at the deliverable checkpoint.
3. Run the relevant optional layers separately: Kalen voice for reflective or
   leadership writing, AI voice avoidance for generated-business drift, Center
   of Gravity when people and tools may compete for subject position, and No
   Dramatic Punctuation for public or reflective prose.
4. Read the full draft as a reader. Check the paragraph and topic protagonist,
   the evidence behind important claims, the domain fit, and whether the
   writing still sounds like something Kalen would stand behind.
5. Keep a short reason for any deliberate exception. Do not rewrite a quote,
   source title, product name, necessary technical term, or intentional voice
   choice merely to satisfy a rule.

That order preserves the system's central promise. Writers use automation to
pause at known risk points. People remain responsible for truth, judgment,
tone, and final accountability.
