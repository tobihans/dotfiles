function is::gitpod() {
  [[ -e /ide/bin/gitpod-code ]] && [[ -v GITPOD_REPO_ROOT ]]
}

function check::nvim_version() {
  version=$(command -v nvim && nvim -v | head -n 1 | cut -d ' ' -f2 | cut -d '-' -f 1)

  [[ "$version" == *"$1"* ]]
}

function install::omb() {
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" --unattended
}

function install::chezmoi() {
  if ! [[ -x "$(command -v chezmoi)" ]]
  then
    if is::gitpod
      sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply --verbose ${GITHUB_USERNAME:-tobihans}
    else
      sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init ${GITHUB_USERNAME:-tobihans}
      printf "chezmoi initialized: use diff and apply to finish the setup.\n"
    fi
  fi
}

function install::sdk() {
  if ! [[ -x "$(command -v sdk)" ]]
  then
    curl -s "https://get.sdkman.io" | bash
  fi
}

function install::nvm() {
  if ! [[ -x "$(command -v nvm)" ]]
  then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
  fi
}

function install::rustup() {
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
}

function install::neovim() {
  if ! check::nvim_version "0.8"
  then
    NVIM_RELEASE='https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.tar.gz'

    wget -cO /tmp/nvim.tar.gz $NVIM_RELEASE
    tar -xzvf /tmp/nvim.tar.gz -C ~
    mv ~/nvim-linux64 ~/nvim
  else
    printf "found nvim 0.8 installation.\n"
  fi
}

function install::astro() {
  mv ~/.config/nvim ~/.config/nvim.bak &>/dev/null &>/dev/null
  mv ~/.local/share/nvim/site ~/.local/share/nvim/site.bak &>/dev/null

  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
  git clone https://github.com/${GITHUB_USERNAME:-tobihans}/dotfiles ~/.config/nvim/lua/user

  nvim --headless +PackerSync +qa
}

