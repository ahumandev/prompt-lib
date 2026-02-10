---
description: Resolve Git merge conflicts.
---

# STEP 1: FIND CONFLICTS

- Scan the project for merge conflicts using Git.
- Git Conflict Markers: <<<<<<<, =======, >>>>>>>
- Create a plan that would address every merge conflict found

# STEP 2: RESOLVE CONFLICTS

- Never skip planned steps.
- Continue until the plan is complete and every step was attended.

## RESOLVING MERGE CONFLICTS

For each merge conflict, strictly adhere to these rules:

- Deduplicate imports and declarations.
- Avoid double‑execution.
- Prefer additive merges and avoid dropping validation, error handling, or logging.
- Keep style consistent with surrounding code.
- If both sides rename symbols, normalize to one name and update references in the snippet.
- If the same API is renamed differently, pick one name and normalize.
- Keep style consistent with surrounding context when provided.
- Never include Git Conflict Markers in the output.

Any other merge conflict should be questioned by asking a question to the user:
- Briefly in < 40 words explain the difference between each version including the benefit and consequence of each version.
- In the question provide a short 1-4 word name for each version to make it clear which name is which version
- Question the user which version to keep
- Add answer options should describe the effect the selection will have on the code and behaviour of the application
- Add 1 answer options for each merge side - name the side and the effect it will have on the code and app behaviour
- Add 1 answer option for keeping both - suggest how you will manage to keep both sides without breaking compilation
- Add 1 answer option to enable the user to type an alternative approach

Precisely follow the user's instructions.
When done, update the plan that the step is complete and move on to the next step.

# STEP 3: VERIFY

When all steps are done:
- Ensure that the imports are correct after the merge - clean up unnecessary imports in the files that had merge conflicts
- Ensure that the code still compile after the merge
- Ensure all unit tests pass

For every test that fails:
  - Consider why the test failed: test faulty or previous git merged incorrect?
  - Fix problem according to consideration (source or test)
  - Rerun failing test: If still failing, repeat; If pass move on to the next test

# STEP 4: COMMIT

- Stage the changed files.
- Create a git commit message noting how and why detected git conflicts were resolved.
  - The commit message should exclude obvious notes like "staged resolved files"
