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

# Mise
mise p up -y
mise up -y

# Cargo
cargo_packages=(
	"atuin"
	"mise"
)
source "$HOME"/.cargo/env
cargo install "${cargo_packages[@]}" || true
if [[ -x "$(command -v bob)" ]]; then
	bob update --all
fi

if ! [[ -x "$(command -v sqlite-utils)" ]]; then
	sqlite-utils install sqlean.py || true
	sqlite-utils install sqlite-dump || true
fi
