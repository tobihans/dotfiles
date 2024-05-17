#!/usr/bin/env bash
set -eo pipefail

# Installs yay packages

packages=(
	"circumflex" "fswatch" "glow" "ngrok"
)

if [[ -n "${XDG_CURRENT_DESKTOP}" ]]; then
	packages+=(
		"plasma5-wallpapers-dynamic"
		"slack-desktop" "supertuxkart"
		"zoom"
	)
fi
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
