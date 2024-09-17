$env.config = {
    show_banner: false,
    rm: {
        always_trash: false,
    },
    keybindings: [
        {
            name: search_snippets_with_pet
            modifier: control
            keycode: char_s
            mode: emacs
            event: {
                send: executehostcommand,
                cmd: "pet-search"
            }
        }
    ],
}

source aliases.nu
source commands.nu
source integrations/completions/docker.nu
source integrations/completions/git.nu
source integrations/completions/just.nu
source integrations/completions/make.nu
source integrations/completions/ssh.nu
source integrations/completions/virsh.nu

# External utilities
use ~/.cache/starship/init.nu
source ~/.asdf/asdf.nu
source ~/.cache/atuin/init.nu
source ~/.cache/zoxide/init.nu
