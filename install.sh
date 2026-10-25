#!/bin/sh
# Install the security-audit skill for Codex, Cursor, and GitHub Copilot.
# Usage: install.sh [skills-dir]   (default: ~/.agents/skills)
set -eu

REPO="${REPO:-seabnavin19/security-skills}"
REF="${REF:-main}"
DEST="${1:-$HOME/.agents/skills}"

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

curl -fsSL "https://github.com/$REPO/archive/refs/heads/$REF.tar.gz" | tar -xz -C "$tmp"

mkdir -p "$DEST"
rm -rf "$DEST/security-audit"
cp -R "$tmp"/*/skills/security-audit "$DEST/security-audit"

echo "Installed security-audit to $DEST/security-audit"
command -v node >/dev/null 2>&1 || echo "Note: full audits run Node.js validators; install Node to use them."
