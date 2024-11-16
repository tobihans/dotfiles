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

# Installs yay packages
packages=(
	"ast-grep" "atuin" "fswatch" "freeze" "mise" "vhs"
)

if [[ -n "${XDG_CURRENT_DESKTOP}" ]]; then
	packages+=(
		"plasma5-wallpapers-dynamic" "opensnitch" "python-pyclip"
		"slack-desktop" "supertuxkart"
		"wl-clipboard"
		"koi"
		"zoom"
	)
fi
# "waydroid"
# "wkhtmltopdf"

# Install packages
for package in "${packages[@]}"; do
	check=$(
		yay -Qi "$package" >/dev/null 2>&1
		echo "$?"
	)

	if [[ "$check" -ne "0" ]]; then
		echo "$package [installing]"
		yay -Syu --noconfirm --answerdiff None --answerclean None "$package"
		echo "$package [installed]"
	else
		echo "$package [installed]"
	fi
done
