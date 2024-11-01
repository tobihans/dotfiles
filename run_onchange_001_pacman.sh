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

# Installs pacman packages
packages=(
	"base-devel" "bat" "btop"
	"chezmoi" "cmake" "composer" "cryfs" "curl"
	"docker" "docker-buildx" "docker-compose"
	"fd" "ffmpeg" "fzf"
	"gdu" "git" "github-cli" "go"
	"jq"
	"lua51" "luarocks"
	"m4" "make" "mosh"
	"neofetch" "ninja" "nushell"
	"onefetch" "openssh" "openssl"
	"php" "php-apache" "php-cgi" "php-embed" "php-fpm" "php-gd" "php-igbinary" "php-redis"
	"php-snmp" "postgresql-libs" "protobuf"
	"ripgrep"
	"unzip"
	"zip"
	"wget"
)

if [[ -n "${XDG_CURRENT_DESKTOP}" ]]; then
	packages+=(
		"android-tools" "android-udev" "appmenu-gtk-module"
		"chromium"
		"firefox-developer-edition"
		"gtk3"
		"keepassxc" "kimageformats" "kitty"
		"libappindicator-gtk3" "librsvg" "libvips"
		"onlyoffice-desktopeditors"
		"powerdevil" "powertop"
		"remmina"
		"tlp" "tlpui"
		"scrcpy" "sniffnet"
		"webkit2gtk"
		"xdg-desktop-portal-gtk"
	)
fi

for package in "${packages[@]}"; do
	check=$(
		pacman -Qi "$package" >/dev/null 2>&1
		echo "$?"
	)

	if [[ "$check" -ne "0" ]]; then
		echo "$package [installing]"
		sudo pacman -Syu --needed --noconfirm "$package"
		echo "$package [installed]"
	else
		echo "$package [installed]"
	fi
done
