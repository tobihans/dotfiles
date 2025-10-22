#!/usr/bin/env bash
set -eo pipefail

if [[ ! -f /etc/arch-release ]]; then
	echo "Not Arch based, skipping."
	exit 0
fi

# Installs yay packages
packages=(
	"atuin" "fswatch"
)
# "mise"

if [[ -n "${XDG_CURRENT_DESKTOP}" ]]; then
	packages+=(
		"plasma5-wallpapers-dynamic" "opensnitch" "python-pyclip"
		"slack-desktop" "supertuxkart"
		"trash-cli"
		"wl-clipboard"
		"koi"
		"zoom" "zen-browser-bin"
	)
fi
# "waydroid"
# "wkhtmltopdf"
# Optional WPS Office dependencies
# wps-office
# libtiff5: Provide libtiff.so.5 for wpspdf working
# ttf-wps-fonts: Symbol fonts required by wps-office
# ttf-ms-fonts: Microsoft Fonts recommended for wps-office
# wps-office-fonts: FZ TTF fonts provided by wps community
# wps-office-mime: Use mime files provided by Kingsoft

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
