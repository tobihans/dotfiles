# Windows package convergence for scoop.sh — run it by hand, never from apply.
#
#   nu ~/.local/bin/install-packages.nu
#
# chezmoi does not execute this: keeping package installs out of `chezmoi apply`
# is the whole point (docs/setup.md). scoop skips apps that are already
# installed, so re-running after you edit the list is cheap.
#
# Prereqs on a fresh box: scoop itself, then `scoop bucket add main` (default),
# `scoop install main/nu main/git main/chezmoi extras/vcredist2022`.

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
    main/msys2
    main/neofetch
    main/nu
    main/php
    main/pipx
    main/poetry
    main/ripgrep
    main/unzip
    main/vim
    main/wget
    main/xz
    main/zig
    nerd-fonts/VictorMono-NF-Mono
    versions/lua51
    versions/python312
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

# `scoop bucket add` warns and exits non-zero when the bucket already exists;
# do -i keeps that expected case from aborting the loop.
$buckets | each {|b| do -i { scoop bucket add $b } }

scoop install ...$packages
