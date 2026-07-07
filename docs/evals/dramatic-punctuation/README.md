# No Dramatic Punctuation Eval

This eval covers short lines that act like dramatic punctuation instead of
carrying a complete thought.

## What It Checks

The opt-in `DramaticPunctuation` layer checks three repeatable surface signals:

- vague pronoun punchlines such as `This matters.`
- abstract subject punchlines such as `The standard rises.`
- fragment emphasis such as `No shortcuts.`

These are not grammar errors in every context. They are house-style risks for
public writing, leadership reflection, social posts, blog drafts, and personal
positioning work when the short line does not name the actor, action, standard,
mechanism, or consequence.

## Eval Levels

Level 1 catches exact high-risk punchline patterns.

Level 2 checks near misses that should stay clean when they name a concrete
boundary, reviewer, source, or action.

Level 3 remains a human review task: scan the paragraph and topic to decide
whether the line is doing meaning work or only creating rhythm.

Run:

```sh
./scripts/eval-dramatic-punctuation.sh
```
