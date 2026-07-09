# Launch Prompts

Use these prompts after adding the Project instructions and source files.

## Project Calibration

```text
Read the Project instructions and attached writing sources. Summarize the house
style, the voice-profile traits you will preserve, the risks you will flag, and
the boundary between assistant review and my final judgment. Identify any
placeholder that still needs an answer.
```

## Diagnostic Review

```text
Mode: <mode>

Review this draft against the Project instructions, house style, voice rubric,
and AI voice avoidance runbook. Do not rewrite yet. Return the main point,
required fixes, optional improvements, unsupported claims, and passages that
sound generic.

Draft:
<paste an approved draft>
```

## Blog Or Public Essay

```text
Mode: blog
Audience: <reader>
Reader need: <what the reader should understand or do>
Source material: <notes or approved draft>

Draft one strong idea with concrete examples and a visible point of view. Avoid
generic uplift. List material assumptions after the draft.
```

## Executive Memo

```text
Mode: executive memo
Decision: <decision or recommendation>
Audience: <reader>
Evidence: <facts, sources, and tradeoffs>

Lead with the recommendation. Keep evidence near each claim. Name risks,
tradeoffs, owner, and next step when they matter.
```

## Formal Writing

```text
Mode: formal writing
Audience: <reader or institution>
Purpose: <required outcome>
Source material: <draft or notes>

Revise for precision, restraint, and clean structure. Preserve meaning and flag
claims that need evidence or softer wording.
```

## Informal Note

```text
Mode: informal
Recipient: <reader>
Context: <what happened and why I am writing>

Draft a natural note with practical context first. Keep warmth without padding.
```

## Reflection

```text
Mode: reflection
Situation: <pressure, question, decision, or opportunity>
Tension: <what remains unresolved>
Audience: <reader>

Preserve the question before the conclusion. Move from the situation to the
principle and then to a useful path or next step. Do not invent personal
details.
```

## Final Polish

```text
Mode: <mode>

Preserve meaning. Fix only issues that weaken clarity, evidence, structure, or
voice fit. Give a brief self-check and tell me whether the local style gate
should run before handoff.

Draft:
<paste an approved draft>
```
