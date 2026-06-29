# Kalen Voice Evals

These fixtures test the public-safe Kalen voice rules without committing private source passages.

The positive control is synthetic leadership reflection. It includes a concrete decision, a visible question, a principle, and a next step.

The negative control is synthetic generic executive prose. It should trigger the
Kalen voice rules for generic openings and abstract openings. It should also
trigger unsupported group claims, future-state language without a path, and
generic executive tone.

Run:

```sh
./scripts/eval-kalen-voice.sh
./scripts/review-kalen-voice.sh docs/evals/kalen-voice/positive-leadership-reflection.md
```

Passing this eval means the deterministic checks behaved on these fixtures. It does not prove a draft is true, useful, or fully in Kalen's voice. Human review still owns evidence, judgment, audience fit, and final approval.
