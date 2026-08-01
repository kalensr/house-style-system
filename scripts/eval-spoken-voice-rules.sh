#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v vale >/dev/null 2>&1; then
  echo "eval-spoken-voice-rules: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

surfaces=(
  "HOUSE_STYLE.md"
  "codex-skills/house-style-system/SKILL.md"
  "claude-skills/house-style/SKILL.md"
  "claude-skills/house-style/reference/house-style-core.md"
)
rules=(
  "No antithesis" "No corrective negation" "No paragraph pinning"
  "No parataxis" "No summary beats" "No rhetorical crutches"
  "No negative parallelisms" "No negative anaphoras" "No contrasting pairs"
  "No rule of three" "No em dashes" "No throat-clearing openers"
  "No landing sentences" "No setup/payoff constructions"
  "No parallel sentence structures within a paragraph"
  "Vary sentence length unpredictably" "No stacked noun phrases"
  "No filler intensifiers" "No corporate-register verbs" "No nominalization"
  "No hedging qualifiers" "Write for the spoken voice" "No performed enthusiasm"
)
for surface in "${surfaces[@]}"; do
  for rule in "${rules[@]}"; do
    grep -Fq "$rule" "$surface" || { echo "Missing '$rule' in $surface" >&2; exit 1; }
  done
done

for positive in docs/evals/spoken-voice/positive-cross-domain.md docs/evals/spoken-voice/revised-ai-cadence.md; do
  output="$(./scripts/style_gate.sh "$positive" 2>&1 || true)"
  grep -q "0 errors, 0 warnings and 0 suggestions" <<<"$output" || { echo "$output" >&2; exit 1; }
done

negative="docs/evals/spoken-voice/negative-ai-cadence.md"
negative_core="$(./scripts/style_gate.sh "$negative" 2>&1 || true)"
negative_dramatic="$(./scripts/review-dramatic-punctuation.sh "$negative" 2>&1 || true)"
for expected in HouseStyle.NoEmDash HouseStyle.ContrastFormula HouseStyle.FillerPhrases HouseStyle.Jargon; do
  grep -q "$expected" <<<"$negative_core" || { echo "Expected $expected" >&2; exit 1; }
done
grep -q "DramaticPunctuation.VaguePunchline" <<<"$negative_dramatic" || { echo "Expected dramatic punctuation flag" >&2; exit 1; }
echo "eval-spoken-voice-rules: passed"
