#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v vale >/dev/null 2>&1; then
  echo "test-style-gate: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

expect_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/style_gate.sh "$fixture" 2>&1 || true)"
  if ! grep -q "$rule" <<<"$output"; then
    echo "Expected $rule for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_rule "docs/test-fixtures/style-gate/fail-em-dash.md" "HouseStyle.NoEmDash"
expect_rule "docs/test-fixtures/style-gate/fail-contrast-formula.md" "HouseStyle.ContrastFormula"
expect_rule "docs/test-fixtures/style-gate/fail-contrast-cluster.md" "HouseStyle.ContrastCluster"
expect_rule "docs/test-fixtures/style-gate/fail-stock-conclusion.md" "HouseStyle.StockConclusions"

echo "test-style-gate: passed"
