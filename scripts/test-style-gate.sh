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
expect_kalen_rule "docs/test-fixtures/style-gate/fail-kalen-negative-first-framing.md" "KalenVoice.NegativeFirstFraming"
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

expect_center_of_gravity_rule_count() {
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

expect_center_of_gravity_rule "docs/test-fixtures/style-gate/fail-cog-ai-protagonist.md" "CenterOfGravity.ToolProtagonist"
expect_center_of_gravity_rule "docs/test-fixtures/style-gate/fail-cog-empty-work-subject.md" "CenterOfGravity.EmptyWorkSubject"
expect_center_of_gravity_rule "docs/test-fixtures/style-gate/fail-cog-empty-work-subject-variant.md" "CenterOfGravity.EmptyWorkSubject"
expect_center_of_gravity_rule "docs/test-fixtures/style-gate/fail-cog-nominalized-human-action.md" "CenterOfGravity.NominalizedHumanAction"
expect_center_of_gravity_rule_count "docs/test-fixtures/style-gate/fail-cog-ai-protagonist-with-frontmatter.md" "CenterOfGravity.ToolProtagonist" "1" "9"

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

release_clean_output="$(./scripts/review-release-writing.sh docs/evals/release-review-clean.md 2>&1 || true)"
if ! grep -q "0 errors, 0 warnings and 0 suggestions" <<<"$release_clean_output"; then
  echo "Expected multi-layer release review control to be clean" >&2
  echo "$release_clean_output" >&2
  exit 1
fi

release_ai_output="$(./scripts/review-release-writing.sh docs/test-fixtures/style-gate/fail-ai-role-fit-framing.md 2>&1 || true)"
if ! grep -q "AIVoice.RoleFitFraming" <<<"$release_ai_output"; then
  echo "Expected multi-layer release review to include AIVoice" >&2
  echo "$release_ai_output" >&2
  exit 1
fi

release_kalen_output="$(./scripts/review-release-writing.sh --kalen-voice docs/test-fixtures/style-gate/fail-kalen-negative-first-framing.md 2>&1 || true)"
if ! grep -q "KalenVoice.NegativeFirstFraming" <<<"$release_kalen_output"; then
  echo "Expected Kalen release review to include KalenVoice" >&2
  echo "$release_kalen_output" >&2
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

global_bin_dir="$(mktemp -d)"
external_workspace="$(mktemp -d)"
trap 'rm -f "$fake_vale_dir/vale"; rmdir "$fake_vale_dir"; rm -rf "$global_bin_dir" "$external_workspace"' EXIT

HOUSE_STYLE_BIN_DIR="$global_bin_dir" ./scripts/install-global-commands.sh >/dev/null

global_command_count="$(find "$global_bin_dir" -type f -perm -u+x | wc -l | tr -d ' ')"
if [[ "$global_command_count" != "11" ]]; then
  echo "Expected eleven installed global commands, found $global_command_count" >&2
  exit 1
fi

for command in review-kalen-voice.sh review-ai-voice.sh review-center-of-gravity.sh review-dramatic-punctuation.sh review-release-writing.sh check-outcome-evaluation.sh; do
  if ! "$global_bin_dir/$command" --help >/dev/null 2>&1; then
    echo "Expected $command --help to succeed through the global dispatcher" >&2
    exit 1
  fi
done

printf 'The work is not just documenting requirements.\n' > "$external_workspace/draft.md"
external_review_output="$(
  cd "$external_workspace"
  HOUSE_STYLE_SYSTEM_ROOT="$ROOT" "$global_bin_dir/review-ai-voice.sh" draft.md 2>&1 || true
)"
if ! grep -q "AIVoice.EmptyWorkNouns" <<<"$external_review_output"; then
  echo "Expected global review command to inspect a caller-relative path" >&2
  echo "$external_review_output" >&2
  exit 1
fi

global_release_output="$(HOUSE_STYLE_SYSTEM_ROOT="$ROOT" "$global_bin_dir/review-release-writing.sh" --kalen-voice "$ROOT/docs/evals/release-review-clean.md" 2>&1 || true)"
if ! grep -q "0 errors, 0 warnings and 0 suggestions" <<<"$global_release_output"; then
  echo "Expected global release review to preserve its --kalen-voice option" >&2
  echo "$global_release_output" >&2
  exit 1
fi

global_eval_output="$(HOUSE_STYLE_SYSTEM_ROOT="$ROOT" "$global_bin_dir/eval-ai-voice.sh" 2>&1)"
if ! grep -q "eval-ai-voice: passed" <<<"$global_eval_output"; then
  echo "Expected global eval command to use canonical fixtures" >&2
  echo "$global_eval_output" >&2
  exit 1
fi

global_outcome_eval_output="$(HOUSE_STYLE_SYSTEM_ROOT="$ROOT" "$global_bin_dir/eval-outcome-evaluation.sh" 2>&1)"
if ! grep -q "eval-outcome-evaluation: passed" <<<"$global_outcome_eval_output"; then
  echo "Expected global outcome-evaluation command to use canonical fixtures" >&2
  echo "$global_outcome_eval_output" >&2
  exit 1
fi

global_outcome_packet_output="$(HOUSE_STYLE_SYSTEM_ROOT="$ROOT" "$global_bin_dir/check-outcome-evaluation.sh" "$ROOT/docs/evals/outcome-evaluation/positive-independent-review.md" 2>&1)"
if ! grep -q "check-outcome-evaluation: passed" <<<"$global_outcome_packet_output"; then
  echo "Expected global outcome-packet check to accept a canonical packet" >&2
  echo "$global_outcome_packet_output" >&2
  exit 1
fi

mixed_dramatic_output="$(./scripts/style_gate.sh --ai-voice --dramatic-punctuation docs/test-fixtures/style-gate/fail-dp-vague-punchline.md 2>&1 || true)"
if ! grep -q "choose only one optional review layer" <<<"$mixed_dramatic_output"; then
  echo "Expected style gate to reject mixed dramatic punctuation layers" >&2
  echo "$mixed_dramatic_output" >&2
  exit 1
fi

echo "test-style-gate: passed"
