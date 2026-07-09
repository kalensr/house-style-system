#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DENYLIST="${PUBLIC_SCRUB_DENYLIST:-}"

if [[ -n "$DENYLIST" && ! -f "$DENYLIST" ]]; then
  echo "check-public-tree: denylist not found: $DENYLIST" >&2
  exit 2
fi

declare -a SHAPES=(
  '/Users/[A-Za-z0-9._/-]+'
  '([0-9]{1,3}\.){3}[0-9]{1,3}'
  '[A-Za-z0-9._-]+\.tail[A-Za-z0-9._-]*\.ts\.net'
  'tail[0-9a-f]{6,}'
  '(sk|pk|ghp|xox[a-z])[-_][A-Za-z0-9]{10,}'
  'BEGIN[[:space:]]+(RSA |EC |OPENSSH )?PRIVATE KEY'
  'com\.kalen\.'
  'runtime/penny/workspace\.json'
  'voice-corpus'
)

FAIL=0
COUNT=0

while IFS= read -r -d '' relative; do
  case "$relative" in
    scripts/check-public-tree.sh|scripts/check-public-history.sh)
      continue
      ;;
    .codex/orchestration/*|docs/plans/*|docs/evidence/*|runtime/*|drafts/*|*voice-corpus*)
      echo "BLOCK sensitive path in candidate tree: $relative"
      FAIL=1
      ;;
  esac

  file="$ROOT/$relative"
  [[ -f "$file" ]] || continue
  COUNT=$((COUNT + 1))

  for pattern in "${SHAPES[@]}"; do
    if grep -nEI "$pattern" "$file" >/dev/null 2>&1; then
      echo "BLOCK shape match in $relative: /$pattern/"
      grep -nEI "$pattern" "$file" | head -5
      FAIL=1
    fi
  done

  if [[ -n "$DENYLIST" ]]; then
    while IFS= read -r term; do
      [[ -z "$term" || "$term" == \#* ]] && continue
      declare -a MATCH_ARGS=(-nFiI)
      if [[ "$term" =~ ^[[:alnum:]_-]+$ ]]; then
        MATCH_ARGS+=(-w)
      fi
      if grep "${MATCH_ARGS[@]}" -- "$term" "$file" >/dev/null 2>&1; then
        echo "BLOCK denylist match in $relative: $term"
        grep "${MATCH_ARGS[@]}" -- "$term" "$file" | head -5
        FAIL=1
      fi
    done < "$DENYLIST"
  fi
done < <(git -C "$ROOT" ls-files -z --cached --others --exclude-standard)

if [[ "$FAIL" -ne 0 ]]; then
  echo "check-public-tree: FAILED"
  exit 1
fi

echo "check-public-tree: passed for $COUNT file(s)"
