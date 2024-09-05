#!/usr/bin/env bash
set -eo pipefail

packages=(
    "dev.vencord.Vesktop"
    "io.github.seadve.Kooha"
)

for package in "${packages[@]}"; do
    flatpak install --assumeyes --noninteractive "$package"
done
