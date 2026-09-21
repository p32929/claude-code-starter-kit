---
description: Stage and commit the current changes with a message derived from the actual diff
argument-hint: "[optional extra context]"
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git add:*), Bash(git commit:*), Bash(git log:*)
---

Current status:
!`git status --short`

Staged diff:
!`git diff --cached --stat`

Unstaged diff:
!`git diff --stat`

Recent commit messages (match this style exactly):
!`git log --oneline -15`

Extra context from me: $ARGUMENTS

## Your task

1. Read the FULL diff (`git diff` and `git diff --cached`) — not just the stat. The message must describe what the change does, which you can only know by reading it.
2. If nothing is staged, stage the files that belong to this logical change. **Never `git add -A` blindly** — check for stray files, build output, `.env`, large binaries, and leave them out.
3. **If the diff contains two unrelated changes, say so and make two commits.**
4. Write the message in the style of the log above (conventional commits or not — copy what is there).
   - Subject: imperative, under 72 chars, no trailing period.
   - Body only if the *why* is not obvious from the subject. Explain why, never what — the diff already says what.
5. Commit. Do not push.
6. Report the short hash and subject line.

Never commit a secret, an API key, or a credential. If you see one in the diff, stop and tell me instead of committing.
