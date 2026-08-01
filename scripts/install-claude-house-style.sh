#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_SKILL="$ROOT/claude-skills/house-style"
SOURCE_RULE="$ROOT/claude-rules/house-style-writing.md"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
TARGET_SKILL="$CLAUDE_DIR/skills/house-style"
TARGET_RULE="$CLAUDE_DIR/rules/house-style-writing.md"
MANIFEST="$CLAUDE_DIR/house-style-install.manifest"
EXPECTED_REVISION=""
CHECK=0
ALLOW_DIRTY=0

usage() {
  printf 'Usage: %s [--check] [--expect-revision <sha>] [--allow-dirty]\n' \
    "$(basename "$0")"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --check) CHECK=1 ;;
    --allow-dirty) ALLOW_DIRTY=1 ;;
    --expect-revision)
      [[ $# -ge 2 ]] || { usage >&2; exit 2; }
      EXPECTED_REVISION="$2"
      shift
      ;;
    *) usage >&2; exit 2 ;;
  esac
  shift
done

[[ -f "$SOURCE_SKILL/SKILL.md" ]] || { printf 'Missing skill source.\n' >&2; exit 1; }
[[ -f "$SOURCE_RULE" ]] || { printf 'Missing rule source.\n' >&2; exit 1; }

REVISION="$(git -C "$ROOT" rev-parse HEAD 2>/dev/null || printf 'unknown')"
if ! git -C "$ROOT" diff --quiet || ! git -C "$ROOT" diff --cached --quiet; then
  DIRTY=true
else
  DIRTY=false
fi
if [[ "$DIRTY" == true && $ALLOW_DIRTY -ne 1 ]]; then
  printf 'Refusing to install from a dirty source. Use --allow-dirty for development.\n' >&2
  exit 1
fi
if [[ -n "$EXPECTED_REVISION" && "$REVISION" != "$EXPECTED_REVISION" ]]; then
  printf 'Expected revision %s, found %s.\n' "$EXPECTED_REVISION" "$REVISION" >&2
  exit 1
fi
if [[ -L "$TARGET_SKILL" || -L "$TARGET_RULE" || -L "$MANIFEST" ]]; then
  printf 'Refusing to replace a symbolic-link target.\n' >&2
  exit 1
fi

skill_hash="$(cd "$SOURCE_SKILL" && find . -type f -print0 | sort -z | xargs -0 shasum -a 256 | shasum -a 256 | awk '{print $1}')"
rule_hash="$(shasum -a 256 "$SOURCE_RULE" | awk '{print $1}')"

if [[ $CHECK -eq 1 ]]; then
  status=0
  diff -qr "$SOURCE_SKILL" "$TARGET_SKILL" || status=1
  cmp -s "$SOURCE_RULE" "$TARGET_RULE" || { printf 'Claude writing rule differs.\n' >&2; status=1; }
  expected_manifest=$(printf 'revision=%s\ndirty=%s\nskill_sha256=%s\nrule_sha256=%s\n' "$REVISION" "$DIRTY" "$skill_hash" "$rule_hash")
  [[ -f "$MANIFEST" ]] && [[ "$(cat "$MANIFEST")" == "$expected_manifest" ]] || { printf 'Claude install manifest differs.\n' >&2; status=1; }
  HOUSE_STYLE_BIN_DIR="${HOUSE_STYLE_BIN_DIR:-$HOME/.local/bin}" "$ROOT/scripts/install-global-commands.sh" --check || status=1
  [[ $status -eq 0 ]] && printf 'Claude house-style installation is current at revision %s.\n' "$REVISION"
  exit "$status"
fi

mkdir -p "$CLAUDE_DIR/skills" "$CLAUDE_DIR/rules"
stage="$(mktemp -d "$CLAUDE_DIR/skills/.house-style-stage.XXXXXX")"
rule_stage="$(mktemp "$CLAUDE_DIR/rules/.house-style-writing.XXXXXX")"
cleanup() { rm -rf "$stage"; rm -f "$rule_stage"; }
trap cleanup EXIT
rsync -a --delete "$SOURCE_SKILL/" "$stage/"
install -m 0644 "$SOURCE_RULE" "$rule_stage"
if [[ -e "$TARGET_SKILL" ]]; then
  backup="$CLAUDE_DIR/skills/.house-style-backup.$$"
  mv "$TARGET_SKILL" "$backup"
fi
if ! mv "$stage" "$TARGET_SKILL"; then
  [[ -n "${backup:-}" && -e "$backup" ]] && mv "$backup" "$TARGET_SKILL"
  exit 1
fi
rm -rf "${backup:-}"
mv "$rule_stage" "$TARGET_RULE"
printf 'revision=%s\ndirty=%s\nskill_sha256=%s\nrule_sha256=%s\n' "$REVISION" "$DIRTY" "$skill_hash" "$rule_hash" >"$MANIFEST"
HOUSE_STYLE_BIN_DIR="${HOUSE_STYLE_BIN_DIR:-$HOME/.local/bin}" "$ROOT/scripts/install-global-commands.sh"
printf 'Installed Claude house-style skill, writing rule, and global review commands.\n'
