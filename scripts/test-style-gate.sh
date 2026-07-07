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

expect_wrapper_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/review-kalen-voice.sh "$fixture" 2>&1 || true)"
  if ! grep -q "$rule" <<<"$output"; then
    echo "Expected $rule through review-kalen-voice wrapper for $fixture" >&2
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
expect_wrapper_rule "docs/test-fixtures/style-gate/fail-generic-ai-opening.md" "KalenVoice.GenericAIOpenings"

expect_ai_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/review-ai-voice.sh "$fixture" 2>&1 || true)"
  if ! grep -q "$rule" <<<"$output"; then
    echo "Expected $rule through review-ai-voice wrapper for $fixture" >&2
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
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-coordinated-abstraction-variant.md" "AIVoice.CoordinatedAbstraction"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-diagnostic-adjective-stack-variant.md" "AIVoice.DiagnosticAdjectiveStack"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-vague-consequence-variant.md" "AIVoice.VagueConsequence"
expect_ai_rule "docs/test-fixtures/style-gate/fail-ai-empty-work-noun-variant.md" "AIVoice.EmptyWorkNouns"

expect_center_of_gravity_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/review-center-of-gravity.sh "$fixture" 2>&1 || true)"
  if ! grep -q "$rule" <<<"$output"; then
    echo "Expected $rule through review-center-of-gravity wrapper for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_center_of_gravity_rule "docs/test-fixtures/style-gate/fail-cog-ai-protagonist.md" "CenterOfGravity.ToolProtagonist"
expect_center_of_gravity_rule "docs/test-fixtures/style-gate/fail-cog-empty-work-subject.md" "CenterOfGravity.EmptyWorkSubject"
expect_center_of_gravity_rule "docs/test-fixtures/style-gate/fail-cog-nominalized-human-action.md" "CenterOfGravity.NominalizedHumanAction"

expect_dramatic_punctuation_rule() {
  local fixture="$1"
  local rule="$2"
  local output

  output="$(./scripts/review-dramatic-punctuation.sh "$fixture" 2>&1 || true)"
  if ! grep -q "$rule" <<<"$output"; then
    echo "Expected $rule through review-dramatic-punctuation wrapper for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
}

expect_dramatic_punctuation_rule "docs/test-fixtures/style-gate/fail-dp-vague-punchline.md" "DramaticPunctuation.VaguePunchline"
expect_dramatic_punctuation_rule "docs/test-fixtures/style-gate/fail-dp-abstract-punchline.md" "DramaticPunctuation.AbstractPunchline"
expect_dramatic_punctuation_rule "docs/test-fixtures/style-gate/fail-dp-fragment-emphasis.md" "DramaticPunctuation.FragmentEmphasis"

wrapper_positive_output="$(./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md 2>&1 || true)"
if ! grep -q "0 errors, 0 warnings and 0 suggestions" <<<"$wrapper_positive_output"; then
  echo "Expected review-kalen-voice wrapper positive control to be clean" >&2
  echo "$wrapper_positive_output" >&2
  exit 1
fi

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

fake_vale_dir="$(mktemp -d)"
trap 'rm -f "$fake_vale_dir/vale"; rmdir "$fake_vale_dir"' EXIT
printf '%s\n' \
  '#!/usr/bin/env bash' \
  'if [[ -z "${NO_COLOR+x}" ]]; then' \
  '  echo "NO_COLOR_UNSET"' \
  'else' \
  '  echo "NO_COLOR=$NO_COLOR"' \
  'fi' > "$fake_vale_dir/vale"
chmod +x "$fake_vale_dir/vale"

no_color_default_output="$(PATH="$fake_vale_dir:$PATH" ./scripts/style_gate.sh docs/evals/kalen-voice/positive-leadership-reflection.md)"
if [[ "$no_color_default_output" != "NO_COLOR=1" ]]; then
  echo "Expected style gate to disable color by default" >&2
  echo "$no_color_default_output" >&2
  exit 1
fi

color_override_output="$(PATH="$fake_vale_dir:$PATH" STYLE_GATE_COLOR=1 ./scripts/style_gate.sh docs/evals/kalen-voice/positive-leadership-reflection.md)"
if [[ "$color_override_output" != "NO_COLOR_UNSET" ]]; then
  echo "Expected STYLE_GATE_COLOR=1 to preserve Vale color behavior" >&2
  echo "$color_override_output" >&2
  exit 1
fi

mixed_voice_output="$(./scripts/style_gate.sh --ai-voice --kalen-voice docs/test-fixtures/style-gate/fail-ai-role-fit-framing.md 2>&1 || true)"
if ! grep -q "choose only one optional review layer" <<<"$mixed_voice_output"; then
  echo "Expected style gate to reject mixed voice layers" >&2
  echo "$mixed_voice_output" >&2
  exit 1
fi

mixed_optional_output="$(./scripts/style_gate.sh --ai-voice --center-of-gravity docs/test-fixtures/style-gate/fail-cog-ai-protagonist.md 2>&1 || true)"
if ! grep -q "choose only one optional review layer" <<<"$mixed_optional_output"; then
  echo "Expected style gate to reject mixed optional review layers" >&2
  echo "$mixed_optional_output" >&2
  exit 1
fi

mixed_dramatic_output="$(./scripts/style_gate.sh --ai-voice --dramatic-punctuation docs/test-fixtures/style-gate/fail-dp-vague-punchline.md 2>&1 || true)"
if ! grep -q "choose only one optional review layer" <<<"$mixed_dramatic_output"; then
  echo "Expected style gate to reject mixed dramatic punctuation layers" >&2
  echo "$mixed_dramatic_output" >&2
  exit 1
fi

echo "test-style-gate: passed"
