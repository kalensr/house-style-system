# Center Of Gravity Eval

These fixtures test whether the House Style System catches sentences that make
AI, agents, abstract work, or nominalized actions the grammatical center when
the real topic is people, teams, decisions, and operating change.

Run:

```sh
./scripts/eval-center-of-gravity.sh
./scripts/review-center-of-gravity.sh docs/test-fixtures/style-gate/fail-cog-ai-protagonist.md
```

## Levels

Level 1 is automated now. It catches sentence-level surface signals:

- AI or agents as the protagonist when the human workflow is the real topic.
- Empty work nouns such as `the work` carrying human action.
- Nominalized human actions such as `adoption requires` or `alignment drives`.

Level 2 is paragraph review. The reviewer asks what entity controls the
paragraph: a person, team, organization, decision, customer, or workflow should
usually carry the action.

Level 3 is topic review. Across the whole draft, the main subject should match
the real topic under discussion. AI, agents, platforms, and systems can be
tools or constraints, but they should not silently become the protagonist when
the piece is about people adapting, deciding, reviewing, or owning work.

Level 4 is future automation. The next stronger eval should count recurring
entities and their syntactic roles across a draft, then flag entity drift when
AI, agents, or abstract nouns dominate subject position while people disappear.

Passing this eval means the deterministic checks behaved on these fixtures. It
does not prove a draft has the right protagonist, audience fit, or evidence.
Human review still owns judgment.
