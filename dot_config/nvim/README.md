# Minimax

> [!WARNING]
> This is a personal WIP project. Expect breaking changes and rough edges.
> This repo will eventually be merged into my [dotfiles](https://github.com/tobihans/dotfiles) and archived.

A complete rewrite of my Neovim configuration from scratch, using only a minimal set of handpicked plugins. Built on [mini.nvim](https://github.com/echasnovski/mini.nvim) MiniMax template as the foundation, spiced with [snacks.nvim](https://github.com/folke/snacks.nvim).

## Setup

Nvim nightly is the default version this has been tested with.

```sh
# This is required since plugins use the gh:user/repo format.
git config --global url."https://github.com/".insteadOf "gh:"

# Clone config
git clone https://github.com/tobihans/minimax.git ~/.config/minimax

NVIM_APPNAME=minimax nvim
```
