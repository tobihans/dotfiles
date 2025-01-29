#!/usr/bin/env bash
set -eo pipefail

if [[ -z "${XDG_CURRENT_DESKTOP}" ]]; then
    exit 0
fi

packages=(
    "dev.vencord.Vesktop"
    # "io.github.seadve.Kooha"
)

for package in "${packages[@]}"; do
    flatpak install --assumeyes --noninteractive "$package"
done
