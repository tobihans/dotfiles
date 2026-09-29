#!/usr/bin/env bash
# vim: ft=bash
# Opt-in updater for this dotfiles setup (replaces what run_after_all.sh used to
# do on every chezmoi apply). Pulls the repo, applies changes, then refreshes
# tools that track upstream versions. Safe to re-run.
set -uo pipefail

if command -v chezmoi >/dev/null 2>&1; then
	echo "[sysupdate] chezmoi update"
	chezmoi update || echo "[sysupdate] chezmoi update failed"
fi

if command -v mise >/dev/null 2>&1; then
	echo "[sysupdate] mise plugins + tools"
	mise p up -y
	mise up -y
fi

if command -v bob >/dev/null 2>&1; then
	echo "[sysupdate] bob (neovim builds)"
	bob update --all
fi

if command -v tv >/dev/null 2>&1; then
	echo "[sysupdate] television channels"
	tv update-channels
fi

echo "[sysupdate] done"
