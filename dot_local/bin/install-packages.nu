# Windows package convergence for scoop.sh — run it by hand, never from apply.
#
#   nu ~/.local/bin/install-packages.nu              # converge
#   nu ~/.local/bin/install-packages.nu --preview    # show the plan, install nothing
#
# chezmoi does not execute this: keeping package installs out of `chezmoi apply`
# is the whole point (docs/setup.md). scoop skips apps that are already
# installed, so re-running after you edit the list is cheap.
#
# Prereqs on a fresh box: scoop itself, then `scoop install main/nu main/git
# main/chezmoi`. Two entries below are load-bearing rather than taste:
# extras/vcredist2022 because main/btop (and others) list it under "suggest", and
# main/mise because the docs' `mise install` step needs mise and scoop is the only
# thing that would provide it.

let buckets = [
    extras
    nerd-fonts
    nonportable
    versions
]

# Kept in one array so the install is a single scoop call.
let packages = [
    extras/filelight
    extras/kdeconnect
    extras/keepassxc
    extras/neovide
    extras/obsidian
    extras/powertoys
    extras/vcredist2022
    extras/vscode
    extras/zoom
    main/7zip
    main/bat
    main/btop
    main/composer
    main/deno
    main/eza
    main/fd
    main/ffmpeg
    main/fzf
    main/gdu
    main/gcc
    main/gh
    main/git
    main/go
    main/gsudo
    main/gzip
    main/innounp
    main/jq
    main/luarocks
    main/make
    main/mise
    main/msys2
    main/neofetch
    main/nu
    main/php
    main/ripgrep
    main/unzip
    main/vim
    main/wget
    main/xz
    main/zig
    nerd-fonts/VictorMono-NF-Mono
    versions/lua51
]

# Provided by mise (dot_config/mise/config.toml). Kept here, commented out, as
# the fallback: if `mise install` fails for one of these on Windows, uncomment it
# and scoop owns the binary instead. Right column = the mise tool spec.
# main/starship    -> cargo:starship
# main/just        -> cargo:just
# main/stylua      -> cargo:stylua
# main/tree-sitter -> cargo:tree-sitter-cli
# main/neovim      -> cargo:bob-nvim (bob builds nvim; uncomment to drop bob)
# main/lazygit     -> github:jesseduffield/lazygit
# extras/lazygit   -> github:jesseduffield/lazygit
# main/lazydocker  -> github:jesseduffield/lazydocker
# main/hurl        -> github:Orange-OpenSource/hurl
# main/nodejs-lts  -> node
# extras/pet       -> github:knqyf263/pet

# Dropped on purpose: versions/python312, main/pipx and main/poetry. Python and the
# pipx backend come from mise, and a second scoop python only starts a PATH fight
# with mise's shims (PATH order is documented in docs/setup.md).

def main [--preview] {
    if $preview {
        let count = ($packages | length)
        print $"buckets: ($buckets | str join ', ')"
        print $"packages ($count):"
        print ($packages | str join "\n")
        return
    }

    # `scoop bucket add` warns and exits non-zero when the bucket already exists;
    # do -i keeps that expected case from aborting the loop.
    $buckets | each {|b| do -i { scoop bucket add $b } }

    scoop install ...$packages
}
