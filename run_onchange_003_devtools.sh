#!/usr/bin/env bash
set -eo pipefail

# Install tools via development kits

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
# shellcheck disable=SC1091
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME"/.sdkman/bin/sdkman-init.sh
for pkg in "${sdk_packages[@]}"; do
	sdk install "$pkg" || true
done

# Cargo
cargo_packages=(
	"bob-nvim"
	"cargo-expand"
	# "cargo-insta"
	"cargo-watch"
	"eza"
	"hurl"
	"just"
	"mdbook"
	"stylua"
	"tidy-viewer"
	"tree-sitter-cli"
)
locked_cargo_packages=(
	"starship"
)
# shellcheck disable=SC1091
source "$HOME"/.cargo/env
cargo install "${cargo_packages[@]}" || true
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
	"poetry"
	"sqlite-utils"
)
for pkg in "${pipx_packages[@]}"; do
	python -m pipx install "$pkg" || true
done
python -m pipx inject --include-apps ansible ansible-lint
if ! [[ -x "$(command -v sqlite-utils)" ]]; then
	sqlite-utils install sqlean.py || true
	sqlite-utils install sqlite-dump || true
fi

# Go
go_packages=(
	"github.com/jesseduffield/lazydocker@latest"
	"github.com/jesseduffield/lazygit@latest"
	"github.com/mikefarah/yq/v4@latest"
)
for pkg in "${go_packages[@]}"; do
	go install "$pkg" || true
done

if [[ -s "$NVM_DIR/nvm.sh" ]]; then
	source "$NVM_DIR/nvm.sh"
	nvm install --lts
	nvm alias default node
fi
