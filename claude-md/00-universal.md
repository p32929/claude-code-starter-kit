# CLAUDE.md — universal base template

<!--
Copy to the root of your repo as CLAUDE.md. Fill in every < > placeholder.
Delete any section that does not apply — an inaccurate CLAUDE.md is worse than a short one,
because Claude trusts it over the code.

Keep it under ~150 lines. This file is prepended to every single prompt: long means expensive
and, past a point, ignored. If a rule only matters in one directory, put a CLAUDE.md in that
directory instead — Claude picks up nested ones automatically.
-->

# <Project name>

<One sentence: what this is and who uses it.>

## Commands

| Task | Command |
|---|---|
| install | `<cmd>` |
| dev | `<cmd>` |
| test | `<cmd>` |
| test one file | `<cmd> <path>` |
| typecheck | `<cmd>` |
| lint | `<cmd>` |
| build | `<cmd>` |

<!-- Test-one-file matters more than you think: without it Claude runs the whole suite
     on every change and burns minutes per iteration. -->

## Stack

<Language + version, framework + version, database, and any library whose conventions
matter. Versions, not just names — the API differs between majors.>

## Layout

```
src/<dir>/   <what lives here>
```
<Only real directories. Keep to the 5-8 that matter.>

## Conventions

- <How errors are handled — thrown? returned as a Result? a custom error class?>
- <How things are validated, and where>
- <Naming: files, components, functions, database columns>
- <How state / config / dependency injection works>
- <Import style: absolute aliases or relative?>

## Rules

- Do not add a dependency without asking.
- Match the patterns in existing files rather than introducing new ones.
- <Anything specific to this repo that a newcomer gets wrong>

## Gotchas

<!-- The highest-value section in the file. Every line here is a mistake that would
     otherwise be made repeatedly. Add to it every time you correct Claude on the same
     thing twice. -->

- <e.g. "The `legacy/` directory is dead; never edit it.">
- <e.g. "`db.query` does not escape identifiers — only ever interpolate constants.">
- <e.g. "Tests need Docker running: `make test-env` first.">

## Do not touch

<Generated files, vendored code, anything with an owner elsewhere.>
