#!/usr/bin/env bash

DOTFILES='https://github.com/tobihans/dotfiles.git'

if [ -f /etc/arch-release ] || [ -f /etc/manjaro-release ]; then
	sudo pacman -Syu --noconfirm chezmoi
	chezmoi init --verbose --apply "$DOTFILES"
fi
