#!/usr/bin/env bash

if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
	sudo pacman -Syu --noconfirm chezmoi
	chezmoi init --verbose --apply "https://github.com/tobihans/dotfiles.git"
fi
