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

expect_kalen_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/style_gate.sh --kalen-voice "$fixture" 2>&1 || true)"
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
expect_kalen_rule "docs/test-fixtures/style-gate/fail-generic-ai-opening.md" "KalenVoice.GenericAIOpenings"
expect_kalen_rule "docs/test-fixtures/style-gate/fail-abstract-leadership-opening.md" "KalenVoice.AbstractOpenings"
expect_kalen_rule "docs/test-fixtures/style-gate/fail-vision-without-pathway.md" "KalenVoice.PathwaySupport"
expect_kalen_rule "docs/test-fixtures/style-gate/fail-detached-leadership-claim.md" "KalenVoice.EvidenceSupport"
expect_kalen_rule "docs/test-fixtures/style-gate/fail-generic-executive-tone.md" "KalenVoice.ExecutiveTone"

default_output="$(STYLE_GATE_PRINT_FILES=1 ./scripts/style_gate.sh)"
if grep -q "docs/test-fixtures/" <<<"$default_output"; then
  echo "Default style gate should skip test fixtures" >&2
  echo "$default_output" >&2
  exit 1
fi
if grep -q "docs/evals/" <<<"$default_output"; then
  echo "Default style gate should skip eval fixtures" >&2
  echo "$default_output" >&2
  exit 1
fi
if grep -q "docs/plans/" <<<"$default_output"; then
  echo "Default style gate should skip implementation plans" >&2
  echo "$default_output" >&2
  exit 1
fi

echo "test-style-gate: passed"
