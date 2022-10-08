#!/usr/bin/env bash

# Setup.sh
# Configure my new machines and gitpod environments

source ./tools.sh

if is::gitpod
  install::omb
  install::neovim
  install::astro
  install::chezmoi
  exit
fi

  install::omb
  install::chezmoi
  install::sdk
  install::nvm
  install::rustup
  install::neovim
  install::astro

