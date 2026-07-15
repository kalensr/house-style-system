#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="${HOUSE_STYLE_BIN_DIR:-$HOME/.local/bin}"
LAUNCHER="$ROOT/scripts/house-style-command"
COMMANDS=(
  review-kalen-voice.sh
  review-ai-voice.sh
  review-center-of-gravity.sh
  review-dramatic-punctuation.sh
  eval-kalen-voice.sh
  eval-ai-voice.sh
  eval-center-of-gravity.sh
  eval-dramatic-punctuation.sh
)

mkdir -p "$BIN_DIR"

for command in "${COMMANDS[@]}"; do
  install -m 0755 "$LAUNCHER" "$BIN_DIR/$command"
done

printf 'Installed %s House Style commands in %s\n' "${#COMMANDS[@]}" "$BIN_DIR"
