# --- macOS packages (Homebrew Bundle) — intentionally NOT run here ---
# brew bundle can take many minutes; first-run setup must stay fast.
# The user runs it manually after the dotfiles are in place (docs/setup.md).

echo "[setup] macOS: to install your packages, run manually when ready:"
echo "[setup]   brew bundle --file \"{{ .chezmoi.sourceDir }}/dot_Brewfile\""
# brew bundle --file "{{ .chezmoi.sourceDir }}/dot_Brewfile"
