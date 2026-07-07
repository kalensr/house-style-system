# No Dramatic Punctuation Eval Research

## Summary

`No Dramatic Punctuation` is the house-style name for a recognizable writing
risk. A short line uses rhythm, fragment form, or a vague subject to imply
importance. It does that without explaining who acts or what happens. It also
leaves out the standard, mechanism, or consequence.

The exact phrase is local to this system. The closest research and writing
terms are:

- staccato sentences,
- sentence fragments or minor sentences,
- sentence variety and emphasis,
- paragraph topic control,
- cohesion and coherence through sentence subjects,
- sentence-length distribution in human and AI-generated text.

## Findings

Writing guides treat short sentences as a legitimate emphasis tool, but they
also warn that repeated sentence length and pattern can become monotonous.
Purdue's writing guide frames sentence variety as a way to create rhythm and
emphasis. It also notes that short sentences can maximize crucial points. That
does not mean every short sentence is useful. In this house style, the short
line must carry a concrete point.

Purdue's sentence-fragment guidance gives the repair pattern. Fragments can
often be joined back to the main clause. Formal writing should avoid
journalistic fragment sentences used only for emphasis. This maps directly to
the house-style rewrite move: fold the punchline into the sentence that names
the actor and consequence.

Paragraph guidance points in the same direction. Indiana University's writing
guide says paragraphs need a controlling idea, and topic sentences help readers
identify the subject and perspective of the paragraph. The Naval Postgraduate
School writing center adds that topic sentences should connect the paragraph's
main idea to the larger argument. A short punchline is risky when it displaces
that work instead of doing it.

Montana State University's writing center makes the subject-position issue even
more explicit. It recommends finding the subjects or noun phrases of sentences,
checking whether those subjects refer to related ideas, and rewriting so actors
do the main actions. This supports both Center of Gravity review and No
Dramatic Punctuation review.

AI-writing research gives a separate reason to track rhythm. Studies and
surveys compare human and AI-generated writing through sentence length and
sentence structure. They also compare vocabulary variety, syntax, and
rhetorical style. These signals do not prove authorship, but they justify
measuring repeated sentence patterns as review prompts.

## Implementation Strategy

This repo uses a multi-pronged approach:

1. Rulebook: `HOUSE_STYLE.md` explains the human judgment rule.
2. Deterministic layer: `styles/DramaticPunctuation/` catches repeatable
   patterns.
3. Wrapper: `scripts/review-dramatic-punctuation.sh` makes the layer easy to
   run on a draft.
4. Eval: `scripts/eval-dramatic-punctuation.sh` checks failing fixtures and
   near misses.
5. Skill guidance tells Codex, Claude, and ChatGPT Project instructions when to
   apply the rule and when to rely on human review.

## Human Review Prompt

Before keeping a short line, ask:

- Does it name the actor and action?
- Does it explain the standard, mechanism, or consequence?
- Is it doing meaning work, or only adding rhythm?
- Would the same point be clearer if folded into the previous sentence?

## Sources

- [Purdue: Strategies for Variation](https://owl.purdue.edu/owl/general_writing/academic_writing/sentence_variety/index.html)
- [Purdue: Sentence Fragments](https://owl.purdue.edu/owl/general_writing/mechanics/sentence_fragments.html)
- [Indiana University: Paragraphs and Topic Sentences](https://wts.indiana.edu/writing-guides/paragraphs-and-topic-sentences.html)
- [Naval Postgraduate School: Body Paragraphs and Topic Sentences](https://nps.edu/web/gwc/body-paragraphs-and-topic-sentences)
- [Montana State University: Cohesion and Coherence](https://www.montana.edu/writingcenter/writing_resources/cohesioncoherence.html)
- [Springer: Contrasting Linguistic Patterns in Human and Large Language Model-Generated News Text](https://link.springer.com/article/10.1007/s10462-024-10903-2)
- [arXiv: Do large language models write like humans?](https://arxiv.org/html/2410.16107v1)
