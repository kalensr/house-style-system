# AI Voice Avoidance Runbook

Use this source to review common generated-writing patterns without making an
authorship claim.

## Operating Rule

Do not merely imitate a preferred voice. Remove generic model habits and name
the real thing.

Review for:

- abstract labels before concrete facts;
- polished but impersonal business language;
- broad diagnosis before proof;
- stacked nouns in place of visible action;
- role-fit or positioning language that sounds generated;
- claims that compress several events into one vague phrase;
- repeated contrast scaffolding;
- short lines that imply importance without explaining it.

Repair a weak sentence by naming the relevant elements:

1. actor,
2. action,
3. system or workflow,
4. before state,
5. friction or risk,
6. decision or ownership,
7. result or after state.

## Review Patterns

### Generic Opening

Weak:

```text
In today's rapidly changing environment, strong leadership matters more than ever.
```

Better:

```text
The team had two release paths and no shared rollback decision.
```

### Abstract Business Need

Weak:

```text
The organization needed stronger alignment and ownership.
```

Better:

```text
Product and operations needed one owner for release approval and support escalation.
```

### Flattened Before State

Weak:

```text
The environment was fragmented, reactive, and inefficient.
```

Better:

```text
Three teams tracked the same request in separate systems, and no one owned the final handoff.
```

### Empty Work Noun

Weak:

```text
The real work is not only choosing a platform.
```

Better:

```text
The team must also decide who approves releases, handles failures, and reviews vendor performance.
```

### AI As Protagonist

Weak:

```text
AI transforms how architecture decisions are made.
```

Better:

```text
Engineering teams can use AI to compare architecture options while reviewers retain the final decision.
```

### Dramatic Punchline

Weak:

```text
This changes everything.
```

Better:

```text
The new review step gives the release owner evidence before approving deployment.
```

## Boundaries

- These patterns are review prompts, not proof that a model wrote the text.
- Preserve accurate domain language when a broad rule would make the sentence
  less precise.
- Keep quoted material unchanged unless the writer approves an edit.
- Do not invent a fact merely to make a sentence more concrete.
- A clean review does not prove that a draft is true, useful, or ready.
