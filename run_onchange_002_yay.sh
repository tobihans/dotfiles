#!/usr/bin/env bash
# Installs yay packages

packages=(
	"circumflex" "glow"
	"lazydocker" "lazygit"
	"ngrok"
	"passwordsafe-git"
	"slack-desktop" "supertuxkart"
	"wkhtmltopdf"
	"zoom"
)

# Install packages
for package in "${packages[@]}"; do
	check=$(
		yay -Qi "$package" >/dev/null 2>&1
		echo "$?"
	)

	if [[ "$check" -ne "0" ]]; then
		echo "$package [installing]"
		yay -Syu "$package"
		echo "$package [installed]"
	else
		echo "$package [installed]"
	fi
done
