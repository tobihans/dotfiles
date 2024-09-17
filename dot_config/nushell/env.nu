$env.HOME_BIN = $"($env.HOME)/bin"
$env.HOME_LOCAL_BIN = $"($env.HOME)/.local/bin"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.HOME_BIN)
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.HOME_LOCAL_BIN)
# Pnpm
$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.PNPM_HOME)
# Go
$env.GOBIN = $"($env.HOME)/go/bin"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.GOBIN)
# Android
( /bin/mkdir -p ~/Android/Sdk/ndk )
$env.ANDROID_HOME = $"($env.HOME)/Android/Sdk"
let tools = [cmdline-tools/latest/bin emulator platform-tools tools]
$tools | each { |tool| $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.ANDROID_HOME)/$($tool)") }
$env.LATEST_NDK_VERSION = (/bin/ls -l $"($env.ANDROID_HOME)/ndk/" | awk '{print $NF}' | sort -n | tail -n 1)
$env.NDK_HOME = $"($env.ANDROID_HOME)/ndk/($env.LATEST_NDK_VERSION)"
$env.FLUTTER_BIN = $"($env.HOME)/flutter/bin"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.FLUTTER_BIN)
# Deno
# TODO: Remove once I replace all this with asdf/mise
$env.DVM_DIR = $"($env.HOME)/.dvm"
$env.DENO_BIN = $"($env.HOME)/.deno/bin"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.DVM_DIR)
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.DENO_BIN)
# Cargo
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")
# Turso
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.turso")
## Bob nvim
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/share/bob/nvim-bin")
# Jetbrains Toolbox
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/share/JetBrains/Toolbox/scripts")

# NOTE: Always deduplicate.
$env.PATH = ($env.PATH | uniq)

# Editing
$env.EDITOR = 'nvim'
$env.LAUNCH_EDITOR = "launch_editor.sh"
# Git
$env.GCM_CREDENTIAL_STORE = "secretservice"
$env.ASDF_DIR = $"($env.HOME)/.asdf"
$env.FZF_DEFAULT_OPTS = "
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf 
--color=marker:#babbf1,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284 
--color=selected-bg:#51576d 
--multi"
$env.LESS = '--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
$env.MANPAGER = 'bat -l man --italic-text always --decorations always --style=numbers,grid'

$env.SSH_AUTH_SOCK = (head -n 1 ~/.ssh/tmp)
$env.SSH_AGENT_PID = (tail -n 1 ~/.ssh/tmp)

$env.SHELL = '/bin/nu'
