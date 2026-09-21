# Claude Code — one-page cheatsheet

## The four extension points, and when to use which

| | Lives in | Claude chooses it? | Can it block? | Use it for |
|---|---|---|---|---|
| **CLAUDE.md** | repo root | always loaded | no | facts about *this* repo |
| **Slash command** | `.claude/commands/x.md` | no — you type `/x` | no | a task you run on demand |
| **Subagent** | `.claude/agents/x.md` | yes, by description | no | a specialist with its own context window |
| **Skill** | `.claude/skills/x/SKILL.md` | yes, by description | no | a multi-step procedure |
| **Hook** | `.claude/settings.json` | no — always fires | **yes** | enforcing a rule |

**The rule of thumb:** a preference goes in CLAUDE.md. Something that must *never* happen
goes in a hook — CLAUDE.md is advice, a hook is a wall.

## Frontmatter

Slash command:
```markdown
---
description: shown in the / menu
argument-hint: "<what to pass>"
allowed-tools: Bash(git:*), Read, Grep
---
Body. $ARGUMENTS = everything passed. $1 $2 = positional.
!`shell command`  ← runs and injects output before the prompt
@path/to/file     ← inlines that file
```

Subagent:
```markdown
---
name: my-agent
description: WHEN to use this. Claude routes on this line — be specific.
tools: Read, Grep, Glob, Bash       # omit to inherit everything
model: sonnet                        # optional
---
System prompt for the subagent.
```

Skill:
```markdown
---
name: my-skill
description: Trigger words and situations. Claude loads it when these match.
---
The procedure.
```

## Hook events

| Event | Fires | Exit 2 does |
|---|---|---|
| `PreToolUse` | before a tool runs | **blocks it**; stderr goes to Claude |
| `PostToolUse` | after a tool runs | feeds stderr back to Claude |
| `UserPromptSubmit` | you hit enter | blocks the prompt |
| `Stop` | Claude finishes | asks it to continue |
| `SubagentStop` | a subagent finishes | same |
| `Notification` | Claude needs you | — |
| `SessionStart` | session begins | — |
| `PreCompact` | before compaction | — |

Hook input arrives as JSON on **stdin**: `tool_name`, `tool_input`, `tool_response`, `cwd`,
`session_id`, `hook_event_name`. Exit 0 = allow, 2 = block, anything else = non-blocking error.

`$CLAUDE_PROJECT_DIR` is available inside hook commands — use it so paths work from any cwd.

## Precedence

```
enterprise policy  >  ./.claude/  (project)  >  ~/.claude/  (global)
```
Project beats global. A repo can always override your personal setup, and your teammates'
`.claude/` arrives with the repo.

## Things worth knowing

- **Subagents get a fresh context window.** That is the real reason to use one: a big search
  or a long review does not pollute your main conversation.
- **`!`shell`` in a command runs *before* the prompt is sent** — put `git diff` in the
  command and Claude never has to ask for it.
- **Nested CLAUDE.md files work.** `packages/api/CLAUDE.md` is loaded when Claude touches
  that directory. Keep the root one short and push specifics down.
- **CLAUDE.md is prepended to every prompt.** Long = expensive on every single turn. Under
  ~150 lines.
- **Claude trusts CLAUDE.md over the code.** A stale line in it is worse than no line at all.
- **`/clear` between unrelated tasks.** Stale context is the most common cause of a
  confidently wrong answer.
- **Hooks run with your full permissions, no confirmation.** Read any hook before installing
  it — including the ones in this kit.
- `claude --debug` shows every hook invocation and exit code when something silently is not
  firing.

## The Gotchas habit

The highest-value section of any CLAUDE.md is `## Gotchas`. Every time you correct Claude on
the same thing twice, that correction becomes a line there. Do that for a month and the file
is worth more than everything else in this kit put together.
