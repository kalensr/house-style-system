# Customizing The System

Start with the defaults. Then tune the system to your readers and work.

## What To Customize First

1. Add your own jargon list.
2. Add preferred replacements.
3. Adjust domain modes.
4. Add examples from your own writing.
5. Add fixtures for patterns you see more than once.
6. Change warning levels only after the rule proves useful.

## Add A Voice Layer Safely

A voice layer should promote repeated, reviewable patterns. It should not turn a
private corpus into committed examples.

Use this promotion path:

1. Keep private writing samples outside the public repo.
2. Summarize the repeated pattern in plain language.
3. Decide whether the pattern is checkable by automation.
4. Use synthetic fixtures that do not copy private passages.
5. Add a Vale rule only for the repeatable surface signal.
6. Keep deeper voice fit in human review or a local private workflow.

Good voice-rule candidates:

- generic openings that erase the real situation,
- claims about groups that lack evidence or an explicit assumption,
- future-state language with no visible path,
- repeated executive polish with no concrete action.

Poor voice-rule candidates:

- spiritual interpretation,
- testimony,
- family details,
- emotional reality,
- judgment quality,
- whether a draft fully sounds like a specific person.

## Keep Rules Small

A good automated rule catches a pattern that is easy to define.

Good candidates:

- repeated filler phrases,
- specific punctuation choices,
- stock conclusions,
- acronym candidates,
- repeated sentence scaffolds.

Poor candidates:

- truth,
- originality,
- tone fit,
- strategic judgment,
- source quality.

Those belong in human review.

## Add A New Rule

1. Create a fixture under `docs/test-fixtures/style-gate/`.
2. Run `./scripts/test-style-gate.sh` and confirm the fixture is not covered yet.
3. Add a Vale rule in `styles/HouseStyle/` for default house-style behavior.
   Use `styles/KalenVoice/` for opt-in Kalen voice review behavior.
4. Update `scripts/test-style-gate.sh`.
5. Run the test again.

For Kalen voice changes, also update or run:

```sh
./scripts/eval-kalen-voice.sh
./scripts/review-kalen-voice.sh path/to/draft.md
```

Keep new rules at `suggestion` or `warning` unless the pattern is always wrong.

## Accepting Warnings

Accept a warning when the wording is required by:

- a quote,
- a source title,
- a product name,
- a technical term,
- a deliberate voice choice.

Do not rewrite source material only to satisfy the gate.
