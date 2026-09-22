# --- Linux base requirements (Arch) ---
# Fragment rendered into run_onchange_setup.sh.tmpl; caller guards on .chezmoi.os.

if [[ ! -f /etc/arch-release ]]; then
	echo "[setup] not Arch based, skipping linux base."
else
	base_pkgs=()
	for requirement in age curl git unzip zip; do
		command -v "$requirement" >/dev/null 2>&1 || base_pkgs+=("$requirement")
	done
	pacman -Qqi "base-devel" >/dev/null 2>&1 || base_pkgs+=("base-devel")
	# paru replaces yay: shipped in the official repos, so no AUR bootstrap.
	command -v paru >/dev/null 2>&1 || base_pkgs+=("paru")
	if ((${#base_pkgs[@]})); then
		sudo pacman -Syu --needed --noconfirm "${base_pkgs[@]}"
	fi

	if ! command -v mise >/dev/null 2>&1; then
		curl https://mise.run | sh
		mkdir -p "{{ .chezmoi.homeDir }}/.config/mise"
		cp "{{ .chezmoi.sourceDir }}/dot_config/mise/config.toml" "{{ .chezmoi.homeDir }}/.config/mise/config.toml"
	fi
fi
