#!/usr/bin/env bash

function install::pacman_packages() {
	sudo pacman -Syu "$@" android-tools android-udev \
		base-devel btop \
		chezmoi chromium cmake composer cython \
		dart-sass discord docker docker-buildx docker-compose \
		fd ffmpeg firefox-developer-edition \
		github-cli go \
		kitty \
		lazydocker lazygit luarocks \
		m4 make mariadb minikube \
		neofetch neovim ninja \
		onefetch onlyoffice-desktopeditors openssh \
		php php-apache php-cgi php-embed php-fpm php-gd php-igbinary php-redis \
		php-snmp postgresql postgresql-libs postman-bin powerdevil powertop protobuf \
		redis remmina \
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
	yay -Syu grpcurl \
		ngrok \
		passwordsafe-git postman-bin \
		slack-desktop \
		wkhtmltopdf \
		zoom
}

function install::omb() {
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
}

function install::chezmoi() {
	dotfiles_location='https://github.com/tobihans/dotfiles.git'

	if ! [[ -x "$(command -v chezmoi)" ]]; then
		sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply --verbose $dotfiles_location
		printf "chezmoi initialized: use diff and apply to finish the setup.\n"
	fi
}

function install::sdk() {
	if ! [[ -x "$(command -v sdk)" ]]; then
		curl -s "https://get.sdkman.io" | bash
	fi
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
	cargo install cargo-expand cargo-watch cargo-msrv cargo-miri
	cargo install tree-sitter-cli stylua
	cargo install starship --locked
}

function install::astro() {
	mkdir -p ~/.config/nvim
	mv ~/.config/nvim ~/.config/nvim.bak &>/dev/null 2>&1
	mv ~/.local/share/nvim/site ~/.local/share/nvim/site.bak &>/dev/null 2>&1

	git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
	git clone https://github.com/tobihans/nvim-config ~/.config/nvim/lua/user
}

function install::cli_tools() {
	# Install common CLI tools
	yay -S lazydocker lazygit
	pacman -S ripgrep
	# pipx, poetry, sqlite-utils,jq,
	# ansible
	# mosh
	# docker
	# scrcpy
	# screen
	# sass
	# Android manual toolkit maybe
	# go
	# localstack (awslocal)
	# gh
	# tidy-viewer
	# btm
	# nim ?
	# cargo-watch, cargo-msrv, cargo-miri,
	# starship
	# stylua
	# supertuxkart, haha games matter
	# tlp
	# deno ?
	# tmux ?
	# distrobox ?
	# kotlin gradle, through sdkman
	# qemu and virsh and virtual manager
	# luarocks
	# gdu
	# bat
	# yay
	# cargo install tree-sitter-cli
}

function setup() {
	install::yay
	install::omb
	install::chezmoi
	install::sdk
	install::nvm
	install::rustup
	install::astro
}

setup
