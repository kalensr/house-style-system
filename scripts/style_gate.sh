#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

if ! command -v vale >/dev/null 2>&1; then
  echo "style-gate: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

FILES=("$@")
if [[ ${#FILES[@]} -eq 0 ]]; then
  FILES=()
  while IFS= read -r file; do
    FILES+=("$file")
  done < <(find . -path "./docs/test-fixtures" -prune -o -type f -name "*.md" -print)
fi

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "style-gate: no markdown files found"
  exit 0
fi

vale --config "$ROOT/.vale.ini" "${FILES[@]}"
