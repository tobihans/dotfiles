# --- macOS package convergence (Homebrew Bundle) ---
# Fragment rendered into run_onchange_setup.sh.tmpl; caller guards on .chezmoi.os.
# brew bundle is idempotent; reads the Brewfile straight from the source tree so
# ordering vs the ~/.Brewfile target doesn't matter.

if command -v brew >/dev/null 2>&1; then
	brew bundle --file "{{ .chezmoi.sourceDir }}/dot_Brewfile"
else
	echo "[setup] Homebrew not found. Install it first (see docs/setup.md), then: chezmoi apply"
fi
