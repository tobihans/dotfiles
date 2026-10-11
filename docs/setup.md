# Setup runbook

How this repo behaves on a fresh machine and what to do afterwards.

## What runs on `chezmoi init --apply`

Deliberately minimal — two scripts on macOS/Linux, **zero on Windows**:

| Script                                       | When                              | Does                                                                                                                                           |
| -------------------------------------------- | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| `run_once_before_001-decrypt-private-key.sh` | first apply only                  | Prompts for the **age-key passphrase**, decrypts `key.txt.age` to `~/.config/chezmoi/key.txt` so encrypted (`private_*`) files can be applied. |
| `run_onchange_setup.sh`                      | when its rendered content changes | Package convergence per OS (see below). It does **not** regenerate nushell integrations — those render from `.chezmoitemplates/` on every apply.                |

Everything else is plain file placement. External downloads (the nushell
completion scripts from `nu_scripts` and, on Linux, the VictorMono Nerd Font) are
handled by `.chezmoiexternals/` with their own refresh periods.

### What the setup script does per OS

- **macOS**: prints a reminder to run `brew bundle` manually (deliberately **not**
  executed during apply — it takes many minutes and first-run setup must stay
  fast). Homebrew itself is a prerequisite; see manual steps below.
- **Linux (Arch-based)**:
  1. `pacman -Syu --needed` in one batch: missing base requirements
     (`age curl git mise unzip zip`, `base-devel`, `paru`).
  2. One batched `pacman` pass for the package list and one batched `paru`
     pass for the AUR list (`atuin`, `fswatch`, …).
  3. Non-Arch Linux: package steps are skipped.
- **Desktop-gated extras (Linux)**: GUI packages (chromium, kitty, keepassxc, zoom, …)
  are only installed when `XDG_CURRENT_DESKTOP` is set. Headless/SSH setup
  silently skips them — that is expected.
- **Windows**: nothing. Both bash scripts are unmanaged there (chezmoi has no `.sh`
  interpreter on Windows), so package installs and the age-key decrypt are manual —
  see the Windows section at the end of this runbook.

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
3. **Getting `nu` on shell start** — no system change needed: the Ghostty
   config in these dotfiles already runs it per window:
   ```ini
   # ~/.config/ghostty/config
   command = /opt/homebrew/bin/nu   # macOS/brew path; /usr/bin/nu on Arch
   ```
   Set your terminal emulator's startup command to `nu` the same way (kitty:
   `shell` in its config). `chsh -s $(command -v nu)` (plus registering it in
   `/etc/shells`) is **optional** — only if you also want raw TTY/logins to
   start in nushell. zsh/bashrc stay installed as fallbacks either way.
4. **Linux only**: enable the ssh-agent systemd unit:
   `systemctl --user enable --now ssh-agent.service`
5. **macOS only**: select the Victor Mono Nerd Font (installed via the
   `font-victor-mono` cask) in Ghostty/terminal if it isn't picked up.
6. **Karabiner (macOS)**: `~/.config/karabiner/karabiner.json` is applied by
   chezmoi; grant Input Monitoring / Accessibility permissions when prompted.
7. Sign into tools that sync their own state (atuin, gh, glab).

## Keeping things updated

- **Config changes**: `chezmoi cd` → edit → `chezmoi apply` (or commit here and
  `chezmoi update`).
- **Add a package**: edit the list in `.chezmoitemplates/setup/` →
  `chezmoi apply` (the rendered script changes, so it re-runs).
- **Tool/upstream updates** (deliberately _not_ part of apply):
  `~/.local/bin/sysupdate.sh` — pulls the repo, `mise plugins update &&
mise up`, `bob update --all`, `tv update-channels`. Nushell hooks
  (atuin/starship/mise/nuenv) are rendered from templates at every apply.

## Encrypted files

Anything with a `private_` prefix is age-encrypted: the nvim `colors`, `spell`,
`after/lsp` and `after/queries` directories, `glow`, `karabiner`, `pet`, and
`dot_pi/agent/extensions/private_rtk.ts`. Config lives in
`~/.config/chezmoi/chezmoi.toml` (identity: `~/.config/chezmoi/key.txt`).

**Rotating the age key**: generate a new identity, re-encrypt `key.txt.age`
with the new passphrase, update `recipient` in
`dot_config/chezmoi/chezmoi.toml.tmpl`, then on each machine delete
`~/.config/chezmoi/key.txt` and run `chezmoi apply` — on macOS/Linux the
before-script re-decrypts it, on Windows you must re-run the `chezmoi age
decrypt` command from the Windows section because that script is not managed
there. Re-encrypt changed `private_*` files with `chezmoi add --encrypt <path>`.

## Windows

Windows is supported through the same source tree: chezmoi writes
`%USERPROFILE%\.config\**` for every `dot_config/**` entry, and the tools you
use there read that location too.

### Prerequisites (in order, before the one-liner)

1. **scoop** — <https://scoop.sh> (per its README, in a PowerShell window).
2. `scoop bucket add main` is implicit; then
   `scoop install main/nu main/git main/chezmoi`
   (`chezmoi` is also installable with `iex "&{$(irm 'https://get.chezmoi.io/ps1')}"`).
3. **Set `XDG_CONFIG_HOME`** to `%USERPROFILE%\.config` in _Edit user
   environment variables_ and open a new terminal. This is what lets nushell,
   Neovim, television and lazygit/lazydocker read the shared `~/.config` tree
   instead of `%APPDATA%`/`%LOCALAPPDATA%`. Without it those tools look in
   AppData and will not see your configs.
4. Optional: Windows Terminal from the Store, and rustup if you want
   `cargo:`/`github:` mise builds.

**Nothing will prompt you for the age-key passphrase here.** On macOS/Linux
`run_once_before_001-decrypt-private-key.sh` asks for it on the first apply; that
script is not managed on Windows, so the identity must be decrypted by hand — see
step 1 of "First apply" below. It cannot be a prerequisite, because it reads
`key.txt.age` out of the clone `chezmoi init` creates.

### First apply

```powershell
chezmoi init --apply https://github.com/tobihans/dotfiles.git
```

**No chezmoi script runs on Windows.** The bash setup dispatcher and the age-key
bootstrap are skipped there (chezmoi has no `.sh` interpreter on Windows), so two
steps are manual:

```powershell
# 1. decrypt the age identity once, before private_* files can be applied
chezmoi age decrypt --output "$HOME\.config\chezmoi\key.txt" --passphrase "$HOME\.local\share\chezmoi\key.txt.age"

# 2. apply again
chezmoi apply
```

Skipping step 1 is not silent: `chezmoi apply` fails on the encrypted files it
does manage here — nvim `colors`, `spell`, `after/lsp`, `after/queries` — until
the identity exists. (`pet`, `glow` and `karabiner` are also encrypted but are
not applied on Windows at all, so they cannot fail.) Re-run `chezmoi apply` after
fixing it.

### Then, in order

```nu
nu ~/.local/bin/install-packages.nu   # scoop convergence: buckets + one batched install
mise install                          # ~60 tools from ~/.config/mise/config.toml
```

`install-packages.nu` is a managed file that chezmoi never executes. Apps mise
also provides are commented out inside it — uncomment one only if that
`mise install` fails on Windows and you want scoop to own the binary instead.
Run `nu ~/.local/bin/install-packages.nu --preview` to see the resolved buckets
and package list without installing anything.

**Who wins a PATH fight — scoop or mise:** inside nushell it is **mise**. The
integration rendered into `.config/nushell/vendor/autoload/mise.nu` runs
`mise activate nu`, which prepends mise's own tool directories every time nu
starts, so a mise-managed tool (starship, lazygit, television, bob) resolves to
mise's copy there even though scoop put `%USERPROFILE%\scoop\shims` on the
machine PATH first. In pwsh or cmd there is no `mise activate`, so **scoop wins**
and a tool that only mise provides is simply not on PATH — which is why
`install-packages.nu` keeps those apps commented out instead of half-installing
them. Check what a shell actually resolves with `which starship` (nu) or
`Get-Command starship` (pwsh).

### Manual leftovers on Windows

- **Windows Terminal settings** stay machine-local (`settings.json` is not in
  this repo). Set its startup command to `nu` if you want nu on launch.
- **Nerd font**: `install-packages.nu` adds the `nerd-fonts` bucket and installs
  `VictorMono-NF-Mono`; select it in the terminal profile if it is not picked up.
- **pwsh 7 vs Windows PowerShell 5.1**: the profile here is applied to
  `Documents\PowerShell\`, which only pwsh 7 reads. For 5.1 either
  `scoop install main/powershell` or add
  `Documents\WindowsPowerShell\profile.ps1` containing
  `. "$HOME\Documents\PowerShell\profile.ps1"`.
- **Execution policy**: `Documents\PowerShell\powershell.config.json` sets
  CurrentUser `RemoteSigned`. If you would rather not track that in the repo,
  delete the file and run `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`.
- **Git credentials**: check that `%APPDATA%\Git\config` does not exist — Git for
  Windows prefers it over the managed `~/.config/git/config`.
- **`nu` on start**: same story as other OSes — set the terminal's startup
  command to `nu` (see step 3 above); `scoop` puts shims on PATH.

### Deliberately not ported to Windows

The old `win-dotfiles` repo's nushell `env.nu` (nushell's own boilerplate), its
`Documents/PowerShell/config/starship.toml` (starship never reads that path —
`%LOCALAPPDATA%`/`%APPDATA%` are not consulted), its external downloads from
this repo (6 of them were already 404 — the source tree now holds one copy of
every file), `run_before_base.nu` (mkdir — chezmoi creates parent dirs),
`run_after_all.nu` (starship/mise/atuin integrations render from templates),
`run_after_update_dots.nu` (nvim tarball rename hack), and its
`interpreters.ps1 = nu` config hack plus the tracked destination
`chezmoi.toml`.

### Known Windows gaps (open, tracked in `plans/windows-support.md`)

- **Skipped by design on Windows** (their configs are not applied there, because
  those tools do not read `~/.config` on Windows): `bob` (`%APPDATA%\bob`),
  `pet` (`%APPDATA%\pet`), `glow` (`%AppData%\glow`). Re-enable one by removing
  it from `.chezmoitemplates/ignore/on-windows` and adding either an AppData
  wrapper or an absolute `BOB_CONFIG` / `PET_CONFIG_DIR` / `GLOW_CONFIG` override.
- **Unverified paths**: `neovide/config.toml` and `luacheck` are applied under
  `~/.config`; confirm they are read on Windows before relying on them.
- Neovim has never been booted from this config on Windows — the Lua config may
  assume Unix paths or `!` shell commands.
- Encrypted files that _are_ applied on Windows (nvim `private_colors`,
  `private_spell`) need the age identity from step 1 above.
- `sysupdate.sh` and `launch_editor.sh` are bash and not managed on Windows; use
  `scoop update *`, `mise up`, `nu ~/.local/bin/install-packages.nu` instead.
- Nothing has been applied on real Windows yet — run the checklist in
  `plans/windows-support.md` on a Windows VM or fresh user profile.

