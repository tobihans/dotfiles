#!/usr/bin/env bash

# TODO: add check for OS
# TODO: Install and configure qemu

function install::pacman_packages() {
	sudo pacman -Syu android-tools android-udev \
		base-devel bat btop \
		chezmoi chromium cmake composer cython \
		dart-sass discord docker docker-buildx docker-compose \
		fd ffmpeg firefox-developer-edition \
		gdu github-cli go \
		jq \
		kitty \
		lazydocker lazygit luarocks \
		m4 make mariadb minikube mosh \
		neofetch neovim ninja \
		onefetch onlyoffice-desktopeditors openssh \
		php php-apache php-cgi php-embed php-fpm php-gd php-igbinary php-redis python-pipx \
		php-snmp postgresql postgresql-libs postman-bin powerdevil powertop protobuf \
		redis remmina ripgrep \
		scrcpy screen slack-desktop \
		tlp tlpui tmux tree
}

function install::yay() {
	if ! [[ -x "$(command -v git)" ]]; then
		pacman -S git
	fi

	if ! [[ -x "$(command -v yay)" ]]; then
		cd /tmp/ || exit
		git clone https://aur.archlinux.org/yay-git.git
		cd yay || exit
		makepkg -si
		cd .. || exit
		rm -rf yay
	fi
}

function install::yay_packages() {
	install::yay

	yay -Syu grpcurl \
		ngrok \
		passwordsafe-git postman-bin \
		slack-desktop supertuxkart \
		wkhtmltopdf \
		zoom
}

function install::omb() {
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
}

function install::chezmoi() {
	dotfiles_location='https://github.com/tobihans/dotfiles.git'

	if ! [[ -x "$(command -v chezmoi)" ]]; then
		sudo pacman -Syu chezmoi
		chezmoi init --verbose $dotfiles_location
		printf "chezmoi initialized: use diff and apply to finish the setup.\n"
	fi
}

function install::sdk() {
	if ! [[ -x "$(command -v sdk)" ]]; then
		curl -s "https://get.sdkman.io" | bash
	fi
}

function install::sdk_packages() {
	sdk install gradle
	sdk install kotlin
	sdk install maven
}

function install::nvm() {
	if ! [[ -x "$(command -v nvm)" ]]; then
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	fi
}

function install::rustup() {
	if ! [[ -x "$(command -v rustup)" ]]; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	fi
}

function install::cargo_packages() {
	install::rustup

	cargo install cargo-expand cargo-watch cargo-msrv \
	stylua tidy-viewer tree-sitter-cli
	cargo install starship --locked
	cp /home/"$USER"/.cargo/bin/tidy-viewer ~/.local/bin/
}

function install::astro() {
	mkdir -p ~/.config/nvim
	mv ~/.config/nvim ~/.config/nvim.bak &>/dev/null 2>&1
	mv ~/.local/share/nvim/site ~/.local/share/nvim/site.bak &>/dev/null 2>&1

	git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	git clone https://github.com/tobihans/nvim-config ~/.config/nvim/lua/user
}

function install::cli_tools() {
	if ! [[ -x "$(command -v pipx)" ]]; then
		sudo pacman -Syu python-pipx
	fi

	pipx install poetry sqlite-utils
	sqlite-utils install sqlean.py
	sqlite-utils install sqlite-dump
}

function setup() {
	install::pacman_packages
	install::yay_packages
	install::cargo_packages
	install::omb
	install::chezmoi
	install::sdk
	install::nvm
	install::rustup
	install::astro
}

setup
