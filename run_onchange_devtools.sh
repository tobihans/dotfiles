#!/usr/bin/env bash
# Install tools via development kits

# SDK
sdk_packages=(
	"gradle"
	"kotlin"
	"maven"
)
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
for pkg in "${sdk_packages[@]}"; do
	sdk install "$pkg"
done

# Cargo
cargo_packages=(
	"bob-nvim"
	"cargo-expand"
	"cargo-watch"
	"stylua"
	"tidy-viewer"
	"tree-sitter-cli"
	"cargo-insta"
)
locked_cargo_packages=(
	"starship"
)
cargo install "${cargo_packages[@]}"
cargo install --locked "${locked_cargo_packages[@]}"
if [[ -x "$(command -v bob)" ]]; then
	bob install nightly
	bob install stable
	bob use nightly
fi

# PipX
pipx_packages=(
	"poetry"
	"sqlite-utils"
	"grip"
	"ansible"
)
python -m pipx install "${pipx_packages[@]}"
python -m pipx inject --include-apps ansible ansible-lint
if ! [[ -x "$(command -v sqlite-utils)" ]]; then
	sqlite-utils install sqlean.py
	sqlite-utils install sqlite-dump
fi

# Go
go_packages=(
	"github.com/mikefarah/yq/v4@latest"
)
for pkg in "${go_packages[@]}"; do
	go install "$pkg"
done
