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
  "No antithesis"
  "No corrective negation"
  "No paragraph pinning"
  "No parataxis"
  "No summary beats"
  "No rhetorical crutches"
  "No negative parallelisms"
  "No negative anaphoras"
  "No contrasting pairs"
  "No rule of three"
  "No em dashes"
  "No throat-clearing openers"
  "No landing sentences"
  "No setup/payoff constructions"
  "No parallel sentence structures within a paragraph"
  "Vary sentence length unpredictably"
  "No stacked noun phrases"
  "No filler intensifiers"
  "No corporate-register verbs"
  "No nominalization"
  "No hedging qualifiers"
  "Write for the spoken voice"
  "No performed enthusiasm"
)

natural_voice_heading="Natural Voice And Sloganized Synthesis"

for surface in "${surfaces[@]}"; do
  if ! grep -Fq "$natural_voice_heading" "$surface"; then
    echo "Missing '$natural_voice_heading' in $surface" >&2
    exit 1
  fi
  for rule in "${rules[@]}"; do
    if ! grep -Fq "$rule" "$surface"; then
      echo "Missing '$rule' in $surface" >&2
      exit 1
    fi
  done
done

pairs="docs/evals/spoken-voice/sloganized-synthesis-pairs.md"
for expected in \
  "Abstract causal formula" \
  "Sloganized parallelism" \
  "Depersonalized case narration" \
  "Authoritative solution label"; do
  if ! grep -Fq "$expected" "$pairs"; then
    echo "Expected '$expected' in the sloganized-synthesis pairs" >&2
    exit 1
  fi
done

positive="docs/evals/spoken-voice/positive-cross-domain.md"
positive_output="$(./scripts/style_gate.sh "$positive" 2>&1 || true)"
if ! grep -q "0 errors, 0 warnings and 0 suggestions" <<<"$positive_output"; then
  echo "Expected the cross-domain positive control to pass the core gate" >&2
  echo "$positive_output" >&2
  exit 1
fi

if grep -Eiq '—|\b(genuinely|really|truly|actually|leverage|underscore|reflect)\b|here is the thing|what matters is|the key is|it is worth noting' "$positive"; then
  echo "Cross-domain positive control contains a prohibited surface pattern" >&2
  exit 1
fi

revised="docs/evals/spoken-voice/revised-ai-cadence.md"
revised_output="$(./scripts/style_gate.sh "$revised" 2>&1 || true)"
if ! grep -q "0 errors, 0 warnings and 0 suggestions" <<<"$revised_output"; then
  echo "Expected the revised control to pass the core gate" >&2
  echo "$revised_output" >&2
  exit 1
fi

if grep -Eiq '—|\b(genuinely|really|truly|actually|leverage|underscore|reflect)\b|here is the thing|what matters is|the key is|it is worth noting' "$revised"; then
  echo "Revised control contains a prohibited surface pattern" >&2
  exit 1
fi

negative="docs/evals/spoken-voice/negative-ai-cadence.md"
negative_core="$(./scripts/style_gate.sh "$negative" 2>&1 || true)"
negative_dramatic="$(./scripts/review-dramatic-punctuation.sh "$negative" 2>&1 || true)"

for expected in \
  "HouseStyle.NoEmDash" \
  "HouseStyle.ContrastFormula" \
  "HouseStyle.FillerPhrases" \
  "HouseStyle.Jargon"; do
  if ! grep -q "$expected" <<<"$negative_core"; then
    echo "Expected $expected in the negative control" >&2
    echo "$negative_core" >&2
    exit 1
  fi
done

if ! grep -q "DramaticPunctuation.VaguePunchline" <<<"$negative_dramatic"; then
  echo "Expected DramaticPunctuation.VaguePunchline in the negative control" >&2
  echo "$negative_dramatic" >&2
  exit 1
fi

echo "eval-spoken-voice-rules: passed"
