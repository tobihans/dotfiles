# My dotfiles

This repository contains my dotfiles managed by [chezmoi](https://github.com/twpayne/chezmoi).

## Requirements

- OS: _Arch_ based OS or MacOS

## Setup

- One line

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/tobihans/dotfiles.git
```

- Script

```bash
dotfiles_location='https://github.com/tobihans/dotfiles.git'

if ! [[ -x "$(command -v chezmoi)" ]]; then
    sudo pacman -Syu chezmoi
    chezmoi init --verbose --apply $dotfiles_location
fi
```
