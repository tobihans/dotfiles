# --- Nushell integration regeneration ---
# Fragment rendered into run_onchange_setup.sh.tmpl; runs on every OS.
# These generated files are gitignored (.chezmoiignore); the mise/nuenv/starship
# vendor wrappers are handled by chezmoi templates, so only tool-generated ones
# remain here. Guarded so a missing tool never aborts setup.

NUSHELL_SCRIPTS_PATH="$HOME/.config/nushell/scripts/integrations"
if [[ "$(uname)" == "Darwin" ]]; then
	NUSHELL_SCRIPTS_PATH="$HOME/Library/Application Support/nushell/scripts/integrations"
fi
mkdir -p "$NUSHELL_SCRIPTS_PATH"

command -v atuin >/dev/null 2>&1 && atuin init nu >|"$NUSHELL_SCRIPTS_PATH/atuin.nu" || echo "[setup] atuin not found, skipped atuin.nu"
command -v starship >/dev/null 2>&1 && starship init nu >|"$NUSHELL_SCRIPTS_PATH/starship.nu" || echo "[setup] starship not found, skipped starship.nu"
