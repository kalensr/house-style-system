# Spoken-Voice Rule Evals

This eval checks that every public rule and installed-skill source carries the
full spoken-voice rule set. It uses a cross-domain positive control to guard
ordinary technical, executive, and informal prose. A paired negative and
revised sample checks whether the rules remove high-confidence patterns while
preserving the operating point.

Run:

```sh
./scripts/eval-spoken-voice-rules.sh
```

Passing proves rule presence and clean positive controls. It also proves
targeted detection of the em dash, contrast, filler, jargon, and
dramatic-punctuation patterns. Human review still owns cadence, paragraph
structure, nominalization, spoken fit, factual preservation, and necessary
exceptions.
