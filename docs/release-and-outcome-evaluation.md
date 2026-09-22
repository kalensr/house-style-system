# Release Review And Outcome Evaluation

## Assessment

The House Style System has strong deterministic coverage for known writing
risks. Its evaluators prove that rules alert on synthetic failures and spare
protected near misses. That does not establish that a revision improved a real
draft, preserved the source, or fit a reader better.

This update closes two operating gaps without treating style signals as proof of
authorship or quality.

| Control | What it requires | What it proves | What it does not prove |
| --- | --- | --- | --- |
| Multi-layer release review | House Style, AI Voice, Center of Gravity, and No Dramatic Punctuation together for publishable Markdown; Kalen Voice when that profile applies | The draft received the relevant deterministic checks in one pass | That the revision preserved facts, fits the reader, or improved writing quality |
| Independent outcome evaluation | A separate evaluator, randomized A/B comparison, source-packet review, five quality scores, blind preference, and release decision | The review packet records a comparable human judgment that can be aggregated over time | That the attestation is true, that one review is generalizable, or that authorship can be inferred |

The outcome packet is required before making a system-quality claim, not before
releasing every individual draft. That keeps ordinary writing practical while
giving new rules and evaluator changes a measured path to promotion or removal.

## Release Review

For publishable Markdown, run:

```sh
./scripts/review-release-writing.sh path/to/draft.md
./scripts/review-release-writing.sh --kalen-voice path/to/draft.md
```

The first command uses the core, AI Voice, Center of Gravity, and No Dramatic
Punctuation rules. Add `--kalen-voice` for Kalen leadership, reflection, or
public-essay review. Resolve each alert or record why a quote, technical term,
or deliberate voice choice should remain.

## Outcome Evaluation

Keep the original draft, revised draft, source packet, and completed evaluation
packet in the private working area. The evaluator must attest to independence,
must not have authored the revision, and must be named differently from the
drafter. Present the original and revised drafts in randomized A/B order, give
the evaluator the source packet for factual checks, and reveal the mapping only
after scoring.

Score each dimension from 1 to 5:

1. Factual and meaning preservation
2. Evidence integrity
3. Voice fit
4. Reader usefulness
5. Generic-pattern reduction

Also record whether the evaluator preferred A, B, or Tie, then map the revision
to A or B after unblinding and explain the release decision. A score of 1 or 2
for factual and meaning preservation, or evidence integrity, requires revision
regardless of style scores.

Validate the packet structure with:

```sh
./scripts/check-outcome-evaluation.sh path/to/private-evaluation.md
```

## Metrics To Collect

Do not claim results until completed private packets exist. The first useful
quality statistics are:

- blinded preference rate for revisions;
- average score by dimension and writing domain;
- factual or evidence regressions;
- alert disposition: fixed, intentionally accepted, or rejected as noise;
- rule-level false-positive rate and outcome-evaluation lift.

Review those results before adding rules. Keep a rule only when it catches a
meaningful problem often enough to justify its review cost.
