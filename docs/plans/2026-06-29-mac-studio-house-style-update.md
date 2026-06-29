# Mac Studio House Style System Update Plan

## Purpose

Apply the House Style System updates to Mac Studio safely after the repo change
has been committed and pushed from MacBook Pro. The initial plan was written as
a future apply step; Kalen later approved execution over `ssh kalen-macos-ts`.

## Current Evidence

Read-only checks on 2026-06-29 before execution:

- `ssh kalen-macos-ts 'hostname'` returned `KalensMacStudio`.
- `~/Projects/house-style-system` was not present on Mac Studio.
- `~/.codex/skills` was present on Mac Studio.
- Repo-memory was advisory only and did not mutate any repo. Its Mac Studio
  host snapshot was not production proof because it was generated from the
  MacBook shell context.

Execution checks on 2026-06-29:

- `ssh kalen-macos-ts` reached host `KalensMacStudio`.
- Mac Studio reported macOS `26.5.1`.
- Git was available at `/opt/homebrew/bin/git`.
- Vale was available at `/opt/homebrew/bin/vale`.
- The repo was cloned to `/Users/kalenhowellsr/Projects/house-style-system`.
- Live proof is recorded in
  `docs/evidence/2026-06-29-mac-studio-house-style-rollout.md`.

## Safety Boundaries

Do not change these in this update:

- Agent Access Broker policy or tokens.
- Caddy, launchd, Tailscale, Notion, Linear, Model Context Protocol, or Keychain
  settings.
- Any q-lab or model-runtime configuration.
- Any repo other than `house-style-system`.

Do not run destructive commands:

- no `rm -rf`,
- no `git reset --hard`,
- no forced pushes,
- no credential edits,
- no service restarts.

Stop and report instead of continuing when:

- Secure Shell does not reach `KalensMacStudio`.
- The target path exists and has local changes.
- The target checkout is on a branch other than `main`.
- `git pull --ff-only` cannot fast-forward.
- Vale is missing and cannot be installed with explicit approval.
- Any validation command fails and the cause is not understood.

## Apply Sequence

### 1. Verify MacBook Production State

Run from MacBook Pro:

```sh
cd /Users/kalenhowellsr/Projects/house-style-system
git status --short --branch
git fetch origin --prune
git rev-parse HEAD
git rev-parse origin/main
git ls-remote origin refs/heads/main
```

Expected:

- Worktree clean.
- Branch is `main`.
- `HEAD`, `origin/main`, and remote `refs/heads/main` match.

### 2. Verify Mac Studio Host Read-Only

Run:

```sh
ssh kalen-macos-ts '
  set -e
  hostname
  sw_vers
  command -v git
  command -v vale || true
  test -d "$HOME/.codex/skills" && echo "codex skills dir: present"
  test -d "$HOME/Projects/house-style-system" && echo "repo: present" || echo "repo: missing"
'
```

Expected:

- Hostname is `KalensMacStudio`.
- Git is available.
- The Codex skills directory is present.
- Repo is either missing or cleanly inspectable.

### 3. Clone If Missing

Only if the repo is missing:

```sh
ssh kalen-macos-ts '
  set -e
  mkdir -p "$HOME/Projects"
  git clone git@github.com:kalensr/house-style-system.git "$HOME/Projects/house-style-system"
'
```

Expected:

- Clone succeeds.
- The checkout is on `main`.

### 4. Update If Present

Only if the repo already exists:

```sh
ssh kalen-macos-ts '
  set -e
  cd "$HOME/Projects/house-style-system"
  git status --short --branch
  test -z "$(git status --porcelain)"
  test "$(git branch --show-current)" = "main"
  git fetch origin --prune
  git pull --ff-only origin main
'
```

Expected:

- Worktree is clean before update.
- Branch is already `main`.
- Pull fast-forwards only.

### 5. Validate Repo On Mac Studio

Run:

```sh
ssh kalen-macos-ts '
  set -e
  cd "$HOME/Projects/house-style-system"
  ./scripts/test-style-gate.sh
  ./scripts/eval-kalen-voice.sh
  ./scripts/style_gate.sh
  ./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md
'
```

Expected:

- Fixture test passes.
- Kalen voice eval passes.
- Default style gate reports 0 errors, warnings, and suggestions.
- Wrapper positive control reports 0 errors, warnings, and suggestions.

If Vale is missing, stop and ask before installing it. A likely install command
is `brew install vale`, but it should be approved as a host package change.

### 6. Refresh Installed Codex Skill

Only after repo validation passes:

```sh
ssh kalen-macos-ts '
  set -e
  cd "$HOME/Projects/house-style-system"
  test -d "$HOME/.codex/skills"
  mkdir -p "$HOME/.codex/skills/house-style-system"
  rsync -a codex-skills/house-style-system/ "$HOME/.codex/skills/house-style-system/"
  test -f "$HOME/.codex/skills/house-style-system/SKILL.md"
'
```

Expected:

- Installed skill exists at `~/.codex/skills/house-style-system/SKILL.md`.
- Only files under `~/.codex/skills/house-style-system/` are updated.
- Stale files are not deleted automatically.

Restart Codex or the relevant agent runtime after this copy if skill discovery
does not refresh automatically.

### 7. Final Proof

Run:

```sh
ssh kalen-macos-ts '
  set -e
  cd "$HOME/Projects/house-style-system"
  git status --short --branch
  git rev-parse HEAD
  git rev-parse origin/main
  git ls-remote origin refs/heads/main
  ./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md
  test -f "$HOME/.codex/skills/house-style-system/SKILL.md"
  grep -q "review-kalen-voice.sh" "$HOME/.codex/skills/house-style-system/SKILL.md"
'
```

Expected:

- Worktree clean.
- Local `HEAD`, `origin/main`, and remote `refs/heads/main` match.
- Wrapper runs successfully on Mac Studio.
- Installed skill file exists and references the wrapper.

## Recovery Notes

- If clone fails, leave `~/Projects/house-style-system` absent or partially
  cloned and report the exact error. Do not delete automatically.
- If an existing checkout is dirty, do not stash, reset, clean, or overwrite.
  Report `git status --short --branch`.
- If fast-forward fails, report divergence and wait for a human decision.
- If skill copy fails after repo validation, leave the repo checkout intact and
  report the installed skill path state.

## Execution Receipt

2026-06-29 execution over `ssh kalen-macos-ts` completed with these boundaries:

- Repo was missing on Mac Studio, so it was cloned to
  `/Users/kalenhowellsr/Projects/house-style-system`.
- The Mac Studio checkout was updated on `main`.
- The first validation run found a portability issue: Vale colorized the clean
  count on Mac Studio, which broke exact output matching in
  `scripts/test-style-gate.sh`.
- The fix was made in `scripts/style_gate.sh` by defaulting automation output to
  `NO_COLOR=1`.
- After the fix was committed and pushed, Mac Studio fast-forwarded to
  `263df6147ea4f05fde8360badf004881804579f7`.
- Mac Studio validation passed:
  `./scripts/test-style-gate.sh`,
  `./scripts/eval-kalen-voice.sh`,
  `./scripts/style_gate.sh`, and
  `./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md`.
- The installed Codex skill was refreshed from the validated checkout with
  `rsync -a` into `~/.codex/skills/house-style-system/`.
- Final remote proof at that checkpoint showed `HEAD == origin/main ==
  263df6147ea4f05fde8360badf004881804579f7`.
- The wrapper smoke test passed on Mac Studio, and the installed skill contained
  the wrapper reference.
- Live evidence for the remote proof is stored in
  `docs/evidence/2026-06-29-mac-studio-house-style-rollout.md`.

These areas were not changed:

- broker or credential settings,
- Caddy, launchd, or Tailscale settings,
- Notion, Linear, or Model Context Protocol settings,
- q-lab or model-runtime configuration,
- host packages.

No destructive command was run.
