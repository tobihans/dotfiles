$env.config = {
    show_banner: false,
}
source $"($nu.default-config-dir)/aliases.nu"

# External utilities
use ~/.cache/starship/init.nu

source ~/.asdf/asdf.nu
source ~/.cache/zoxide/init.nu
