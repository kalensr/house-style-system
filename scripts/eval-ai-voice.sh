#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v vale >/dev/null 2>&1; then
  echo "eval-ai-voice: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

expect_ai_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/review-ai-voice.sh "$fixture" 2>&1 || true)"
  if ! grep -q "$rule" <<<"$output"; then
    echo "Expected $rule for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_ai_clean() {
  local fixture="$1"
  local output

  output="$(./scripts/review-ai-voice.sh "$fixture" 2>&1 || true)"
  if grep -q "AIVoice" <<<"$output"; then
    echo "Expected no AIVoice alerts for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-role-fit-framing.md" "AIVoice.RoleFitFraming"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-abstract-business-need.md" "AIVoice.AbstractBusinessNeed"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-pattern-recognition-opening.md" "AIVoice.PatternRecognitionOpening"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-diagnostic-adjective-stack.md" "AIVoice.DiagnosticAdjectiveStack"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-vague-consequence.md" "AIVoice.VagueConsequence"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-coordinated-abstraction.md" "AIVoice.CoordinatedAbstraction"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-empty-work-noun.md" "AIVoice.EmptyWorkNouns"

# Generalization variants: different wording than the runbook examples must still trigger.
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-coordinated-abstraction-variant.md" "AIVoice.CoordinatedAbstraction"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-diagnostic-adjective-stack-variant.md" "AIVoice.DiagnosticAdjectiveStack"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-vague-consequence-variant.md" "AIVoice.VagueConsequence"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-empty-work-noun-variant.md" "AIVoice.EmptyWorkNouns"

expect_ai_clean "docs/evals/ai-voice/near-miss-role-family-direct.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-abstract-business-need-grounded.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-pattern-shown-first.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-diagnostic-before-state-facts.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-visible-symptom.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-coordinated-abstraction-grounded.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-empty-work-noun-named.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-reviewer-erp-ownership.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-reviewer-revenue-moves.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-reviewer-role-fit-organization.md"
expect_ai_clean "docs/evals/ai-voice/near-miss-contextual-work-noun.md"

default_voice_output="$(./scripts/style_gate.sh docs/test-fixtures/style-gate/fail-ai-role-fit-framing.md 2>&1 || true)"
if grep -q "AIVoice" <<<"$default_voice_output"; then
  echo "Expected AIVoice rules to require --ai-voice" >&2
  echo "$default_voice_output" >&2
  exit 1
fi

echo "eval-ai-voice: passed"
