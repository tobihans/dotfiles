#!/usr/bin/env bash
set -eo pipefail

# Installs pacman packages

packages=(
	"android-tools" "android-udev"
	"base-devel" "bat" "btop"
	"chezmoi" "cmake" "composer" "cryfs"
	"dart-sass" "docker" "docker-buildx"
	"fd" "ffmpeg" "fzf"
	"gdu" "git" "github-cli" "go"
	"jq"
	"luarocks"
	"m4" "make" "minikube" "mosh"
	"neofetch" "ninja"
	"onefetch" "openssh"
	"php" "php-apache" "php-cgi" "php-embed" "php-fpm" "php-gd" "php-igbinary" "php-redis" "python-pipx"
	"php-snmp" "postgresql-libs"
	"redis" "ripgrep"
	"scrcpy" "screen"
	"tmux" "tree"
	"unzip"
	"zip"
)

if [[ -n "${XDG_CURRENT_DESKTOP}" ]]; then
	packages+=(
		"chromium"
		"discord" "docker-compose"
		"firefox-developer-edition"
		"kitty" "keepassxc"
		"onlyoffice-desktopeditors"
		"powerdevil" "powertop" "protobuf"
		"remmina"
		"tlp" "tlpui"
		"screenkey" "sniffnet"
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
