# AI Voice Avoidance Runbook

Purpose: prevent common AI-generated writing patterns from entering Kalen's
drafts. This matters most in executive, recruiter-facing, public, and
leadership writing.

Use this as a source document inside the ChatGPT writing Project.

## Operating Rule

Do not merely imitate Kalen's voice. Also remove the default AI voice.

AI voice is not one forbidden word list. It is a pattern:

- abstract labels before concrete facts,
- polished but impersonal business language,
- over-neat sentence scaffolds,
- broad diagnosis before proof,
- role-fit language that sounds generated,
- nouns stacked in place of visible action,
- claims that compress several real events into one vague phrase.

When a sentence sounds AI-generated, repair it by naming the real thing:

1. actor,
2. action,
3. system or workflow,
4. before state,
5. friction or risk,
6. decision or ownership,
7. result or after state.

## Canonical Disliked Phrases

These phrases came from Kalen's review of a cover-letter draft. Treat them as
source examples for the deterministic `AIVoice` checks:

- `where business-critical systems need stronger ownership`
- `The roles that fit me best`
- `The pattern I am most useful in is familiar`
- `technology was small, reactive, and heavily dependent on outside vendors`
- `created operating strain`
- `leadership visibility move together`
- `The work is not only selecting or replacing systems.`

## Research Basis

Current research does not prove authorship from style. It does show recurring
differences between AI-generated and human-written text.

Use these findings as review guidance:

- A survey of linguistic research found that AI-generated text often becomes
  more formal and impersonal, with lower vocabulary variety and more
  repetition.
- A study of medical writing found that many terms associated with large
  language model output increased sharply in 2023 and 2024. The study also
  cautioned that these terms often existed before ChatGPT, so they are warning
  signs, not proof.
- A study comparing human news text with output from six large language models
  found measurable differences in sentence-length distribution, vocabulary
  variety, syntax, and emotional pattern.
- Prompting guidance from OpenAI and Microsoft supports using specific
  instructions, examples, grounding material, and validation instead of broad
  style requests.

Source links:

- [Linguistic Characteristics of AI-Generated Text: A Survey](https://arxiv.org/pdf/2510.05136)
- [Delving Into PubMed Records](https://pmejournal.org/articles/10.5334/pme.1929)
- [Contrasting Linguistic Patterns in Human and Large Language Model-Generated News Text](https://link.springer.com/article/10.1007/s10462-024-10903-2)
- [How AI-generated prose diverges from human writing](https://reutersinstitute.politics.ox.ac.uk/news/how-ai-generated-prose-diverges-human-writing-and-why-it-matters)
- [OpenAI prompt engineering best practices](https://help.openai.com/en/articles/6654000-best-practices-for-prompt-engineering-with-the-openai-api)
- [Microsoft prompt engineering techniques](https://learn.microsoft.com/en-us/azure/foundry/openai/concepts/prompt-engineering)

## What To Stop

### 1. Generic Role-Fit Framing

Avoid phrases that sound like a model is matching a candidate to a category.

Weak:

```text
The roles that fit me best
```

Why it fails:

- It sounds like generated career-positioning language.
- It explains fit instead of stating interest.
- It puts the writer in a sorted bucket.

Better:

```text
I am interested in senior technology leadership roles, including...
```

Rule:

State the role family directly. Do not narrate the matching logic.

### 2. Abstract Business-Need Clauses

Avoid broad clauses that sound important but do not name the company situation.

Weak:

```text
where business-critical systems need stronger ownership
```

Why it fails:

- It compresses the real problem into a label.
- It sounds like any executive technology letter.
- It does not show what ownership means.

Better:

```text
where core applications, delivery, support, and vendor decisions need clearer executive ownership
```

Or shorter:

```text
where important platforms need clearer ownership and better delivery discipline
```

Rule:

If using `ownership`, name what is owned.

### 3. Pattern-Recognition Openings

Avoid announcing that a pattern is familiar before showing the evidence.

Weak:

```text
The pattern I am most useful in is familiar
```

Why it fails:

- It sounds like AI-generated synthesis.
- It tells the reader how to interpret the story too early.
- It delays the concrete situation.

Better:

```text
I joined ChemStation during a period of significant operational and technology challenges.
```

Rule:

Show the situation first. Let the pattern emerge from the facts.

### 4. Flattened Before-State Labels

Avoid stacked adjectives that summarize a company state without enough care.

Weak:

```text
technology was small, reactive, and heavily dependent on outside vendors
```

Why it fails:

- It sounds diagnostic and slightly dismissive.
- It collapses people, systems, vendors, and operating conditions into labels.
- It reads sharper than a recruiter letter needs to be.

Better:

```text
technology had become largely reactive
```

Or:

```text
software development was outsourced, several systems needed modernization, and the organization was responding to a cybersecurity incident
```

Rule:

Use specific facts for the before state. Use one broad summary only if it is
earned by the surrounding detail.

### 5. Vague Consequence Phrases

Avoid phrases that name the existence of a problem without saying what happened.

Weak:

```text
created operating strain
```

Why it fails:

- It sounds like a generated business abstraction.
- It hides who felt the strain and what changed.
- It asks the reader to infer the operational issue.

Better:

```text
created support, delivery, and operating challenges
```

Or, when evidence is available:

```text
created support escalations, process confusion, and extra work for the teams using the system
```

Rule:

If using `strain` or `friction`, name the visible symptom. Apply the same rule
to `complexity` and `risk`.

### 6. Coordinated Abstraction

Avoid phrases where several categories are said to move together.

Weak:

```text
leadership visibility move together
```

Why it fails:

- It turns several real leadership actions into a smooth abstraction.
- It sounds like strategy prose instead of lived operating work.
- It hides what leaders need to see or decide.

Better:

```text
leaders can see delivery progress, platform risk, support issues, and vendor tradeoffs early enough to act
```

Rule:

Replace `visibility`, `alignment`, and `move together`. Say what someone sees,
decides, changes, or owns.

### 7. Empty Work Nouns

Avoid using `the work` as a stand-in for the actual task.

Weak:

```text
The work is not only selecting or replacing systems.
```

Why it fails:

- It is a generic contrast setup.
- It delays the actual point.
- It sounds like a model turning a project into a lesson.

Better:

```text
Modernization also requires decisions about ownership, release practices, support, vendor accountability, and risk.
```

Rule:

Name the work. Do not use the lesson-frame phrase `The work is not only
selecting or replacing systems.` Use the named modernization task instead.
Broader uses of `the work` are context-sensitive and belong in human review
unless the sentence repeats this exact pattern.

## Replacement Checklist

Before accepting a ChatGPT draft, scan for these failure patterns:

- Does the sentence contain a polished label instead of an observable fact?
- Does it use `ownership`, `visibility`, `alignment`, `strain`, `complexity`,
  `friction`, or `modernization` without naming the concrete symptom?
- Does it say `the work`, `the pattern`, `the roles that fit`, or `where X
  needs Y`?
- Does it sound like a recruiter, consultant, or model is describing Kalen
  from the outside?
- Does it explain the lesson before showing the situation?
- Does it use a contrast formula such as `not only`, `not just`, or `not X but
  Y`?

If yes, revise toward concrete operating language.

## Rewrite Method

Use this five-step repair process:

1. Underline the abstract phrase.
2. Ask what actually happened.
3. Name the system, team, workflow, platform, decision, or risk.
4. State what changed before and after.
5. Cut the explanatory wrapper.

Example:

```text
AI voice:
The pattern I am most useful in is familiar.

Repair:
I joined ChemStation during a period of significant operational and technology challenges.
```

## Preferred Recruiter-Facing Pattern

For executive recruiting materials, use this order:

```text
polite opening
-> clear role family
-> before state
-> what changed
-> proof across career stages
-> current search boundary
-> simple invitation
```

Do not over-teach the fit. Show the pressure, what changed, and why the
background is useful. Let the recruiter infer some of the positioning.

## Project Instruction Add-On

Add this to the ChatGPT Project instructions if the Project starts drifting:

```text
Do not use common AI business voice. Avoid abstract labels such as operating
strain, stronger ownership, leadership visibility, familiar pattern, the work,
or roles that fit me best unless the sentence names the concrete system,
decision, symptom, owner, or before-and-after change. If a phrase sounds like
AI-generated recruiter or consultant prose, rewrite it in plain operating
language.
```

## Quality Bar

A draft is acceptable only when:

- the reader can see the situation before the conclusion,
- claims are supported by facts or framed as judgment,
- the before state and after state are visible when relevant,
- abstract nouns have been replaced with concrete systems, decisions, or risks,
- the close sounds like a human invitation, not a positioning filter.
