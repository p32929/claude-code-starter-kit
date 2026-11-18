# Claude Code Starter Kit (Lite)

**Ready-made Claude Code subagents, slash commands and safety hooks you can drop into any repo right now.**

Most Claude Code guides tell you what you could set up. This kit is the setup itself: working, tested `.claude/` files, plus two guard hooks that actually stop Claude from reading your secrets or running a destructive command, instead of just asking it nicely.

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

1. **`guard-secrets`** — refuses to read, write or `cat` `.env`, `.env.production`, `id_rsa`,
   `*.pem`, `.aws/credentials`, `.npmrc`, `.netrc`, `secrets.yaml`…
2. **`guard-destructive`** — blocks `rm -rf /`, `rm -rf ~`, `git reset --hard`,
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

1. **`CHEATSHEET.md`** — one page on the four extension points (CLAUDE.md / commands /
   subagents / skills / hooks): which to use when, the exact frontmatter for each, every hook
   event and what exit code 2 does, precedence rules, and the gotchas. Worth reading even if
   you install nothing.
2. **`claude-md/00-universal.md`** — a `CLAUDE.md` template with the sections that actually
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

1. **10 subagents** — the 3 above plus `refactorer`, `api-designer`, `sql-tuner`,
   `perf-profiler`, `dependency-auditor`, `migration-planner`, `docs-writer`
2. **12 slash commands** — plus `/pr`, `/debug`, `/fix-ci`, `/tests`, `/security`,
   `/cleanup`, `/explain`, `/scaffold`, `/changelog`
3. **7 hooks** — plus `typecheck-on-edit` (runs `tsc --noEmit` / `mypy` / `go build` /
   `cargo check` after every edit and **feeds the errors straight back to Claude so it fixes
   them in the same turn** — the single highest-value file in the pack), `format-on-edit`
   (10 languages), `protect-main`, `log-session`, `notify-done`
4. **4 skills** — `ship-it` (full pre-merge gate), `incident-triage` (prod is down right
   now), `spec-to-plan`, `legacy-rescue` (characterisation tests before touching untested
   legacy code)
5. **6 CLAUDE.md templates** — universal, Next.js + TypeScript, Python + FastAPI, Node API,
   Flutter, monorepo — each with a real Gotchas section

**→ [Get the full kit](https://p32929.github.io/claude-code-starter-kit/)** — $50 one-time, one
developer, unlimited projects, personal and commercial. No subscription, no seat count, no expiry.

A team licence for a whole company is $499.

## Licence

The files in **this repo** are MIT — use them however you like.
The full kit is sold under a single-developer licence (use anywhere, do not redistribute).

Built by [@p32929](https://github.com/p32929).

## Contributing

Contributions are very welcome, thank you! Before you start on a pull request, please open an issue and tell me what you would like to add or change. That way we can agree on it first, and your time is not wasted on something that might not fit. Thanks for helping make the starter kit better.

## You might also like

<p><a href="https://openstore.pfay.workers.dev/more/p32929/_/0"><picture><source media="(prefers-color-scheme: dark)" srcset="https://openstore.pfay.workers.dev/more/p32929/_/0-dark.svg"><img src="https://openstore.pfay.workers.dev/more/p32929/_/0-light.svg" width="50%" align="top" alt="More apps by p32929 on OpenStore (1)"></picture></a><a href="https://openstore.pfay.workers.dev/more/p32929/_/1"><picture><source media="(prefers-color-scheme: dark)" srcset="https://openstore.pfay.workers.dev/more/p32929/_/1-dark.svg"><img src="https://openstore.pfay.workers.dev/more/p32929/_/1-light.svg" width="50%" align="top" alt="More apps by p32929 on OpenStore (2)"></picture></a><br><a href="https://openstore.pfay.workers.dev/more/p32929/_/2"><picture><source media="(prefers-color-scheme: dark)" srcset="https://openstore.pfay.workers.dev/more/p32929/_/2-dark.svg"><img src="https://openstore.pfay.workers.dev/more/p32929/_/2-light.svg" width="50%" align="top" alt="More apps by p32929 on OpenStore (3)"></picture></a><a href="https://openstore.pfay.workers.dev/more/p32929/_/3"><picture><source media="(prefers-color-scheme: dark)" srcset="https://openstore.pfay.workers.dev/more/p32929/_/3-dark.svg"><img src="https://openstore.pfay.workers.dev/more/p32929/_/3-light.svg" width="50%" align="top" alt="More apps by p32929 on OpenStore (4)"></picture></a></p>

<p><a href="https://p32929.github.io/share/?repo=claude-code-starter-kit"><picture><source media="(prefers-color-scheme: dark)" srcset="https://p32929.github.io/readme/footer-share-dark.svg"><img src="https://p32929.github.io/readme/footer-share-light.svg" width="50%" align="top" alt="Share this project with your friends in one click"></picture></a><a href="https://p32929.github.io/support/"><picture><source media="(prefers-color-scheme: dark)" srcset="https://p32929.github.io/readme/footer-support-dark.svg"><img src="https://p32929.github.io/readme/footer-support-light.svg" width="50%" align="top" alt="If you like my work and want to support me, feel free to support"></picture></a><br><a href="https://openstore.pfay.workers.dev/add"><picture><source media="(prefers-color-scheme: dark)" srcset="https://p32929.github.io/readme/footer-join-dark.svg"><img src="https://p32929.github.io/readme/footer-join-light.svg" width="100%" align="top" alt="Put your own apps on OpenStore: free, your listing lives in your own repo"></picture></a></p>
