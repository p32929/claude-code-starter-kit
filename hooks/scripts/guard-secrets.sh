#!/usr/bin/env bash
# PreToolUse (Read|Edit|Write|Bash) — blocks reading or writing secret files.
# Exit 2 = block the tool call; stderr is shown to Claude so it can pick another path.
set -uo pipefail

payload=$(cat)
target=$(printf '%s' "$payload" | python3 -c '
import json,sys
d=json.load(sys.stdin)
ti=d.get("tool_input") or {}
print(ti.get("file_path") or ti.get("path") or ti.get("notebook_path") or ti.get("command") or "")
' 2>/dev/null) || exit 0

[ -z "$target" ] && exit 0

# Add or remove patterns here. Extended regex, matched case-insensitively.
BLOCKED='(^|/|[[:space:]])\.env($|\.|[[:space:]])|\.env\.(local|production|prod|staging)|(^|/)id_(rsa|ed25519|ecdsa)($|[[:space:]])|\.pem($|[[:space:]])|\.p12($|[[:space:]])|(^|/)\.npmrc|(^|/)\.pypirc|(^|/)\.netrc|(^|/)\.aws/credentials|(^|/)\.ssh/|service-account.*\.json|credentials\.json|secrets?\.(ya?ml|json|toml)'

if printf '%s' "$target" | grep -Eiq "$BLOCKED"; then
  echo "BLOCKED by guard-secrets hook: '$target' looks like a secret file." >&2
  echo "Do not read, write or cat it. If you need a value from it, ask the user for the variable NAME and read it from the environment instead." >&2
  exit 2
fi
exit 0
