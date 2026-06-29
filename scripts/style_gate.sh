#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

CONFIG="$ROOT/.vale.ini"
if [[ "${1:-}" == "--kalen-voice" ]]; then
  CONFIG="$ROOT/.vale-kalen.ini"
  shift
fi

if ! command -v vale >/dev/null 2>&1; then
  echo "style-gate: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

FILES=("$@")
if [[ ${#FILES[@]} -eq 0 ]]; then
  FILES=()
  while IFS= read -r file; do
    FILES+=("$file")
  done < <(find . \( -path "./docs/test-fixtures" -o -path "./docs/evals" -o -path "./docs/plans" \) -prune -o -type f -name "*.md" -print)
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "style-gate: no markdown files found"
  exit 0
fi

if [[ "${STYLE_GATE_PRINT_FILES:-0}" == "1" ]]; then
  printf '%s\n' "${FILES[@]}"
  exit 0
fi

export NO_COLOR="${NO_COLOR:-1}"
vale --config "$CONFIG" "${FILES[@]}"
