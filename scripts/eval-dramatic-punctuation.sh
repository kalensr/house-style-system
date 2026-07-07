#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v vale >/dev/null 2>&1; then
  echo "eval-dramatic-punctuation: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

expect_dp_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/review-dramatic-punctuation.sh "$fixture" 2>&1 || true)"
  if ! grep -q "$rule" <<<"$output"; then
    echo "Expected $rule for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_dp_clean() {
  local fixture="$1"
  local output

  output="$(./scripts/review-dramatic-punctuation.sh "$fixture" 2>&1 || true)"
  if grep -q "DramaticPunctuation" <<<"$output"; then
    echo "Expected no DramaticPunctuation alerts for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_dp_rule "docs/test-fixtures/style-gate/fail-dp-vague-punchline.md" "DramaticPunctuation.VaguePunchline"
expect_dp_rule "docs/test-fixtures/style-gate/fail-dp-abstract-punchline.md" "DramaticPunctuation.AbstractPunchline"
expect_dp_rule "docs/test-fixtures/style-gate/fail-dp-fragment-emphasis.md" "DramaticPunctuation.FragmentEmphasis"

expect_dp_clean "docs/evals/dramatic-punctuation/near-miss-concrete-boundary.md"
expect_dp_clean "docs/evals/dramatic-punctuation/near-miss-expanded-standard.md"
expect_dp_clean "docs/evals/dramatic-punctuation/near-miss-informal-thanks.md"

default_output="$(./scripts/style_gate.sh docs/test-fixtures/style-gate/fail-dp-vague-punchline.md 2>&1 || true)"
if grep -q "DramaticPunctuation" <<<"$default_output"; then
  echo "Expected DramaticPunctuation rules to require --dramatic-punctuation" >&2
  echo "$default_output" >&2
  exit 1
fi

echo "eval-dramatic-punctuation: passed"
