# Setup runbook

How this repo behaves on a fresh machine and what to do afterwards.

## What runs on `chezmoi init --apply`

Deliberately minimal — exactly two scripts:

| Script | When | Does |
|---|---|---|
| `run_once_before_001-decrypt-private-key.sh` | first apply only | Prompts for the **age-key passphrase**, decrypts `key.txt.age` to `~/.config/chezmoi/key.txt` so encrypted (`private_*`) files can be applied. |
| `run_onchange_setup.sh` | when its rendered content changes | Package convergence per OS (see below) + regenerates nushell integration scripts. |

Everything else is plain file placement. External downloads (nushell completion
scripts, zellij plugin, VictorMono on Linux) are handled by
`.chezmoiexternals/` with their own refresh periods.

### What the setup script does per OS

- **macOS**: prints a reminder to run `brew bundle` manually (deliberately **not**
  executed during apply — it takes many minutes and first-run setup must stay
  fast). Homebrew itself is a prerequisite; see manual steps below.
- **Linux (Arch-based)**:
  1. `pacman -Syu --needed` in one batch: missing base requirements
     (`age curl git unzip zip`, `base-devel`, `paru`), then mise via
     `curl https://mise.run | sh` if absent.
  2. One batched `pacman` pass for the package list and one batched `paru`
     pass for the AUR list (`atuin`, `fswatch`, …).
  3. Non-Arch Linux: package steps are skipped.
- **Desktop-gated extras**: GUI packages (chromium, kitty, keepassxc, zoom, …)
  are only installed when `XDG_CURRENT_DESKTOP` is set. Headless/SSH setup
  silently skips them — that is expected.

## Prerequisites (before the one-liner)

- **macOS**: install [Homebrew](https://brew.sh) first. Your `~/.zprofile`
  assumes `/opt/homebrew/bin/brew` exists.
- **Any machine building AUR/cargo packages**: have `rustup` available
  (paru AUR builds and `mise`'s `cargo:` backends may need a Rust toolchain).
- Git credentials so `chezmoi update` can pull (HTTPS token or SSH key).

## Manual steps after first apply

1. **macOS**: install your packages when you have time to wait:
   `brew bundle --file ~/.local/share/chezmoi/dot_Brewfile`
   (idempotent; safe to re-run after editing the Brewfile).
2. **Install language/runtime tools**: `mise install`
   (~60 tools: node, ruby, LSPs, CLIs from `~/.config/mise/config.toml`).
3. **Set nushell as your login shell** (so terminals *and* TTYs start in `nu`;
   zsh/bashrc stay installed as fallbacks; do this once `nu` exists — automatic
   on Linux after apply, after step 1 on macOS):
   ```bash
   grep -qxF "$(command -v nu)" /etc/shells || echo "$(command -v nu)" | sudo tee -a /etc/shells
   chsh -s "$(command -v nu)"
   ```
   (macOS: brew installs `nu` but never registers it in `/etc/shells` itself.)
4. **Linux only**: enable the ssh-agent systemd unit:
   `systemctl --user enable --now ssh-agent.service`
5. **Linux only, if you want AudioRelay**: run `~/.audiorelay/setup.sh`
   (downloads the app, creates the .desktop entry).
6. **macOS only**: select the Victor Mono Nerd Font (installed via the
   `font-victor-mono` cask) in Ghostty/terminal if it isn't picked up.
7. **KeePassXC-Browser**: import `keepassxc-browser_settings.json` (kept
   unmanaged in the repo root on purpose) into your browser.
8. **Karabiner (macOS)**: `~/.config/karabiner/karabiner.json` is applied by
   chezmoi; grant Input Monitoring / Accessibility permissions when prompted.
9. Sign into tools that sync their own state (atuin, gh, glab).

## Keeping things updated

- **Config changes**: `chezmoi cd` → edit → `chezmoi apply` (or commit here and
  `chezmoi update`).
- **Add a package**: edit the list in `.chezmoitemplates/setup/` →
  `chezmoi apply` (the rendered script changes, so it re-runs).
- **Tool/upstream updates** (deliberately *not* part of apply):
  `~/.local/bin/sysupdate.sh` — pulls the repo, `mise plugins update &&
  mise up`, `bob update --all`, `tv update-channels`, regenerates the
  atuin/starship nushell integrations.

## Encrypted files

Anything matching `private_*` (zed settings, karabiner, nvim spells/colors)
is age-encrypted. Config lives in `~/.config/chezmoi/chezmoi.toml`
(identity: `~/.config/chezmoi/key.txt`).

**Rotating the age key**: generate a new identity, re-encrypt `key.txt.age`
with the new passphrase, update `recipient` in
`dot_config/chezmoi/chezmoi.toml.tmpl`, then on each machine delete
`~/.config/chezmoi/key.txt` and run `chezmoi apply` (the before-script
re-decrypts it). Re-encrypt changed `private_*` files with
`chezmoi add --encrypt <path>`.

## Windows

Not yet supported — tracked separately (planned merge of
`tobihans/win-dotfiles` into this repo).
