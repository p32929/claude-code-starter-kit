---
description: Review the current changes for real defects before they ship
argument-hint: "[optional: file or directory to focus on]"
allowed-tools: Bash(git:*), Read, Grep, Glob
---

Changes under review:
!`git diff --stat HEAD`

!`git diff HEAD`

Focus area if I gave one: $ARGUMENTS

## Your task

Use the **code-reviewer** subagent on this diff.

Then do the one thing reviewers always skip: **for every function whose signature, return shape, or thrown error changed, grep the whole repo for its other callers and check each one was updated.** Report any that were not. This is where the real bugs hide.

Report only findings with a concrete failure case. If there are none, say `No blocking findings` and stop — do not pad the list.
