# Mac Studio House Style System Update Plan

## Purpose

Apply the House Style System updates to a secondary workstation safely after the
repo change has been committed and pushed from the primary workstation. The
initial plan was written as a future apply step. Kalen later approved bounded
remote execution.

## Current Evidence

Read-only checks on 2026-06-29 before execution:

- Remote access reached the expected secondary workstation.
- The repo checkout was not yet present there.
- The local Codex skills directory existed.
- Repo-memory was advisory only and did not mutate any repo.

Execution checks on 2026-06-29:

- Remote access reached the expected secondary workstation.
- Git and Vale were available.
- The repo was cloned to the expected user project directory.
- Live proof is recorded in
  `docs/evidence/2026-06-29-mac-studio-house-style-rollout.md`.

## Safety Boundaries

Do not change credentials, broker policy, host services, connector settings,
model-runtime settings, host package settings, or any repo other than
`house-style-system`.

Do not run destructive commands:

- no `rm -rf`,
- no `git reset --hard`,
- no forced pushes,
- no credential edits,
- no service restarts.

Stop and report instead of continuing when:

- remote access does not reach the expected workstation.
- The target path exists and has local changes.
- The target checkout is on a branch other than `main`.
- `git pull --ff-only` cannot fast-forward.
- Vale is missing and cannot be installed with explicit approval.
- Any validation command fails and the cause is not understood.

## Apply Sequence

### 1. Verify MacBook Production State

Run from MacBook Pro:

```sh
cd /path/to/house-style-system
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

### 2. Verify Secondary Workstation Read-Only

Run a read-only remote check that confirms:

- Git is available.
- The Codex skills directory is present.
- Repo is either missing or cleanly inspectable.

### 3. Clone If Missing

Only clone the repo if the read-only check shows that it is missing. Use the
approved remote shell path and clone `git@github.com:kalensr/house-style-system.git`
into the expected user project directory.

Expected:

- Clone succeeds.
- The checkout is on `main`.

### 4. Update If Present

Only update an existing checkout after proving it is clean and already on
`main`. Fetch from `origin`, then use a fast-forward-only pull from `main`.

Expected:

- Worktree is clean before update.
- Branch is already `main`.
- Pull fast-forwards only.

### 5. Validate Repo On Secondary Workstation

Run validation from the remote checkout.

Expected:

- Fixture test passes.
- Kalen voice eval passes.
- Default style gate reports 0 errors, warnings, and suggestions.
- Wrapper positive control reports 0 errors, warnings, and suggestions.

If Vale is missing, stop and ask before installing it. A likely install command
is `brew install vale`, but it should be approved as a host package change.

### 6. Refresh Installed Codex Skill

Only after repo validation passes:

Copy `codex-skills/house-style-system/` from the validated checkout into the
installed skill directory. Verify that the installed `SKILL.md` exists after
the copy.

Expected:

- Installed skill exists at `~/.codex/skills/house-style-system/SKILL.md`.
- Only files under `~/.codex/skills/house-style-system/` are updated.
- Stale files are not deleted automatically.

Restart Codex or the relevant agent runtime after this copy if skill discovery
does not refresh automatically.

### 7. Final Proof

Run a final remote proof that checks repo status, commit equality, wrapper
validation, installed skill presence, and wrapper reference.

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

2026-06-29 remote execution completed with these boundaries:

- The repo was missing on the secondary workstation, so it was cloned to the
  expected user project directory.
- The secondary checkout was updated on `main`.
- The first validation run found a portability issue: Vale colorized the clean
  count on the secondary workstation, which broke exact output matching in
  `scripts/test-style-gate.sh`.
- The fix was made in `scripts/style_gate.sh` by defaulting automation output to
  `NO_COLOR=1`.
- After the fix was committed and pushed, the secondary checkout fast-forwarded to
  `263df6147ea4f05fde8360badf004881804579f7`.
- Remote validation passed:
  `./scripts/test-style-gate.sh`,
  `./scripts/eval-kalen-voice.sh`,
  `./scripts/style_gate.sh`, and
  `./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md`.
- The installed Codex skill was refreshed from the validated checkout with
  `rsync -a` into `~/.codex/skills/house-style-system/`.
- Final remote proof at that checkpoint showed `HEAD == origin/main ==
  263df6147ea4f05fde8360badf004881804579f7`.
- The wrapper smoke test passed, and the installed skill contained
  the wrapper reference.
- Live evidence for the remote proof is stored in
  `docs/evidence/2026-06-29-mac-studio-house-style-rollout.md`.

Credentials, broker policy, host services, connector settings, model-runtime
settings, and host package settings were not changed.

No destructive command was run.
