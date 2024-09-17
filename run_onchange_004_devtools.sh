#!/usr/bin/env bash
# shellcheck disable=SC1091

set -eo pipefail

export PATH="$HOME/.local/bin:$PATH"

# Gitpod CLI
if ! [[ -x "$(command -v gitpod)" ]]; then
	mkdir -p "$HOME"/.local/bin
	curl --output "$HOME"/.local/bin/gitpod https://gitpod.io/static/bin/gitpod-cli-linux-amd64
	chmod +x "$HOME"/.local/bin/gitpod
	"$HOME"/.local/bin/gitpod config set --telemetry=false
fi

# ASDF
asdf_plugins=(
	"gradle"
	# "kotlin"
	# "maven"
	"nodejs"
)
for plugin in "${asdf_plugins[@]}"; do
	asdf plugin add "$plugin"
done

# Cargo
cargo_packages=(
	"atuin"
	"bob-nvim"
	"cargo-expand"
	"cargo-watch"
	"eza"
	"hurl"
	"just"
	"mdbook"
	"sleek"
	"sshx"
	"stylua"
	"tidy-viewer"
	"tree-sitter-cli"
	# "cargo-insta"
)
locked_cargo_packages=(
	"difftastic"
	"starship"
	"typstyle"
	"watchexec-cli"
	"zoxide"
)
cargo_repo_packages=(
	"https://github.com/neovide/neovide"
)
source "$HOME"/.cargo/env
cargo install "${cargo_packages[@]}" || true
cargo install --git "${cargo_repo_packages[@]}" || true
cargo install --locked "${locked_cargo_packages[@]}" || true
if [[ -x "$(command -v bob)" ]]; then
	bob update --all
fi

# PipX
pipx_packages=(
	"ansible"
	"elia-chat"
	"grip"
	"harlequin[postgres,s3,mysql]"
	"litecli"
	"poetry"
	"sqlite-utils"
	"trash-cli"
	"virtualenv"
)
for pkg in "${pipx_packages[@]}"; do
	python -m pipx install --include-deps "$pkg" || true
done
if ! [[ -x "$(command -v sqlite-utils)" ]]; then
	sqlite-utils install sqlean.py || true
	sqlite-utils install sqlite-dump || true
fi

# Go
go_packages=(
	"github.com/jesseduffield/lazydocker@latest"
	"github.com/jesseduffield/lazygit@latest"
	"github.com/mikefarah/yq/v4@latest"
	"gitlab.com/gitlab-org/cli/cmd/glab@latest"
	"github.com/k1LoW/tbls@latest"
	"github.com/knqyf263/pet@latest"
)
for pkg in "${go_packages[@]}"; do
	go install "$pkg" || true
done
