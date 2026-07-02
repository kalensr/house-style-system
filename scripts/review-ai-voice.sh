#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

usage() {
  cat >&2 <<'EOF'
Usage: ./scripts/review-ai-voice.sh <file> [file...]

Runs the opt-in AI voice avoidance review layer for specific Markdown files.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -eq 0 ]]; then
  usage
  exit 2
fi

exec ./scripts/style_gate.sh --ai-voice "$@"
