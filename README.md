# My dotfiles

This repository contains my dotfiles managed by [chezmoi](https://www.chezmoi.io/).

## Requirements

- OS: Arch-based Linux or macOS
- macOS: [Homebrew](https://brew.sh) installed first (the setup script will not bootstrap it)
- `rustup` in PATH if you build cargo-based packages (AUR builds via paru, `mise cargo:` tools)

## Setup

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/tobihans/dotfiles.git
```

You will be prompted once for the age-key passphrase.

See [docs/setup.md](docs/setup.md) for the full runbook: what runs when,
manual steps after first install, and how to keep things updated
(`~/.local/bin/sysupdate.sh`).
