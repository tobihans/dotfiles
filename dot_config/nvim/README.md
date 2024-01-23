# Neovim configuration

My neovim conig based on [AstroNvim v4](https://github.com/AstroNvim/AstroNvim)

## 🛠️ Installation

You would need `chezmoi` to apply the configs.

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Clone the repository

```shell
chezmoi apply ~/.config/nvim
```

#### Start Neovim

```shell
nvim
```
