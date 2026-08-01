#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEMP_ROOT"' EXIT
CONFIG="$TEMP_ROOT/.claude"
BIN="$TEMP_ROOT/bin"
install_cmd=(env CLAUDE_CONFIG_DIR="$CONFIG" HOUSE_STYLE_BIN_DIR="$BIN" "$ROOT/scripts/install-claude-house-style.sh" --allow-dirty)

"${install_cmd[@]}"
diff -qr "$ROOT/claude-skills/house-style" "$CONFIG/skills/house-style"
cmp "$ROOT/claude-rules/house-style-writing.md" "$CONFIG/rules/house-style-writing.md"
test -f "$CONFIG/house-style-install.manifest"
env CLAUDE_CONFIG_DIR="$CONFIG" HOUSE_STYLE_BIN_DIR="$BIN" \
  "$ROOT/scripts/install-claude-house-style.sh" --allow-dirty --check

printf 'stale\n' >"$CONFIG/skills/house-style/stale-file"
"${install_cmd[@]}"
test ! -e "$CONFIG/skills/house-style/stale-file"
printf 'drift\n' >>"$CONFIG/rules/house-style-writing.md"
if env CLAUDE_CONFIG_DIR="$CONFIG" HOUSE_STYLE_BIN_DIR="$BIN" \
  "$ROOT/scripts/install-claude-house-style.sh" --allow-dirty --check; then
  printf 'Expected rule drift check to fail.\n' >&2
  exit 1
fi
"${install_cmd[@]}"
rm -rf "$CONFIG/skills/house-style"
ln -s "$TEMP_ROOT" "$CONFIG/skills/house-style"
if "${install_cmd[@]}"; then
  printf 'Expected symbolic-link refusal.\n' >&2
  exit 1
fi

printf 'test-claude-house-style-install: passed\n'
