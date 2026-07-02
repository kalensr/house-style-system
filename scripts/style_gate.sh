#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

CONFIG="$ROOT/.vale.ini"
MODE="house"
ARGS=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --kalen-voice)
      if [[ "$MODE" == "ai" ]]; then
        echo "style-gate: choose only one voice layer: --kalen-voice or --ai-voice" >&2
        exit 2
      fi
      MODE="kalen"
      CONFIG="$ROOT/.vale-kalen.ini"
      shift
      ;;
    --ai-voice)
      if [[ "$MODE" == "kalen" ]]; then
        echo "style-gate: choose only one voice layer: --kalen-voice or --ai-voice" >&2
        exit 2
      fi
      MODE="ai"
      CONFIG="$ROOT/.vale-ai-voice.ini"
      shift
      ;;
    *)
      ARGS+=("$1")
      shift
      ;;
  esac
done

if ! command -v vale >/dev/null 2>&1; then
  echo "style-gate: Vale is not installed. Install with: brew install vale" >&2
  exit 1
fi

FILES=()
if [[ ${#ARGS[@]} -gt 0 ]]; then
  FILES=("${ARGS[@]}")
fi
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

if [[ "${STYLE_GATE_COLOR:-0}" == "1" ]]; then
  unset NO_COLOR
elif [[ -z "${NO_COLOR+x}" ]]; then
  export NO_COLOR=1
fi

vale --config "$CONFIG" "${FILES[@]}"
