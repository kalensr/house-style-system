# Client-Facing Artifact Eval

Use this small judgment eval when the client-facing method changes. The
examples are synthetic. They test whether a reviewer preserves source facts
while preferring an observable client outcome over an internal artifact list.

## Source

- A service owner approves releases.
- An operations lead opens the current release.
- The team must prove that a deleted test record can be restored.
- A role matrix and recovery record must capture the decisions.
- The provider remains undecided until the demonstration is complete.

## Candidate A

```text
Outcome: a role matrix, architecture decision, recovery record, demonstration
evidence, and provider recommendation.
```

## Candidate B

```text
The service owner approves a release, and the operations lead opens the same
current release. The team then deletes and restores a test record. The role
matrix and recovery record preserve the decisions made during the
demonstration. The provider remains undecided until the demonstration is
complete.
```

## Expected Review

Prefer Candidate B.

- **Factual preservation:** it keeps every source fact and preserves the open
  provider decision. Candidate A changes the open decision into a provider
  recommendation.
- **Client usefulness:** it shows who acts, what they do, and how the team
  verifies recovery.
- **Voice fit:** it uses direct operating language and keeps the artifacts in a
  supporting role.

Candidate B is not universally better because it is longer or more concrete.
It is better for this source and this client-facing purpose.
