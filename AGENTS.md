# Agent Instructions

## Purpose

This public repository owns the reusable House Style System. Its public surface
includes written guidance and Vale rules. It also includes synthetic fixtures,
evals, and optional assistant integrations.

## Source Priority

1. `HOUSE_STYLE.md` for the public writing standard.
2. `README.md` for reader workflow and release validation.
3. `styles/` and `.vale*.ini` for deterministic rule behavior.
4. `scripts/` for validation and review entry points.
5. `docs/` for examples, customization, research, and integration guidance.

## Public Safety

- Keep private drafts, journals, corpora, client material, employer material,
  host details, credentials, and local paths out of the repository.
- Use synthetic-from-scratch examples and fixtures.
- Keep the public `KalenVoice` layer thin, opt-in, and free of private source
  excerpts or phrase provenance.
- Keep full personal Project instructions, phrase provenance, and ongoing
  calibration in a private profile source.
- Treat every style signal as a review prompt, never proof of authorship.

## Workflow

- Use a feature branch for changes and merge through a reviewed pull request.
- Do not merge or push a branch created from repository history that predates
  the Phase 6 public-history rewrite.
- Keep changes focused. Update fixtures and evals when deterministic behavior
  changes.
- Do not add runtime services, model dependencies, or network calls without an
  approved design and release review.

## Validation

Before requesting review or release, run:

```sh
./scripts/style_gate.sh
./scripts/test-style-gate.sh
./scripts/eval-kalen-voice.sh
./scripts/eval-ai-voice.sh
./scripts/eval-center-of-gravity.sh
./scripts/eval-dramatic-punctuation.sh
./scripts/check-public-tree.sh
./scripts/check-public-history.sh
git diff --check
```

The default style gate must report zero errors, warnings, and suggestions.
Document any format that Vale does not inspect and run the host repository's
build or rendered-output validation for that format.

## Release Boundary

- Run the approved external public scrub and a clean-clone validation before a
  tag or release.
- Verify the default branch and remote commit match.
- Do not change repository visibility, publish a tag, or create a release
  without owner approval.
