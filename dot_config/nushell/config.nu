$env.config = {
    show_banner: false,
    rm: {
        always_trash: false,
    },
    hooks: {
        env_change: {
            PATH: [
                {
                    if ($env.PATH | describe) == "string" {
                        $env.PATH = ($env.PATH | split row (char esep) | uniq)
                    }
                }
            ],
            PWD: [
                (use integrations/hooks/nuenv.nu; nuenv setup),
                {
                    condition: {|_before, after|
                        (
                            (["poetry.lock", "uv.lock"] | any {|| $after | path join $in | path exists })
                            and ($after | path join ".venv/bin/activate.nu" | path exists)
                            and ($env.VIRTUAL_ENV? == null)
                        )
                    }
                    code: "$env.VIRTUAL_ENV_DISABLE_PROMPT = true; overlay use .venv/bin/activate.nu"
                },
                {
                    condition: {|_before, after| ($after | path join 'node_modules/.bin' | path exists) }
                    code: {
                        $env.PATH = (
                            $env.PATH
                            | prepend ($env.PWD | path join 'node_modules/.bin')
                            | uniq
                        )
                    }
                }
            ]
        }
    },
    keybindings: [
        {
            name: complete_history_hint
            modifier: shift
            keycode: backtab
            mode: emacs
            event: {
                send: historyhintcomplete,
            }
        },
        {
            name: pet_snippets
            modifier: control
            keycode: char_s
            mode: emacs
            event: {
                send: executehostcommand,
                cmd: "try { pet-search }"
            }
        },
        {
            name: television
            modifier: control
            keycode: char_f
            mode: emacs
            event: {
                send: executehostcommand,
                cmd: "try { television }"
            }
        }
    ],
}

source aliases.nu
source commands.nu
source integrations/completions/cargo-make.nu
source integrations/completions/docker.nu
source integrations/completions/git.nu
source integrations/completions/gh.nu
source integrations/completions/just.nu
source integrations/completions/make.nu
source integrations/completions/ssh.nu
source integrations/completions/tar.nu
source integrations/completions/virsh.nu
source integrations/hooks/rusty-paths.nu


# External utilities
use integrations/mise.nu # WARN: Should come before anything.
use integrations/starship.nu
use integrations/hooks/nuenv.nu [ "nuenv allow", "nuenv disallow" ]
source integrations/atuin.nu # WARN: Keep empty on Windows.
