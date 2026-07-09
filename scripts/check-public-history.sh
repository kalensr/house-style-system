#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DENYLIST="${PUBLIC_SCRUB_DENYLIST:-}"

if [[ -n "$DENYLIST" && ! -f "$DENYLIST" ]]; then
  echo "check-public-history: denylist not found: $DENYLIST" >&2
  exit 2
fi

SHAPE='/Users/[A-Za-z0-9._/-]+|([0-9]{1,3}\.){3}[0-9]{1,3}|[A-Za-z0-9._-]+\.tail[A-Za-z0-9._-]*\.ts\.net|tail[0-9a-f]{6,}|(sk|pk|ghp|xox[a-z])[-_][A-Za-z0-9]{10,}|BEGIN[[:space:]]+(RSA |EC |OPENSSH )?PRIVATE KEY|com\.kalen\.|runtime/penny/workspace\.json|voice-corpus'
FAIL=0
COUNT=0

while IFS= read -r commit; do
  COUNT=$((COUNT + 1))

  if git -C "$ROOT" ls-tree -r --name-only "$commit" | grep -Eq '^(\.codex/orchestration/|docs/plans/|docs/evidence/|runtime/|drafts/)|voice-corpus'; then
    echo "BLOCK sensitive path reachable from commit $commit"
    git -C "$ROOT" ls-tree -r --name-only "$commit" | grep -E '^(\.codex/orchestration/|docs/plans/|docs/evidence/|runtime/|drafts/)|voice-corpus' | head -10
    FAIL=1
  fi

  if git -C "$ROOT" grep -n -I -E "$SHAPE" "$commit" -- . \
    ':(exclude)scripts/check-public-tree.sh' \
    ':(exclude)scripts/check-public-history.sh' >/dev/null 2>&1; then
    echo "BLOCK private-data shape reachable from commit $commit"
    git -C "$ROOT" grep -n -I -E "$SHAPE" "$commit" -- . \
      ':(exclude)scripts/check-public-tree.sh' \
      ':(exclude)scripts/check-public-history.sh' | head -10
    FAIL=1
  fi

  if [[ -n "$DENYLIST" ]]; then
    while IFS= read -r term; do
      [[ -z "$term" || "$term" == \#* ]] && continue
      declare -a MATCH_ARGS=(-n -I -F -i)
      if [[ "$term" =~ ^[[:alnum:]_-]+$ ]]; then
        MATCH_ARGS+=(-w)
      fi
      if git -C "$ROOT" grep "${MATCH_ARGS[@]}" -- "$term" "$commit" -- . >/dev/null 2>&1; then
        echo "BLOCK denylist term reachable from commit $commit: $term"
        git -C "$ROOT" grep "${MATCH_ARGS[@]}" -- "$term" "$commit" -- . | head -10
        FAIL=1
      fi
    done < "$DENYLIST"
  fi
done < <(git -C "$ROOT" rev-list --all)

if [[ "$FAIL" -ne 0 ]]; then
  echo "check-public-history: FAILED"
  exit 1
fi

echo "check-public-history: passed for $COUNT commit(s)"
