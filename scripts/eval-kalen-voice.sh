#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v vale >/dev/null 2>&1; then
  echo "eval-kalen-voice: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

POSITIVE="docs/evals/kalen-voice/positive-leadership-reflection.md"
NEGATIVE="docs/evals/kalen-voice/negative-generic-executive.md"
SUPPORTED_GROUP="docs/evals/kalen-voice/near-miss-supported-group-claim.md"
SUPPORTED_PATH="docs/evals/kalen-voice/near-miss-supported-pathway.md"
QUOTED_MID_DOC="docs/evals/kalen-voice/near-miss-quoted-generic-phrase.md"

positive_output="$(./scripts/style_gate.sh --kalen-voice "$POSITIVE" 2>&1 || true)"
if ! grep -q "0 errors, 0 warnings and 0 suggestions" <<<"$positive_output"; then
  echo "Expected no style alerts for $POSITIVE" >&2
  echo "$positive_output" >&2
  exit 1
fi

negative_output="$(./scripts/style_gate.sh --kalen-voice "$NEGATIVE" 2>&1 || true)"
for rule in \
  "KalenVoice.GenericAIOpenings" \
  "KalenVoice.AbstractOpenings" \
  "KalenVoice.PathwaySupport" \
  "KalenVoice.EvidenceSupport" \
  "KalenVoice.ExecutiveTone"; do
  if ! grep -q "$rule" <<<"$negative_output"; then
    echo "Expected $rule for $NEGATIVE" >&2
    echo "$negative_output" >&2
    exit 1
  fi
done

for fixture in "$SUPPORTED_GROUP" "$SUPPORTED_PATH" "$QUOTED_MID_DOC"; do
  output="$(./scripts/style_gate.sh --kalen-voice "$fixture" 2>&1 || true)"
  if grep -q "KalenVoice" <<<"$output"; then
    echo "Expected no Kalen voice rule alerts for $fixture" >&2
    echo "$output" >&2
    exit 1
  fi
done

default_voice_output="$(./scripts/style_gate.sh "$NEGATIVE" 2>&1 || true)"
if grep -q "KalenVoice" <<<"$default_voice_output"; then
  echo "Expected KalenVoice rules to require --kalen-voice" >&2
  echo "$default_voice_output" >&2
  exit 1
fi

echo "eval-kalen-voice: passed"
