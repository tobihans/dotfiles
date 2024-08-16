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

# SDK
sdk_packages=(
	"gradle"
	"kotlin"
	"maven"
)
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME"/.sdkman/bin/sdkman-init.sh
for pkg in "${sdk_packages[@]}"; do
	sdk install "$pkg" || true
done

# Cargo
cargo_packages=(
	"bob-nvim"
	"cargo-expand"
	"cargo-watch"
	"eza"
	"hurl"
	"just"
	"mdbook"
	"sleek"
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
	"yazi-cli"
	"yazi-fm"
)
cargo_repo_packages=(
	"https://github.com/neovide/neovide"
)
source "$HOME"/.cargo/env
cargo install "${cargo_packages[@]}" || true
cargo install --git "${cargo_repo_packages[@]}" || true
cargo install --locked "${locked_cargo_packages[@]}" || true
if [[ -x "$(command -v bob)" ]]; then
	bob install nightly
	bob use nightly || true
fi

# PipX
pipx_packages=(
	"ansible"
	"grip"
	"harlequin[postgres,s3,mysql]"
	"litecli"
	"poetry"
	"sqlite-utils"
	"trash-cli"
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
	"gitlab.com/gitlab-org/cli/cmd/glab@main"
	"github.com/k1LoW/tbls@latest"
)
for pkg in "${go_packages[@]}"; do
	go install "$pkg" || true
done

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
	source "$NVM_DIR/nvm.sh"
	nvm install --lts
	nvm use --lts
	nvm alias default "$(node --version)"
fi
