# AI Voice Evals

These fixtures test the opt-in AI voice avoidance rules without treating style
as proof of authorship.

Run:

```sh
./scripts/eval-ai-voice.sh
./scripts/review-ai-voice.sh docs/test-fixtures/style-gate/fail-ai-role-fit-framing.md
```

Passing this eval means the deterministic checks catch the approved bracketed
patterns and skip the near-miss controls. Human review still owns truth,
evidence, judgment, and final approval.
