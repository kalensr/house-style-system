#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PASSING="docs/evals/outcome-evaluation/positive-independent-review.md"
MISSING_INDEPENDENCE="docs/test-fixtures/outcome-evaluation/fail-missing-independence.md"
MISSING_SCORE="docs/test-fixtures/outcome-evaluation/fail-missing-score.md"
SAME_DRAFTER_EVALUATOR="docs/test-fixtures/outcome-evaluation/fail-same-drafter-evaluator.md"

./scripts/check-outcome-evaluation.sh "$PASSING" >/dev/null

for fixture in "$MISSING_INDEPENDENCE" "$MISSING_SCORE" "$SAME_DRAFTER_EVALUATOR"; do
  if ./scripts/check-outcome-evaluation.sh "$fixture" >/dev/null 2>&1; then
    echo "Expected outcome-evaluation check to fail for $fixture" >&2
    exit 1
  fi
done

echo "eval-outcome-evaluation: passed"
