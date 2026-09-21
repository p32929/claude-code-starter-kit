---
description: Map an unfamiliar codebase — what it is, how it runs, where everything lives
allowed-tools: Read, Grep, Glob, Bash
---

!`git ls-files | head -100`
!`git log --oneline -5`

## Your task

I have never seen this repo. Give me the map I need before I can change anything safely.

Read the manifest, the entry point, the config, the CI workflow and the existing docs. **Prefer the code over the README** — READMEs are usually stale; say so if they disagree.

```
WHAT IT IS: <one sentence>
STACK: <language, framework, database, notable libraries, with versions from the manifest>

HOW TO RUN IT:
  install:  <exact command>
  dev:      <exact command>
  test:     <exact command>
  build:    <exact command>
  (taken from package.json scripts / Makefile / CI workflow — say where you got each)

REQUIRED CONFIG: <env vars and services it will not start without>

THE MAP:
  <dir> — <what lives here, one line each. Only real dirs.>

ENTRY POINTS: <where execution actually starts — file:line>

THE CORE: <the 3-5 files that matter most, and why. If I only read five files, these.>

CONVENTIONS: <how this team names things, handles errors, writes tests, structures modules>

LANDMINES: <anything surprising, fragile, or undocumented that would bite a newcomer>
```

Every claim cites a file. If something is unclear from the code, say `unclear` — do not invent it.
