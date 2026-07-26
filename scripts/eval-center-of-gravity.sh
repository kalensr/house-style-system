#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v vale >/dev/null 2>&1; then
  echo "eval-center-of-gravity: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

expect_cog_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/review-center-of-gravity.sh "$fixture" 2>&1 || true)"
  if ! grep -q "$rule" <<<"$output"; then
    echo "Expected $rule for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_cog_clean() {
  local fixture="$1"
  local output

  output="$(./scripts/review-center-of-gravity.sh "$fixture" 2>&1 || true)"
  if grep -q "CenterOfGravity" <<<"$output"; then
    echo "Expected no CenterOfGravity alerts for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_cog_rule_count() {
  local fixture="$1"
  local rule="$2"
  local expected_count="$3"
  local expected_line="$4"
  local output
  local actual_count

  output="$(./scripts/review-center-of-gravity.sh "$fixture" 2>&1 || true)"
  actual_count="$(grep -c "$rule" <<<"$output" || true)"
  if [[ "$actual_count" != "$expected_count" ]]; then
    echo "Expected $expected_count $rule alert(s) for $fixture, found $actual_count" >&2
    echo "$output" >&2
    exit 1
  fi
  if ! grep -qE "^[[:space:]]*${expected_line}:[0-9]+[[:space:]]+suggestion.*${rule}" <<<"$output"; then
    echo "Expected $rule to alert on line $expected_line for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_cog_rule "docs/test-fixtures/style-gate/fail-cog-ai-protagonist.md" "CenterOfGravity.ToolProtagonist"
expect_cog_rule "docs/test-fixtures/style-gate/fail-cog-empty-work-subject.md" "CenterOfGravity.EmptyWorkSubject"
expect_cog_rule "docs/test-fixtures/style-gate/fail-cog-nominalized-human-action.md" "CenterOfGravity.NominalizedHumanAction"
expect_cog_rule_count "docs/test-fixtures/style-gate/fail-cog-ai-protagonist-with-frontmatter.md" "CenterOfGravity.ToolProtagonist" "1" "9"

expect_cog_clean "docs/evals/center-of-gravity/near-miss-human-subject.md"
expect_cog_clean "docs/evals/center-of-gravity/near-miss-named-work.md"
expect_cog_clean "docs/evals/center-of-gravity/near-miss-active-action.md"

default_output="$(./scripts/style_gate.sh docs/test-fixtures/style-gate/fail-cog-ai-protagonist.md 2>&1 || true)"
if grep -q "CenterOfGravity" <<<"$default_output"; then
  echo "Expected CenterOfGravity rules to require --center-of-gravity" >&2
  echo "$default_output" >&2
  exit 1
fi

echo "eval-center-of-gravity: passed"
