#!/usr/bin/env bash
# Claude Code Starter Kit (Lite) — installer
#   bash install.sh            → ./.claude   (this project)
#   bash install.sh --global   → ~/.claude   (every project)
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ "${1:-}" = "--global" ]; then DEST="$HOME/.claude"; else DEST="$PWD/.claude"; fi

echo "Claude Code Starter Kit (Lite) → $DEST"
mkdir -p "$DEST/agents" "$DEST/commands" "$DEST/hooks"
cp "$SRC"/agents/*.md "$DEST/agents/"
cp "$SRC"/commands/*.md "$DEST/commands/"
cp "$SRC"/hooks/scripts/*.sh "$DEST/hooks/"
chmod +x "$DEST"/hooks/*.sh

if [ -f "$DEST/settings.json" ]; then
  cp "$SRC/hooks/settings.hooks.json" "$DEST/settings.hooks.json"
  echo "  !  settings.json exists — merge the hooks block from settings.hooks.json yourself."
else
  cp "$SRC/hooks/settings.hooks.json" "$DEST/settings.json"
  echo "  settings.json written (2 guard hooks enabled)"
fi

echo "  3 subagents, 3 commands, 2 guard hooks installed."
echo
if printf '{"tool_input":{"command":"rm -rf /"}}' | "$DEST/hooks/guard-destructive.sh" >/dev/null 2>&1
then echo "  FAIL  guard-destructive did not block 'rm -rf /' (is python3 installed?)"
else echo "  ok    guard-destructive blocks 'rm -rf /'"; fi

echo
echo "Now RESTART Claude Code (hooks load at startup), then type / to see the commands."
echo "Copy a project memory file too:  cp $SRC/claude-md/00-universal.md CLAUDE.md"
