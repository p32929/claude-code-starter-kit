# Claude Code Starter Kit (Lite)

**Working `.claude/` files you can drop into any repo right now.** Not a tutorial, not a
PDF — the actual subagents, slash commands and hooks, already written and already tested.

```bash
git clone https://github.com/p32929/claude-code-starter-kit.git
cd your-project
bash /path/to/claude-code-starter-kit/install.sh
```

Then **restart Claude Code** (hooks are only read at startup) and type `/`.

Install into `~/.claude` instead, and it works in every project you ever open:

```bash
bash install.sh --global
```

---

## What you get

### 3 subagents

| Agent | What it does |
|---|---|
| **bug-hunter** | Finds the **root cause**, not the symptom. Reproduces first, traces the bad value back to where it *first* went wrong, and greps every caller before proposing a fix. |
| **code-reviewer** | Real defects only — no style opinions. Every finding needs a concrete failure case or it gets deleted. Catches the callers you forgot to update when a signature changed. |
| **test-writer** | Reads your existing tests first and matches your framework and style. Never introduces a new test library. Runs the suite and pastes the real output. |

### 3 slash commands

| Command | What it does |
|---|---|
| **`/commit`** | Reads the real diff (not just the file list), writes a message matching your repo's existing style, and refuses to commit a secret. Splits the commit if the diff does two unrelated things. |
| **`/review`** | Reviews the diff, then does the check reviewers always skip: greps for every caller of every changed signature and verifies each was updated. |
| **`/onboard`** | Maps a repo you have never seen — stack, the exact commands, the 5 files that matter, and the landmines. Every claim cites a `file:line`. |

### 2 guard hooks

Hooks are the only part of Claude Code that can **stop** it doing something, rather than
asking it nicely in CLAUDE.md.

- **`guard-secrets`** — refuses to read, write or `cat` `.env`, `.env.production`, `id_rsa`,
  `*.pem`, `.aws/credentials`, `.npmrc`, `.netrc`, `secrets.yaml`…
- **`guard-destructive`** — blocks `rm -rf /`, `rm -rf ~`, `git reset --hard`,
  `git clean -fd`, force-push to `main`, `DROP TABLE`, `DELETE` with no `WHERE`,
  `terraform destroy`, `dd if=… of=/dev/…`, fork bombs.

Both are plain commented bash. No dependencies beyond `python3`. No network calls.
**Read them before you install them** — that goes for anyone's hooks, including these.

Verify they work:

```bash
echo '{"tool_input":{"command":"rm -rf /"}}' | .claude/hooks/guard-destructive.sh; echo "exit=$?"
# → exit=2, and a BLOCKED message explaining what to do instead

echo '{"tool_input":{"command":"ls"}}' | .claude/hooks/guard-destructive.sh; echo "exit=$?"
# → exit=0, silence
```

### Plus

- **`CHEATSHEET.md`** — one page on the four extension points (CLAUDE.md / commands /
  subagents / skills / hooks): which to use when, the exact frontmatter for each, every hook
  event and what exit code 2 does, precedence rules, and the gotchas. Worth reading even if
  you install nothing.
- **`claude-md/00-universal.md`** — a `CLAUDE.md` template with the sections that actually
  earn their place, especially the commands table and the Gotchas list.

---

## Why bother

Three things in here pay for themselves immediately:

1. **A commands table in `CLAUDE.md`.** Without a "test one file" command, Claude runs your
   whole suite on every iteration. That is minutes per loop, every loop.
2. **`guard-destructive`.** You only need it to fire once.
3. **`/onboard`.** The fastest way into a codebase you did not write.

## Requirements

Claude Code, `bash`, `git`, and `python3` (already on every Mac and Linux machine).
Windows works under WSL.

## Uninstall

```bash
rm -rf .claude/agents .claude/commands .claude/hooks
```
…and remove the `hooks` block from `.claude/settings.json`.

---

## The full kit

This repo is the free subset. The complete **Claude Code Drop-In Kit** is **39 files**:

- **10 subagents** — the 3 above plus `refactorer`, `api-designer`, `sql-tuner`,
  `perf-profiler`, `dependency-auditor`, `migration-planner`, `docs-writer`
- **12 slash commands** — plus `/pr`, `/debug`, `/fix-ci`, `/tests`, `/security`,
  `/cleanup`, `/explain`, `/scaffold`, `/changelog`
- **7 hooks** — plus `typecheck-on-edit` (runs `tsc --noEmit` / `mypy` / `go build` /
  `cargo check` after every edit and **feeds the errors straight back to Claude so it fixes
  them in the same turn** — the single highest-value file in the pack), `format-on-edit`
  (10 languages), `protect-main`, `log-session`, `notify-done`
- **4 skills** — `ship-it` (full pre-merge gate), `incident-triage` (prod is down right
  now), `spec-to-plan`, `legacy-rescue` (characterisation tests before touching untested
  legacy code)
- **6 CLAUDE.md templates** — universal, Next.js + TypeScript, Python + FastAPI, Node API,
  Flutter, monorepo — each with a real Gotchas section

**→ [Get the full kit](https://p32929.gumroad.com/l/ccdk)** — $49 one-time, one developer,
unlimited projects, personal and commercial. No subscription, no seat count, no expiry.

## Licence

The files in **this repo** are MIT — use them however you like.
The full kit is sold under a single-developer licence (use anywhere, do not redistribute).

Built by [@p32929](https://github.com/p32929).

## Contributing

Contributions are warmly welcomed and greatly appreciated! Whether it's a bug fix, new feature, or improvement, your input helps make this project better for everyone.

Before submitting a pull request, please:

1. Create an issue describing the feature or bug fix you'd like to work on
2. Wait for discussion and approval to ensure alignment with project goals
3. Fork the repository and create your feature branch
4. Submit your pull request with a clear description of changes

This approach helps avoid duplicate efforts and ensures smooth collaboration. Thank you for considering contributing!

## Share

[![facebook](https://user-images.githubusercontent.com/6418354/179013321-ac1d1452-0689-493f-9066-940cf2302b6e.png)](https://www.facebook.com/sharer/sharer.php?u=https://github.com/p32929/claude-code-starter-kit)
[![twitter](https://user-images.githubusercontent.com/6418354/179013351-7d8d6d1c-4ce2-46ab-bef8-4c4765a1b888.png)](https://twitter.com/intent/tweet?url=https://github.com/p32929/claude-code-starter-kit)
[![reddit](https://user-images.githubusercontent.com/6418354/179013338-7416ae3f-73ba-4522-86e1-1374d7082d22.png)](https://www.reddit.com/submit?url=https://github.com/p32929/claude-code-starter-kit)
[![linkedin](https://user-images.githubusercontent.com/6418354/179013327-ca7b7102-1da8-4b1c-858f-1a6e5f21bd70.png)](https://www.linkedin.com/shareArticle?mini=true&url=https://github.com/p32929/claude-code-starter-kit)
[![pocket](https://user-images.githubusercontent.com/6418354/179013334-b095c45f-becf-49f4-9ee1-5a731a9b1f85.png)](https://getpocket.com/save?url=https://github.com/p32929/claude-code-starter-kit)
[![tumblr](https://user-images.githubusercontent.com/6418354/179013343-3111f55a-3b90-40c7-8487-9777348672b0.png)](https://www.tumblr.com/share?v=3&u=https://github.com/p32929/claude-code-starter-kit)

## Support

If this saved you an afternoon, a coffee goes a long way.

[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20me%20a%20coffee-%E2%98%95-FFDD00?style=for-the-badge&logo=buymeacoffee&logoColor=black)](https://www.buymeacoffee.com/p32929)
