#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEMP_ROOT"' EXIT

CLAUDE_CONFIG_DIR="$TEMP_ROOT/.claude" "$ROOT/scripts/install-claude-house-style.sh"

printf 'preserve me\n' > "$TEMP_ROOT/.claude/skills/house-style/unrelated-user-file.txt"
CLAUDE_CONFIG_DIR="$TEMP_ROOT/.claude" "$ROOT/scripts/install-claude-house-style.sh"
grep -Fx 'preserve me' "$TEMP_ROOT/.claude/skills/house-style/unrelated-user-file.txt"

while IFS= read -r -d '' source_file; do
  relative_path="${source_file#"$ROOT/claude-skills/house-style/"}"
  cmp "$source_file" "$TEMP_ROOT/.claude/skills/house-style/$relative_path"
done < <(find "$ROOT/claude-skills/house-style" -type f -print0)
cmp "$ROOT/claude-rules/house-style-writing.md" \
  "$TEMP_ROOT/.claude/rules/house-style-writing.md"
CLAUDE_CONFIG_DIR="$TEMP_ROOT/.claude" \
  "$ROOT/scripts/install-claude-house-style.sh" --check

printf 'test-claude-house-style-install: passed\n'
