# --- Linux package convergence (pacman + AUR/paru) ---
# Fragment rendered into run_onchange_setup.sh.tmpl; caller guards on .chezmoi.os.
# Merged from the old run_onchange_linux_002-pacman.sh / 003-yay.sh.
# base-devel + paru are installed by setup/linux_base.sh.

if [[ ! -f /etc/arch-release ]]; then
	echo "[setup] not Arch based, skipping linux packages."
else
	packages=(
		"bat" "btop"
		"chezmoi" "cmake" "composer" "cryfs" "curl"
		"docker" "docker-buildx" "docker-compose"
		"fd" "ffmpeg" "fzf"
		"gdu" "git" "github-cli" "glab" "go"
		"jq"
		"lua51" "luarocks"
		"m4" "make" "mise" "mosh"
		"ninja" "nushell"
		"onefetch" "openssh" "openssl"
		"pigz" "postgresql-libs" "protobuf"
		"ripgrep"
		"unzip"
		"zip"
		"wget"
	)
	# "php" "php-apache" "php-cgi" "php-embed" "php-fpm" "php-gd" "php-igbinary" "php-redis" "php-snmp"
	# "firefox-developer-edition"
	# "onlyoffice-desktopeditors"

	aur_packages=(
		"atuin" "fswatch"
	)

	if [[ -n "${XDG_CURRENT_DESKTOP}" ]]; then
		packages+=(
			"android-tools" "android-udev" "appmenu-gtk-module"
			"chromium"
			"gtk3"
			"keepassxc" "kimageformats" "kitty"
			"libappindicator-gtk3" "librsvg" "libvips"
			"remmina"
			"scrcpy"
			"webkit2gtk"
			"xdg-desktop-portal-gtk"
		)
		aur_packages+=(
			"opensnitch" "python-pyclip"
			"trash-cli"
			"wl-clipboard"
			"koi"
			"zoom" "zen-browser-bin"
		)
		# "plasma5-wallpapers-dynamic"
		# "supertuxkart"
		# "slack-desktop"
		# "waydroid"
		# Optional WPS Office deps: wps-office libtiff5 ttf-wps-fonts ttf-ms-fonts wps-office-fonts wps-office-mime
	fi

	missing=()
	for package in "${packages[@]}"; do
		pacman -Qqi "$package" >/dev/null 2>&1 || missing+=("$package")
	done
	if ((${#missing[@]})); then
		echo "[setup] installing via pacman: ${missing[*]}"
		sudo pacman -Syu --needed --noconfirm "${missing[@]}"
	else
		echo "[setup] pacman packages [all installed]"
	fi

	if command -v paru >/dev/null 2>&1; then
		missing_aur=()
		for package in "${aur_packages[@]}"; do
			paru -Qqi "$package" >/dev/null 2>&1 || missing_aur+=("$package")
		done
		if ((${#missing_aur[@]})); then
			echo "[setup] installing via paru: ${missing_aur[*]}"
			paru -Syu --needed --noconfirm --answerdiff None --answerclean None "${missing_aur[@]}"
		else
			echo "[setup] AUR packages [all installed]"
		fi
	else
		echo "[setup] paru not available, skipping AUR packages: ${aur_packages[*]}"
	fi
fi
