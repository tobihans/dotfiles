#!/usr/bin/env bash
# Installs pacman packages

packages=(
	"android-tools" "android-udev"
	"base-devel" "bat" "btop"
	"chezmoi" "chromium" "cmake" "composer" "cryfs"
	"dart-sass" "discord" "docker" "docker-buildx" "docker-compose"
	"fd" "ffmpeg" "firefox-developer-edition" "fzf"
	"gdu" "git" "github-cli" "go"
	"jq"
	"kitty" "keepassxc"
	"luarocks"
	"m4" "make" "minikube" "mosh"
	"neofetch" "ninja"
	"onefetch" "onlyoffice-desktopeditors" "openssh"
	"php" "php-apache" "php-cgi" "php-embed" "php-fpm" "php-gd" "php-igbinary" "php-redis" "python-pipx"
	"php-snmp" "postgresql-libs" "powerdevil" "powertop" "protobuf"
	"redis" "remmina" "ripgrep"
	"scrcpy" "screen" "screenkey" "slack-desktop" "sniffnet"
	"tlp" "tlpui" "tmux" "tree"
	"unzip"
	"zip"
)

for package in "${packages[@]}"; do
	check=$(
		pacman -Qi "$package" >/dev/null 2>&1
		echo "$?"
	)

	if [[ "$check" -ne "0" ]]; then
		echo "$package [installing]"
		sudo pacman -Syu --needed "$package"
		echo "$package [installed]"
	else
		echo "$package [installed]"
	fi
done
