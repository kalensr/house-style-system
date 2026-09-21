#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMP_ROOT="$(mktemp -d)"
trap 'rm -rf "$TEMP_ROOT"' EXIT

CLAUDE_CONFIG_DIR="$TEMP_ROOT/.claude" "$ROOT/scripts/install-claude-house-style.sh"

diff -qr "$ROOT/claude-skills/house-style" \
  "$TEMP_ROOT/.claude/skills/house-style"
cmp "$ROOT/claude-rules/house-style-writing.md" \
  "$TEMP_ROOT/.claude/rules/house-style-writing.md"
CLAUDE_CONFIG_DIR="$TEMP_ROOT/.claude" \
  "$ROOT/scripts/install-claude-house-style.sh" --check

printf 'test-claude-house-style-install: passed\n'
