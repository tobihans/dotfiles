$env.config = {
    show_banner: false,
    rm: {
        always_trash: false,
    },
    # use_kitty_protocol: ($env.KITTY_WINDOW_ID? != null),
}

source aliases.nu
source commands.nu

# External utilities
use ~/.cache/starship/init.nu
source ~/.asdf/asdf.nu
source ~/.cache/atuin/init.nu
source ~/.cache/zoxide/init.nu
