# Make The House Style System MDX-First

This ExecPlan is a living document. Keep `Progress`, `Surprises & Discoveries`,
`Decision Log`, and `Outcomes & Retrospective` current as work proceeds.

## Purpose / Big Picture

Make MDX, a Markdown format that permits JSX-style components, a first-class
writing format across the reusable House Style System and its `kalensr.com`
integration. After the work, Codex can run the same house style and optional
voice-review layers on Markdown and MDX. The MDX path will parse component
syntax safely, ignore code, lint reader-facing prose, and fail with a specific
dependency message when its parser is unavailable.

ChatGPT remains an editorial collaborator, not a local validator. Its project
package will use reader-oriented Markdown guidance or a Markdown companion for
MDX sources, while the repository build and style gate remain the enforcement
path.

## Progress

- [x] 2026-07-09 America/New_York: Confirmed the target outcome and source
  hierarchy.
- [x] 2026-07-09 America/New_York: Verified that Vale 3.13.1 supports native
  MDX through `mdx2vast`, which is not installed on this Mac.
- [x] 2026-07-09 America/New_York: Verified that `kalensr.com` currently
  sanitizes MDX frontmatter and uses `vale --ignore-syntax` as a fallback.
- [x] 2026-07-09 America/New_York: Verified that the reusable package only
  discovers `*.md` and all five Vale configurations only match `*.md`.
- [x] 2026-07-09 America/New_York: Selected a Full ExecPlan because the change
  affects reusable tooling, skills, fixtures, documentation, two repositories,
  installed-skill guidance, and host rollout.
- [x] 2026-07-09 America/New_York: Completed Critical Review pass 1 and
  replaced the nondeterministic package-initialization step with an explicit
  manifest requirement.
- [x] 2026-07-09 America/New_York: Completed Critical Review pass 2. The plan
  names fixture paths, test ownership, dependency behavior, branch boundaries,
  and a no-silent-fallback recovery rule.
- [ ] Implement the canonical MDX-aware style-gate path and fixtures.
- [ ] Adopt the native parser path in `kalensr.com` and add integration tests.
- [ ] Update skill and ChatGPT guidance, then validate local and Mac Studio
  parity.
- [ ] Commit and push each repository only after its validation passes.

## Surprises & Discoveries

- Observation: Vale has native MDX support but requires the external
  `mdx2vast` executable.
  Evidence: `vale content/writing/articles/what-structured-writing-needs-from-ai-systems.mdx`
  exits with `E100 [lintMDX] Runtime error` and `mdx2vast not found` on this
  machine.

- Observation: `kalensr.com` can include and lint `.mdx` files today, but its
  `--ignore-syntax` fallback treats MDX as plain text instead of using a syntax
  aware parser.
  Evidence: `kalensr.com/scripts/style_gate.sh` separates `MDX_FILES`, strips
  frontmatter, then runs `vale --ignore-syntax`.

- Observation: the reusable package cannot currently discover or configure MDX
  at all.
  Evidence: `house-style-system/scripts/style_gate.sh` discovers only `*.md`,
  and `.vale.ini` plus all optional configurations use `[*.md]`.

## Decision Log

- Decision: use Vale's native MDX path through a locally pinned `mdx2vast`
  dependency instead of relying on `--ignore-syntax`.
  Rationale: native parsing excludes code, JSX expressions, component syntax,
  imports, and exports from prose checks. This reduces false positives and
  makes the validation contract match MDX as it is actually authored.
  Date/Author: 2026-07-09 / Codex, approved direction from Kalen Howell Sr.

- Decision: add `mdx2vast@0.3.1` as an exact development dependency in each
  repository that runs the native MDX lint path.
  Rationale: the current package exposes the `mdx2vast` binary and requires
  Node 18 or later. A local, lockfile-backed dependency is reproducible and
  avoids relying on a global install.
  Date/Author: 2026-07-09 / Codex.

- Decision: do not add a new command adapter.
  Rationale: `/architecture-review` was considered for the design review, but
  `context-first-engineering`, this ExecPlan, and Safe Lane Review already own
  the needed planning and validation behavior. A new adapter would duplicate
  the active workflow without creating an operational benefit.
  Date/Author: 2026-07-09 / Codex.

- Decision: ChatGPT Projects receive a reader-oriented Markdown companion when
  an MDX source contains components that matter to the authoring system.
  Rationale: ChatGPT is useful for editorial context, but its official file
  documentation names Markdown among text formats and does not promise MDX
  parsing. Local build and lint tooling remain authoritative for MDX syntax.
  Date/Author: 2026-07-09 / Codex.

## Outcomes & Retrospective

Not started. On completion, record the commits, local and Mac Studio validation
evidence, installed-skill parity, and any MDX syntax cases that needed a fixture
or a narrow exception.

## Context and Orientation

### Intake Brief

Goal: make the reusable House Style System, its Codex and Claude skills, its
ChatGPT package, and the `kalensr.com` writing integration dependable for MDX
files.

Work type: mixed code, tests, skills, and documentation.

Scope:

- `/Users/kalenhowellsr/Projects/house-style-system` is the canonical reusable
  package and owns Vale rules, wrappers, fixtures, evals, source skills, and
  ChatGPT guidance.
- `/Users/kalenhowellsr/Projects/kalensr.com` is the downstream public-writing
  integration and owns the writing build, production style gate, and MDX
  rendering behavior.
- `/Users/kalenhowellsr/.codex/skills/house-style-system` is an installed copy,
  not the source of truth. Refresh it only after the canonical source passes.

Source of truth, in order:

1. Vale MDX documentation and the installed local tool behavior.
2. The canonical `house-style-system` repository.
3. The `kalensr.com` writing build and its tests.
4. Installed skill copies and ChatGPT Project packaging.

Deliverable: a tested implementation in both repositories, aligned skill and
ChatGPT guidance, a verified local installation, and host-parity evidence.

Recommended lane: Build path, full orchestration, Safe Lane Intake plus Safe
Lane Review. Do not fan out writes because the canonical package must land
before the downstream integration adopts it.

Risks and unknowns:

- Native Vale MDX behavior must be verified against the project's YAML
  frontmatter and MDX component conventions before the fallback is removed.
- The package currently has no Node manifest. Adding a small manifest and
  lockfile is a deliberate reproducibility change and must remain scoped to
  `mdx2vast`.
- ChatGPT's file documentation does not provide an MDX parsing guarantee.
- Mac Studio parity is required before claiming the installed runtime is fully
  updated.

### Six-Lens Orientation

Product and business: writers need one dependable quality contract whether a
piece is plain Markdown or uses MDX components. The distinction should not
change the public-writing standard.

Users and workflows: Codex edits source files and can run local commands;
ChatGPT supplies editorial help from project instructions and source files;
authors need clear feedback that distinguishes prose, components, and rendered
output.

System and architecture: Vale is the deterministic prose engine. `mdx2vast`
is a parser dependency placed before Vale in `PATH`. Existing MDX compilation
in `kalensr.com` remains the render authority.

Data and integrations: no external data, credentials, or production services
change. The only external dependency is the public npm package `mdx2vast`.

Quality and operations: fixtures must prove frontmatter is ignored, reader
prose is checked, MDX component syntax is safe, all optional layers accept MDX,
and missing dependencies fail with a useful message. Host-parity validation
must refresh installed skills only after local and remote checks pass.

Delivery and risk: implement canonical package first, then downstream site.
Keep commits repository-local and reversible. Do not publish website content or
change writing statuses as part of this work.

## Technical Design and Specification

### Required behavior

1. The default style gate and every optional review wrapper accept explicit
   `.mdx` paths.
2. Default discovery includes `.mdx` alongside `.md` where the repository
   discovers author-facing prose.
3. YAML frontmatter does not produce prose alerts.
4. Native Vale MDX parsing is the release-grade path. The script must prepend
   its local `node_modules/.bin` to `PATH` before invoking Vale, so Vale can
   find the locally pinned `mdx2vast` executable.
5. If an MDX file is requested and `mdx2vast` is unavailable, the gate exits
   nonzero with an actionable message: run `npm ci` in the repository. It must
   not silently downgrade a production check to `--ignore-syntax`.
6. Markdown-only runs continue to work without Node dependencies.
7. MDX-specific fixtures cover clean prose, a known HouseStyle failure, YAML
   frontmatter, code fences, inline code, JSX components, JSX expressions, and
   ESM lines. The tests only assert behavior that Vale documents and that the
   local runtime demonstrates.
8. The existing four optional layers continue to use one selected layer at a
   time; no mixed-layer behavior is introduced.
9. `kalensr.com` retains its MDX compilation and render tests. Its style gate
   moves from `--ignore-syntax` to native Vale MDX parsing and reports missing
   parser dependencies clearly.
10. ChatGPT Project materials state that Markdown reader companions are the
    portable editorial source for MDX entries. They must preserve the author's
    actual prose and identify omitted component semantics rather than inventing
    a flattened version.

### Non-goals

- Do not create a new AI authorship detector or change existing rule logic.
- Do not make ChatGPT a substitute for repository lint, build, or rendering.
- Do not change publication statuses, generated site output, or deployment
  configuration.
- Do not add a global npm dependency or require a new command adapter.
- Do not broaden MDX components beyond the host repository's existing build
  contract.

### Interfaces and dependencies

Canonical package:

- Add a minimal `package.json` with `private: true`, Node `>=18`, exact
  `mdx2vast@0.3.1` development dependency, `test:style` for
  `./scripts/test-style-gate.sh`, and `test:evals` for the four existing eval
  scripts.
- Commit the resulting `package-lock.json`.
- Update `scripts/style_gate.sh` to detect MDX input, expose
  `node_modules/.bin` to Vale, and fail clearly if the parser is absent.
- Update `.vale.ini`, `.vale-kalen.ini`, `.vale-ai-voice.ini`,
  `.vale-center-of-gravity.ini`, and `.vale-dramatic-punctuation.ini` to match
  both `.md` and `.mdx`.

Downstream site:

- Add the same exact development dependency and lockfile update to
  `kalensr.com/package.json`.
- Preserve the existing frontmatter sanitizer in `kalensr.com/scripts/style_gate.sh`.
- Replace only the `vale --ignore-syntax` MDX invocation with native Vale.
- Add `tests/style-gate.test.mjs` to the existing Node test suite. It must
  exercise an actual `.mdx` source and the missing-dependency failure path
  without requiring a global install.

## Plan of Work

### Phase 1: Canonical MDX Contract

Milestone: `house-style-system` can lint MDX natively and its test fixture
suite proves the parser path.

1. Create the Node dependency manifest and lockfile.
2. Update all five Vale configuration globs for `.mdx`.
3. Update the gate to discover `.mdx`, locate the local parser dependency, and
   preserve Markdown-only behavior.
4. Add `docs/test-fixtures/style-gate/mdx/pass-mdx-components.mdx`,
   `docs/test-fixtures/style-gate/mdx/pass-mdx-frontmatter-and-code.mdx`, and
   `docs/test-fixtures/style-gate/mdx/fail-mdx-prose-em-dash.mdx`. Add their
   assertions to `scripts/test-style-gate.sh`.
5. Extend the evaluator scripts only where a fixture proves a specific optional
   layer's MDX behavior. Do not duplicate their existing Markdown controls.

### Phase 2: Downstream Site Adoption

Milestone: `kalensr.com` uses the native parser while its writing build still
renders MDX components correctly.

1. Add the exact dependency and lockfile update.
2. Replace the plain-text MDX invocation in `scripts/style_gate.sh`.
3. Add a focused test for frontmatter sanitation and native MDX style checking.
4. Run the full writing validation and inspect the existing MDX article in a
   local preview or rendered output.

### Phase 3: Guidance And ChatGPT Packaging

Milestone: agents understand how to handle MDX and ChatGPT uses a dependable
reader-facing source.

1. Replace the current "MDX may be skipped" wording in the canonical README,
   Codex skill, Claude skill, and Codex handoff with the native MDX contract.
2. Update the ChatGPT Project README, project instructions, and launch prompts
   to ask for a Markdown reader companion when an MDX component is not useful
   to editorial review.
3. Add a compact template or documented fields for the companion: source path,
   prose body, component placeholders, and editorial constraints.
4. Refresh the installed Codex skill from the canonical source after all tests
   pass. Do not hand-edit the installed copy.

### Phase 4: Review, Rollout, And Closeout

Milestone: both repositories are clean, commits are pushed, local installation
matches source, and Mac Studio evidence is captured.

1. Perform Safe Lane Review for correctness, completeness, source fidelity,
   regression risk, and documentation alignment.
2. Commit and push `house-style-system` first.
3. Commit and push `kalensr.com` second, keeping the six existing draft
   rewrites as a separate, intentional commit if they remain in the worktree.
4. On Mac Studio, pull the canonical package fast-forward only, run its
   validation suite, and copy the validated Codex skill into the installed
   skill location. Record commit equality and validation output in a concise
   evidence note.

## Concrete Steps

### Phase 1 commands

From `/Users/kalenhowellsr/Projects/house-style-system`:

    # Create the minimal package.json described in Interfaces and Dependencies.
    npm install --save-dev --save-exact mdx2vast@0.3.1
    ./scripts/test-style-gate.sh
    ./scripts/eval-kalen-voice.sh
    ./scripts/eval-ai-voice.sh
    ./scripts/eval-center-of-gravity.sh
    ./scripts/eval-dramatic-punctuation.sh

Expected result: the fixture suite and all four evals pass. A direct native
Vale run against an MDX fixture completes without `mdx2vast not found`.

### Phase 2 commands

From `/Users/kalenhowellsr/Projects/kalensr.com`:

    npm install --save-dev --save-exact mdx2vast@0.3.1
    ./scripts/style_gate.sh content/writing/articles/what-structured-writing-needs-from-ai-systems.mdx
    npm test
    npm run check:writing

Expected result: the MDX source passes the native style gate, the existing MDX
render test passes, and the full writing check finds no draft or candidate
leaks in production output.

### Phase 3 commands

From `/Users/kalenhowellsr/Projects/house-style-system`:

    diff -q codex-skills/house-style-system/SKILL.md /Users/kalenhowellsr/.codex/skills/house-style-system/SKILL.md

Expected result: after the documented copy step, the installed skill matches
the canonical source exactly.

### Phase 4 commands

From each affected repository:

    git diff --check
    git status --short --branch
    git add <reviewed paths>
    git commit -m "feat: add native MDX style checks"
    git push origin main
    git rev-parse HEAD
    git rev-parse origin/main

Expected result: each repository is clean, `HEAD` equals `origin/main`, and no
unrelated files were staged.

## Validation and Acceptance

### Automated validation

Canonical package must pass:

- `./scripts/test-style-gate.sh`
- `./scripts/eval-kalen-voice.sh`
- `./scripts/eval-ai-voice.sh`
- `./scripts/eval-center-of-gravity.sh`
- `./scripts/eval-dramatic-punctuation.sh`
- native Vale checks for every MDX fixture under the default layer and each
  applicable optional layer
- `git diff --check`

`kalensr.com` must pass:

- targeted native style checks for its actual MDX article
- `npm test`
- `npm run check:writing`
- a local MDX render inspection confirming that built-in components render and
  raw `<Component>` syntax does not appear in output
- `git diff --check`

### Manual acceptance checks

- A JSX component prop containing non-prose text does not create a prose alert.
- A prose sentence outside the component still triggers the expected rule in a
  fail fixture.
- YAML frontmatter fields and image paths do not create alerts.
- A missing local parser dependency emits the documented actionable failure.
- Codex guidance tells agents to run native MDX checks and a host build.
- ChatGPT guidance tells users when a Markdown companion is needed and does not
  represent ChatGPT as an MDX validator.

### Definition of Done

- [ ] Every Vale configuration recognizes `.mdx`.
- [ ] The style gate finds a local `mdx2vast` binary through the repository's
  pinned dependency.
- [ ] MDX cannot silently fall back to plain-text linting in release-grade
  validation.
- [ ] Fixtures prove parser behavior and all existing Markdown tests remain
  green.
- [ ] `kalensr.com` has removed its `--ignore-syntax` MDX path and passes its
  writing build and test suite.
- [ ] Codex, Claude, and ChatGPT guidance agree on the MDX workflow.
- [ ] The installed Codex skill equals the canonical source after refresh.
- [ ] Each affected repository has a focused commit, pushed `main`, and
  matching local and remote heads.
- [ ] Mac Studio parity evidence is captured after its validation succeeds.

## Idempotence and Recovery

- `npm ci` is the normal retry path after lockfiles are committed. Do not use a
  global `npm install -g mdx2vast` as a repair.
- If native MDX parsing fails, retain the current branch, capture the parser
  error, and add a minimal fixture before changing rule logic.
- If `mdx2vast` cannot parse a supported host file, do not reintroduce silent
  `--ignore-syntax` behavior. Stop and decide whether to narrow the host MDX
  contract or add a documented explicit non-release fallback.
- If a documentation update changes agent behavior incorrectly, revert only the
  affected documentation commit or restore the prior source skill, then refresh
  the installed copy from the restored canonical source.
- If Mac Studio validation fails, do not copy the local skill to that host. Fix
  or document the host dependency first, then repeat the fast-forward-only
  rollout.

## Artifacts and Notes

- Canonical implementation home:
  `/Users/kalenhowellsr/Projects/house-style-system`.
- Downstream integration home:
  `/Users/kalenhowellsr/Projects/kalensr.com`.
- Existing MDX integration sample:
  `content/writing/articles/what-structured-writing-needs-from-ai-systems.mdx`.
- Current direct Vale failure is expected until Phase 1 installs the local
  parser dependency: `mdx2vast not found`.
- No command-adapter artifact is required. The `/architecture-review` route was
  considered and declined because it overlaps the selected execution workflow.

## Interfaces and Dependencies

- Vale 3.13.1 is installed locally.
- `mdx2vast@0.3.1` currently exposes the `mdx2vast` command and declares Node
  `>=18`.
- Local Node is v24.5.0 and npm is v11.7.0.
- `kalensr.com` uses `@mdx-js/mdx` to compile MDX during its writing build;
  that rendering path is separate from Vale's prose parsing and remains a
  required integration check.
- The downstream site currently has six unrelated, uncommitted writing-draft
  rewrites. Preserve them and commit them separately from the MDX integration
  change unless Kalen explicitly directs otherwise.
