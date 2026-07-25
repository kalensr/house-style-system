#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat >&2 <<'EOF'
Usage: ./scripts/check-outcome-evaluation.sh <evaluation.md>

Checks that an independent draft-level outcome-evaluation packet contains the
required review attestations, five scores, and a release decision. It verifies
packet structure only; it cannot prove reviewer independence or writing quality.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -ne 1 ]]; then
  usage
  exit 2
fi

PACKET="$1"
if [[ ! -f "$PACKET" ]]; then
  echo "check-outcome-evaluation: file not found: $PACKET" >&2
  exit 2
fi

require_line() {
  local pattern="$1"
  local description="$2"

  if ! grep -Eq "$pattern" "$PACKET"; then
    echo "check-outcome-evaluation: missing $description" >&2
    exit 1
  fi
}

require_line '^# Independent Draft Outcome Evaluation$' 'title'
require_line '^- Draft ID: .+' 'draft ID'
require_line '^- Domain: .+' 'domain'
require_line '^- Drafter: .+' 'drafter'
require_line '^- Evaluator: .+' 'evaluator'
require_line '^- Evaluator independence attested: Yes$' 'independence attestation'
require_line '^- Evaluator authored the revision: No$' 'independence attestation'
require_line '^- Blind comparison: Yes$' 'blind-comparison attestation'
require_line '^- Blind mapping recorded after scoring: Yes$' 'blind-mapping attestation'
require_line '^- Source packet reviewed: Yes$' 'source-packet attestation'
require_line '^- Factual and meaning preservation: [1-5]$' 'factual-and-meaning score'
require_line '^- Evidence integrity: [1-5]$' 'evidence-integrity score'
require_line '^- Voice fit: [1-5]$' 'voice-fit score'
require_line '^- Reader usefulness: [1-5]$' 'reader-usefulness score'
require_line '^- Generic-pattern reduction: [1-5]$' 'generic-pattern-reduction score'
require_line '^- Preferred version: (A|B|Tie)$' 'blinded preference'
require_line '^- Revised version: (A|B)$' 'unblinded revision mapping'
require_line '^- Decision: (Approved|Revise|Rejected)$' 'release decision'
require_line '^- Rationale: .+' 'decision rationale'

drafter="$(sed -n 's/^- Drafter: //p' "$PACKET" | head -n 1)"
evaluator="$(sed -n 's/^- Evaluator: //p' "$PACKET" | head -n 1)"
if [[ "$drafter" == "$evaluator" ]]; then
  echo "check-outcome-evaluation: drafter and evaluator must be different" >&2
  exit 1
fi

echo "check-outcome-evaluation: passed"
