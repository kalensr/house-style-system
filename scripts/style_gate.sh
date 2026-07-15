#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CALLER_PWD="$PWD"
cd "$ROOT"

CONFIG="$ROOT/.vale.ini"
MODE="house"
ARGS=()

select_optional_layer() {
  local next_mode="$1"
  local next_config="$2"

  if [[ "$MODE" != "house" ]]; then
    echo "style-gate: choose only one optional review layer: --kalen-voice, --ai-voice, --center-of-gravity, or --dramatic-punctuation" >&2
    exit 2
  fi

  MODE="$next_mode"
  CONFIG="$next_config"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --kalen-voice)
      select_optional_layer "kalen" "$ROOT/.vale-kalen.ini"
      shift
      ;;
    --ai-voice)
      select_optional_layer "ai" "$ROOT/.vale-ai-voice.ini"
      shift
      ;;
    --center-of-gravity)
      select_optional_layer "center-of-gravity" "$ROOT/.vale-center-of-gravity.ini"
      shift
      ;;
    --dramatic-punctuation)
      select_optional_layer "dramatic-punctuation" "$ROOT/.vale-dramatic-punctuation.ini"
      shift
      ;;
    *)
      if [[ "$1" == /* ]]; then
        ARGS+=("$1")
      else
        ARGS+=("$CALLER_PWD/$1")
      fi
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
