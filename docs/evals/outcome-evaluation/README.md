# Independent Draft Outcome Evaluation

Use this evaluation after a revision when you need evidence that the system
improved a real draft rather than merely passed known style fixtures. It is
required before claiming that a rule, release-review workflow, or evaluator
improved writing quality.

Keep the source draft, revised draft, and source packet in the private working
area. This public repository stores only synthetic fixtures and the packet
structure.

## Reviewer Boundary

The evaluator must not have authored the revision. The evaluator reviews the
original and revised drafts in randomized A/B order, with the source packet
available for factual and meaning checks. The drafter and evaluator fields must
use different names. The packet's independence attestation records the review
method; the script checks that it exists but cannot verify it.
Record the A/B mapping only after the evaluator selects a preferred version or a
tie. The packet must record which version was the revision after unblinding so
the team can calculate whether revisions win over time.

## Required Scores

Score each dimension from 1 to 5, select a blinded preference of A, B, or Tie,
record the revised version after unblinding, and explain the release decision:

1. Factual and meaning preservation
2. Evidence integrity
3. Voice fit
4. Reader usefulness
5. Generic-pattern reduction

Do not average away a serious factual or meaning failure. A draft with a score
of 1 or 2 for factual and meaning preservation, or evidence integrity, must be
revised even if its style scores are high.

## Packet Format

Copy the positive fixture, replace every value, and keep the completed packet
private:

```sh
./scripts/check-outcome-evaluation.sh path/to/private-evaluation.md
```

The check validates packet structure. The human evaluator owns the scores,
blinded preference, source fidelity, and release decision.
