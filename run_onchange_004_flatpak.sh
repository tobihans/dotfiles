#!/usr/bin/env bash
set -eo pipefail

packages=(
    "com.discordapp.Discord"
    "io.github.seadve.Kooha"
    "com.usebottles.bottles"
)

for package in "${packages[@]}"; do
    flatpak install --assumeyes --noninteractive "$package"
done
