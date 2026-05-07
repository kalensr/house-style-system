# Customizing The System

Start with the defaults. Then tune the system to your readers and work.

## What To Customize First

1. Add your own jargon list.
2. Add preferred replacements.
3. Adjust domain modes.
4. Add examples from your own writing.
5. Add fixtures for patterns you see more than once.
6. Change warning levels only after the rule proves useful.

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
3. Add a Vale rule in `styles/HouseStyle/`.
4. Update `scripts/test-style-gate.sh`.
5. Run the test again.

Keep new rules at `suggestion` or `warning` unless the pattern is always wrong.

## Accepting Warnings

Accept a warning when the wording is required by:

- a quote,
- a source title,
- a product name,
- a technical term,
- a deliberate voice choice.

Do not rewrite source material only to satisfy the gate.
