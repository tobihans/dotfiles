$env.HOME_BIN = $"($env.HOME)/bin"
$env.HOME_LOCAL_BIN = $"($env.HOME)/.local/bin"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.HOME_BIN)
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.HOME_LOCAL_BIN)

# Pnpm
$env.NODE_OPTIONS = "--disable-warning=ExperimentalWarning --disable-warning=DeprecationWarning"
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
# Cargo
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")
# Turso
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.turso")
## Bob nvim
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/share/bob/nvim-bin")
# Jetbrains Toolbox
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/share/JetBrains/Toolbox/scripts")

# Editing
$env.EDITOR = 'nvim'
$env.LAUNCH_EDITOR = "launch_editor.sh"
# Git
$env.GCM_CREDENTIAL_STORE = "secretservice"
$env.FZF_DEFAULT_OPTS = "
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
--color=selected-bg:#494d64
--multi"
$env.LESS = '--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
$env.MANPAGER = 'bat -l man --italic-text always --decorations always --style=numbers,grid'

$env.SSH_AUTH_SOCK = (head -n 1 ~/.ssh/tmp)
$env.SSH_AGENT_PID = (tail -n 1 ~/.ssh/tmp)

$env.SHELL = '/bin/nu'
