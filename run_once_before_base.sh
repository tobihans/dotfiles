#!/usr/bin/env bash
set -eo pipefail

# shellcheck disable=1091
OS=$(
	source /etc/os-release
	echo "$ID"
)

if [[ "$OS" != "manjaro" ]]; then
	echo "Not Manjaro, skipping."
	exit 0
fi

# Base requirements
requirements=(
	"age"
	"curl"
	"git"
	"unzip"
	"zip"
	"manjaro-tools-base"
)
for requirement in "${requirements[@]}"; do
	if ! [[ -x "$(command -v "$requirement")" ]]; then
		sudo pacman -Syu --noconfirm --needed "$requirement"
	fi
done

# Pacman base-devel
base_devel=$(
	pacman -Qi "base-devel" >/dev/null 2>&1
	echo "$?"
)
if [[ "$base_devel" -ne "0" ]]; then
	echo "base-devel [installing]"
	sudo pacman -S --needed --noconfirm "base-devel"
	echo "base-devel [installed]"
else
	echo "base-devel [installed]"
fi

# Yay
if ! [[ -x "$(command -v git)" ]]; then
	pacman -S --noconfirm git
fi
if ! [[ -x "$(command -v yay)" ]]; then
	pwdir=$(pwd)
	cd /tmp/ || exit

	git clone https://aur.archlinux.org/yay-git.git yay
	cd yay || exit
	makepkg -si --noconfirm

	cd .. || exit
	rm -rf yay
	cd "$pwdir" || exit
fi
