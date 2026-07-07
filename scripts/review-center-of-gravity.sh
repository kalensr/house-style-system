#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if [[ $# -eq 0 ]]; then
  cat >&2 <<'USAGE'
Usage: ./scripts/review-center-of-gravity.sh <file> [file...]

Runs the opt-in Center of Gravity review layer for specific Markdown files.
USAGE
  exit 2
fi

exec ./scripts/style_gate.sh --center-of-gravity "$@"
