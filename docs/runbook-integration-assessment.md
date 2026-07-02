# Runbook Integration Assessment

Date: 2026-07-02

Purpose: assess how well the repo's house style and voice rules system covers
the patterns in [AI Voice Avoidance Runbook](chatgpt-project/ai-voice-avoidance-runbook.md).

Status: this file records the assessment that drove the 2026-07-02
implementation plan. The implementation work now lives in
[AI Voice Implementation Plan](plans/2026-07-02-ai-voice-implementation.md).

## Headline Finding

The runbook is one of the sharpest source documents in the repo. Before this
implementation run, its guidance lived mostly outside the deterministic review
system. ChatGPT could use it as source material, but the local style gate did
not catch most of the same patterns.

The main concept gap was simple: the system should not only imitate Kalen's
voice. It should also remove the default AI business voice.

## Pre-Implementation Coverage Map

| Runbook pattern | Earlier coverage | Verdict |
| --- | --- | --- |
| Generic role-fit framing | No deterministic rule | Gap |
| Abstract business-need clauses | Partial fixed-phrase coverage | Gap |
| Pattern-recognition openings | No direct rule | Gap |
| Flattened before-state labels | No direct rule | Gap |
| Vague consequence phrases | No direct rule | Gap |
| Coordinated abstraction | Partial fixed-phrase coverage | Gap |
| Empty work nouns | Contrast formula caught part of it | Partial |
| Contrast formulas | Existing rules | Covered |

## Assessment

The runbook's method is form-based and should stay that way. It does not decide
which role Kalen should target or what claim he should make. It checks whether a
sentence hides real work behind abstract language.

The stable form problems are:

- role-fit framing,
- abstract business-need clauses,
- broad pattern announcements,
- flattened before-state labels,
- vague consequence phrases,
- coordinated abstraction,
- empty work nouns.

Those patterns are good candidates for an optional review layer. They should
stay at `suggestion` level because a human must decide whether the abstraction
is earned by surrounding detail.

## Implementation Direction

The best architecture is a separate `AIVoice` Vale layer:

- `HouseStyle` stays the general quality layer.
- `KalenVoice` stays the voice-preservation layer.
- `AIVoice` catches generated business and recruiter voice patterns.

The implementation should include:

- `.vale-ai-voice.ini`,
- `scripts/review-ai-voice.sh`,
- `scripts/eval-ai-voice.sh`,
- fail fixtures for every deterministic rule,
- near-miss controls for grounded wording,
- updates to `HOUSE_STYLE.md`, `docs/domain-modes.md`, ChatGPT Project docs,
  and the optional Codex skill.

## Boundary

These checks do not detect authorship. They are review prompts for clarity,
specificity, and voice fit. Human review still owns truth and evidence. It also
owns judgment, reader fit, and final approval.
