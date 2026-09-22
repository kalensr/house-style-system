#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

usage() {
  cat >&2 <<'EOF'
Usage: ./scripts/review-release-writing.sh [--kalen-voice] <file> [file...]

Runs the required multi-layer release review for publishable Markdown:
HouseStyle, AIVoice, CenterOfGravity, and DramaticPunctuation. Add
--kalen-voice for Kalen leadership, reflection, or public-essay review.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

MODE="--release-review"
if [[ "${1:-}" == "--kalen-voice" ]]; then
  MODE="--release-review-kalen"
  shift
fi

if [[ $# -eq 0 ]]; then
  usage
  exit 2
fi

exec ./scripts/style_gate.sh "$MODE" "$@"
