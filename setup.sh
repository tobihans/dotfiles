#!/usr/bin/env bash

# TODO: add check for OS
# TODO: Install and configure qemu

function install::pacman_packages() {
	sudo pacman -S --needed base-devel

	sudo pacman -Syu --needed android-tools android-udev \
		base-devel bat bob btop \
		chezmoi chromium cmake composer cryfs cython \
		dart-sass discord docker docker-buildx docker-compose \
		fd ffmpeg firefox-developer-edition fzf \
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
		scrcpy screen screenkey slack-desktop sniffnet \
		tlp tlpui tmux tree \
		unzip \
		zip
}

function install::yay() {
	if ! [[ -x "$(command -v git)" ]]; then
		pacman -S git
	fi

	if ! [[ -x "$(command -v yay)" ]]; then
		cd /tmp/ || exit
		git clone https://aur.archlinux.org/yay-git.git yay
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
		chezmoi init --verbose --apply $dotfiles_location
		printf "chezmoi initialized with config applied"
	fi
}

function install::sdk() {
	if ! [[ -x "$(command -v sdk)" ]]; then
		curl -s "https://get.sdkman.io" | bash
	fi
}

function install::sdk_packages() {
	install::sdk

	sdk install gradle
	sdk install kotlin
	sdk install maven
}

function install::nvm() {
	if ! [[ -x "$(command -v nvm)" ]]; then
		curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
	fi
}

function install::dvm() {
	if ! [[ -x "$(command -v dvm)" ]]; then
		curl -fsSL https://dvm.deno.dev | bash
	fi
}

function install::rustup() {
	if ! [[ -x "$(command -v rustup)" ]]; then
		curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	fi
}

function install::cargo_packages() {
	install::rustup

	cargo install cargo-expand cargo-watch \
		stylua tidy-viewer tree-sitter-cli
	cargo install create-tauri-app --locked
	cargo install starship --locked
	cargo install cargo-insta
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

	python -m pipx install poetry sqlite-utils grip ansible trash-cli
	python -m pipx inject --include-apps ansible ansible-lint
	printf "Instructions for sqlite-utils:\n"
	printf "sqlite-utils install sqlean.py\nsqlite-utils install sqlite-dump"
}

function setup() {
	install::pacman_packages
	install::yay_packages
	install::cargo_packages
	install::sdk_packages
	install::cli_tools
	install::omb
	install::chezmoi
	install::nvm
	install::rustup
	install::astro
}

setup
