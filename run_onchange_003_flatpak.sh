#!/usr/bin/env bash
set -eo pipefail

if [[ ! -f /etc/arch-release ]]; then
    echo "Not Arch based, skipping."
    exit 0
fi

if [[ -z "${XDG_CURRENT_DESKTOP}" ]]; then
    exit 0
fi

packages=(
    # "dev.vencord.Vesktop"
    # "io.github.seadve.Kooha"
)

if [[ ${#packages[@]} -gt 0 ]]; then
    for package in "${packages[@]}"; do
        flatpak install --assumeyes --noninteractive "$package"
    done
fi
