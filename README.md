# My dotfiles

This repository contains my dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Requirements

- OS: Arch-based Linux, macOS, or Windows
- macOS: [Homebrew](https://brew.sh) installed first (the setup script will not bootstrap it)
- Windows: [scoop](https://scoop.sh), then `scoop install main/nu main/git main/chezmoi`, and `XDG_CONFIG_HOME=%USERPROFILE%\.config` in your user environment. You also decrypt the age identity manually — see docs
- `rustup` in PATH if you build cargo-based packages (AUR builds via paru, `mise cargo:` tools)

## Setup

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/tobihans/dotfiles.git
```

On macOS and Linux you will be prompted once for the age-key passphrase.

On Windows nothing prompts you: install chezmoi with `scoop install main/chezmoi`
(or `iex "&{$(irm 'https://get.chezmoi.io/ps1')}"`), then decrypt the age
identity once by hand before the encrypted files can apply — no setup script runs
there. See the Windows section of the runbook for the exact command.

See [docs/setup.md](docs/setup.md) for the full runbook: what runs when,
manual steps after first install, and how to keep things updated
(`~/.local/bin/sysupdate.sh`).
