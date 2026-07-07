# Center Of Gravity Writing Eval

This note documents the research basis for the Center of Gravity review layer.
The layer addresses a recurring AI-assisted writing failure. A sentence,
paragraph, or whole topic can make the wrong thing the subject. Common false
subjects are AI, agents, abstract work, and nominalized actions. The real
subject may be a person or team. It may also be a customer or organization. It
may be a workflow, decision, or practical change.

The house-style name is Center of Gravity. The research terms behind it include
nominalization, character and action, actor and action, and Theme/Rheme. They
also include thematic progression and entity-based coherence.

## Why This Exists

AI-assisted drafts often begin with the tool or an abstraction:

```text
AI is changing how engineering teams make decisions.
The work is adapting to AI.
Adoption requires a rethinking of ownership.
```

Those sentences may sound polished, but they push the human actor out of the
foreground. The repair is not only shorter prose. The repair is to restore the
right subject:

```text
Engineering teams are changing how they use AI to review architecture
decisions.
Managers are adapting planning, review, and delivery rituals.
The team needs to decide who owns release review, vendor risk, and support
follow-up.
```

## Research Basis

### Large language model writing has measurable grammatical patterns

Reinhart, Brown, and colleagues compared human and large language model writing
with grammatical and rhetorical features. Their study found systematic
differences between humans and models. Instruction-tuned models used
nominalizations at higher rates than human writing and tended toward an
information-dense, noun-heavy style. The discussion also cites related findings
that ChatGPT-4 text showed more nominalizations and fewer human subjects and
stance markers.

Source: [Do large language models write like humans? Variation in grammatical and rhetorical styles](https://arxiv.org/html/2410.16107v1)

A 2025 Association for Computational Linguistics paper compared human-authored
news text with large language model generated news text. It used formal syntax.
It frames large language model grammar as a measurable research topic rather
than a purely impressionistic style complaint. That supports treating this
layer as an eval target, not only a taste rule.

Source: [Comparing large language model generated and human-authored news text using formal syntax](https://aclanthology.org/2025.acl-long.443.pdf)

### Writing pedagogy already names the sentence-level problem

Purdue's writing lab describes nominalizations as nouns made from verbs or
adjectives, such as `decision` from `decide`. This matters because
nominalizations can hide the actor and action the reader needs.

Source: [Purdue writing lab: Nominalizations and Subject Position](https://owl.purdue.edu/owl/multilingual/multilingual_students/nominalizations_and_subject_position.html)

Boston University teaches the same repair pattern directly: make
nominalizations into verbs and make people the subjects of those verbs. The
same guide says English readers find sentences easier when a short, concrete
subject and a specific verb appear near the beginning of the sentence or
clause.

Source: [Boston University: Sentence Clarity Script](https://www.bu.edu/teaching-writing/files/2020/03/Sentence-Clarity-Script.pdf)

The Michigan Bar Journal article uses the language of recognizable characters
and action verbs. Its practical repair is to identify each sentence subject and
put an identifiable character in subject position.

Source: [Bring your writing to life: Use recognizable characters and action verbs](https://www.michbar.org/journal/Details/Bring-your-writing-to-life-Use-recognizable-characters-and-action-verbs?ArticleID=4585)

### Paragraphs and topics have a subject too

Theme/Rheme and thematic progression research gives this house-style rule a
paragraph-level vocabulary. In this frame, the Theme is the starting point of a
message, and thematic progression describes how those starting points develop
across clauses and paragraphs. That helps explain why the issue is larger than
one sentence: repeated subjects teach the reader what the passage is actually
about.

Sources:

- [Theme and Thematic Progression in English Writing Teaching](https://files.eric.ed.gov/fulltext/EJ1079122.pdf)
- [Thematic progression in the writing of students and professionals](https://www.sciencedirect.com/science/article/pii/S2215039015300011)

Entity-based coherence research gives a future automation path. Entity grids
track discourse entities and their syntactic roles across sentences. A future
Center of Gravity eval can use the same basic idea. It can count who appears in
subject position, object position, or only as background. It can then flag
drafts where AI, agents, or abstract nouns dominate the subject position while
people disappear.

Source: [Modeling Local Coherence: An Entity-Based Approach](https://aclanthology.org/J08-1001.pdf)

## Eval Levels

### Level 1: Sentence actor and action

Status: automated now with Vale.

The current `CenterOfGravity` rules flag repeatable sentence-level risks:

- `ToolProtagonist`: AI, agents, or automation begin the sentence and carry the
  action.
- `EmptyWorkSubject`: vague subjects such as `the work`, `this work`, or `the
  pattern` carry human action.
- `NominalizedHumanAction`: words such as `adoption`, `adaptation`,
  `implementation`, or `alignment` become the grammatical subject.

Run:

```sh
./scripts/review-center-of-gravity.sh path/to/draft.md
./scripts/eval-center-of-gravity.sh
```

### Level 2: Paragraph center of gravity

Status: documented review prompt.

Ask what entity controls the paragraph. The paragraph usually should center on
one of these:

- a person or team,
- an organization or customer,
- a decision, workflow, or concrete change.

AI, agents, platforms, and systems can appear. They should serve the human or
organizational action.

### Level 3: Topic protagonist

Status: documented review prompt.

Across the full draft, ask what the piece is actually about. If the topic is
people adapting to AI, the subject should usually be people adapting. It can
also be people deciding or reviewing. It can be people owning, learning, or
changing work. AI should not silently become the protagonist.

### Level 4: Entity drift automation

Status: future path.

Build a small entity-role report that counts recurring entities and their
syntactic roles across the draft. The first useful report can stay simple. It
can count human and organization subjects, AI and agent subjects, abstract noun
subjects, and concrete workflow subjects. That would make paragraph and topic
drift trackable over time.

## Repair Checklist

When the Center of Gravity layer flags a sentence, revise by answering:

1. Who is acting?
2. What did they do or decide?
3. What system, workflow, draft, policy, customer, or decision changed?
4. What was true before?
5. What friction, risk, or opportunity made the action matter?
6. What changed after the action?

Keep AI, agents, platforms, and systems in the sentence when they matter. Do
not make them the subject unless they are truly the thing acting.
