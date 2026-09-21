#!/usr/bin/env bash
# PreToolUse (Bash) — blocks commands that destroy work with no undo.
# Exit 2 = block; stderr goes back to Claude.
set -uo pipefail

cmd=$(cat | python3 -c 'import json,sys;print((json.load(sys.stdin).get("tool_input") or {}).get("command",""))' 2>/dev/null) || exit 0
[ -z "$cmd" ] && exit 0

deny() { echo "BLOCKED by guard-destructive hook: $1" >&2; echo "Command was: $cmd" >&2; exit 2; }

# recursive rm aimed at a root, home, or wildcard path
if printf '%s' "$cmd" | grep -Eq 'rm[[:space:]]+(-[^[:space:]]*[rR][^[:space:]]*[[:space:]]+)+' ; then
  printf '%s' "$cmd" | grep -Eq '[[:space:]](/|~|\$HOME|\$\{HOME\}|\.)/?\*?[[:space:]]*(;|&&|\||$)' \
    && deny "recursive delete of a root, home, or whole-directory path."
fi

# force-push to a protected branch
printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+push.*(--force|-f)([[:space:]]|$)' \
  && printf '%s' "$cmd" | grep -Eq '(main|master|prod|production|release)' \
  && deny "force-push to a protected branch. Use --force-with-lease on a feature branch."

# history rewrites and hard resets that throw away uncommitted work
printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+reset[[:space:]]+--hard' && deny "git reset --hard discards uncommitted work. Use 'git stash' first."
printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+clean[[:space:]]+-[[:alnum:]]*[fF][[:alnum:]]*d' && deny "git clean -fd deletes untracked files permanently."
printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+checkout[[:space:]]+--[[:space:]]+\.' && deny "this discards all local changes."

# destructive SQL with no WHERE
printf '%s' "$cmd" | grep -Eiq '(drop[[:space:]]+(table|database|schema)|truncate[[:space:]]+table)' && deny "irreversible schema destruction."
printf '%s' "$cmd" | grep -Eiq 'delete[[:space:]]+from[[:space:]]+[a-z_.\"]+[[:space:]]*(;|$)' && deny "DELETE with no WHERE clause."

# package manager and infra wipes
printf '%s' "$cmd" | grep -Eq '(npm|yarn|pnpm)[[:space:]]+(unpublish|deprecate)' && deny "publishing-registry mutation."
printf '%s' "$cmd" | grep -Eq 'terraform[[:space:]]+destroy' && deny "terraform destroy."
printf '%s' "$cmd" | grep -Eq 'kubectl[[:space:]]+delete.*(--all|namespace)' && deny "bulk kubernetes delete."
printf '%s' "$cmd" | grep -Eq 'dd[[:space:]]+if=.*of=/dev/' && deny "raw disk write."
printf '%s' "$cmd" | grep -Eq ':\(\)[[:space:]]*\{.*\|.*&.*\}' && deny "fork bomb."

exit 0
