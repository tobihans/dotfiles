#!/usr/bin/env bash
# Base requirements

requirements=(
	"curl"
	"git"
	"unzip"
	"zip"
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

# NVM
if ! [[ -s "$NVM_DIR/nvm.sh" ]]; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fi

# DVM
if ! [[ -x "$(command -v dvm)" ]]; then
	curl -fsSL https://dvm.deno.dev | bash
fi

# Rustup
if ! [[ -x "$(command -v rustup)" ]]; then
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# SDK
if ! [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
	curl -s "https://get.sdkman.io" | bash
fi

# TODO: Setup Victor Mono Nerdfont
# git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts ~/Code/nerd-fonts
# cd nerd-fonts || exit
# git sparse-checkout add patched-fonts/VictorMono
