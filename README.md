# My dotfiles

This repository contains my managed dotfiles.
Based on [chezmoi](https://github.com/twpayne/chezmoi).

## Setup

```bash
dotfiles_location='https://github.com/tobihans/dotfiles.git'

if ! [[ -x "$(command -v chezmoi)" ]]; then
    sudo pacman -Syu chezmoi
    chezmoi init --verbose --apply $dotfiles_location
fi
```
