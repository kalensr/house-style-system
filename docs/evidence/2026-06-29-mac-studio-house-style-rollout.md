# Mac Studio House Style Rollout Evidence

Date: 2026-06-29

Purpose: prove that the Mac Studio checkout and installed Codex skill were
current after the house-style-system rollout.

Host access used: `ssh -o BatchMode=yes -o ConnectTimeout=10 kalen-macos-ts`.

Scope of the check:

- read host identity and tool paths,
- read repo status and commit equality,
- run repo validation commands,
- verify the installed skill file exists,
- verify the installed skill references `review-kalen-voice.sh`.

The check did not edit these areas:

- broker or credential settings,
- Caddy, launchd, or Tailscale settings,
- Notion, Linear, or Model Context Protocol settings,
- q-lab or model-runtime settings,
- host package settings.

## Command Shape

```sh
ssh -o BatchMode=yes -o ConnectTimeout=10 kalen-macos-ts 'bash -s' <<'REMOTE'
set -euo pipefail
repo="$HOME/Projects/house-style-system"
skill="$HOME/.codex/skills/house-style-system/SKILL.md"
echo "host=$(hostname)"
echo "macos=$(sw_vers -productVersion)"
echo "git=$(command -v git)"
echo "vale=$(command -v vale)"
cd "$repo"
echo "repo=$repo"
echo "branch=$(git branch --show-current)"
echo "status=$(git status --short --branch)"
echo "head=$(git rev-parse HEAD)"
echo "origin_main=$(git rev-parse origin/main)"
echo "remote_main=$(git ls-remote origin refs/heads/main | awk '{print $1}')"
./scripts/test-style-gate.sh
./scripts/eval-kalen-voice.sh
./scripts/style_gate.sh
./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md
test -f "$skill"
echo "installed_skill=$skill"
grep -q 'review-kalen-voice.sh' "$skill"
echo "installed_skill_wrapper_reference=present"
REMOTE
```

## Output

```text
host=KalensMacStudio
macos=26.5.1
git=/opt/homebrew/bin/git
vale=/opt/homebrew/bin/vale
repo=/Users/kalenhowellsr/Projects/house-style-system
branch=main
status=## main...origin/main
head=263df6147ea4f05fde8360badf004881804579f7
origin_main=263df6147ea4f05fde8360badf004881804579f7
remote_main=263df6147ea4f05fde8360badf004881804579f7
test-style-gate: passed
eval-kalen-voice: passed
0 errors, 0 warnings and 0 suggestions in 11 files.
0 errors, 0 warnings and 0 suggestions in 1 file.
installed_skill=/Users/kalenhowellsr/.codex/skills/house-style-system/SKILL.md
installed_skill_wrapper_reference=present
```

## Interpretation

- Mac Studio reached the expected host.
- The repo checkout was on `main`.
- `HEAD`, `origin/main`, and remote `refs/heads/main` matched at
  `263df6147ea4f05fde8360badf004881804579f7`.
- Repo validation passed on Mac Studio.
- The installed Codex skill existed and referenced the Kalen voice wrapper.
