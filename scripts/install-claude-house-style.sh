#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_SKILL="$ROOT/claude-skills/house-style"
SOURCE_RULE="$ROOT/claude-rules/house-style-writing.md"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
TARGET_SKILL="$CLAUDE_DIR/skills/house-style"
TARGET_RULE="$CLAUDE_DIR/rules/house-style-writing.md"

usage() {
  printf 'Usage: %s [--check]\n' "$(basename "$0")"
}

if [[ $# -gt 1 || ( $# -eq 1 && "$1" != "--check" ) ]]; then
  usage >&2
  exit 2
fi

[[ -f "$SOURCE_SKILL/SKILL.md" ]] || {
  printf 'Missing Claude skill source: %s\n' "$SOURCE_SKILL/SKILL.md" >&2
  exit 1
}
[[ -f "$SOURCE_RULE" ]] || {
  printf 'Missing Claude rule source: %s\n' "$SOURCE_RULE" >&2
  exit 1
}

if [[ "${1:-}" == "--check" ]]; then
  status=0
  skill_changes="$(rsync -rcn --itemize-changes "$SOURCE_SKILL/" "$TARGET_SKILL/" 2>&1)" || {
    printf '%s\n' "$skill_changes" >&2
    status=1
  }
  if [[ -n "$skill_changes" ]]; then
    printf 'Claude house-style source files differ:\n%s\n' "$skill_changes" >&2
    status=1
  fi
  if ! cmp -s "$SOURCE_RULE" "$TARGET_RULE"; then
    printf 'Claude writing rule differs: %s\n' "$TARGET_RULE" >&2
    status=1
  fi
  if [[ $status -eq 0 ]]; then
    printf 'Claude house-style skill and global writing rule are current.\n'
  fi
  exit "$status"
fi

mkdir -p "$(dirname "$TARGET_SKILL")" "$(dirname "$TARGET_RULE")"
rsync -a "$SOURCE_SKILL/" "$TARGET_SKILL/"
install -m 0644 "$SOURCE_RULE" "$TARGET_RULE"

printf 'Installed Claude house-style skill in %s\n' "$TARGET_SKILL"
printf 'Installed Claude global writing rule in %s\n' "$TARGET_RULE"
