$env.HOME_BIN = $"($env.HOME)/bin"
$env.HOME_LOCAL_BIN = $"($env.HOME)/.local/bin"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.HOME_BIN)
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.HOME_LOCAL_BIN)

# Node
# $env.NODE_OPTIONS = "--disable-warning=ExperimentalWarning --disable-warning=DeprecationWarning"
$env.COREPACK_ENABLE_AUTO_PIN = 0
$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.PNPM_HOME)

# Go
$env.GOBIN = $"($env.HOME)/go/bin"
$env.PATH = ($env.PATH | split row (char esep) | prepend $env.GOBIN)

# Android
(/bin/mkdir -p ~/Android/Sdk/ndk)
$env.ANDROID_HOME = $"($env.HOME)/Android/Sdk"

let tools = [cmdline-tools/latest/bin emulator platform-tools tools]
for $tool in $tools {
  $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.ANDROID_HOME)/($tool)")
}

$env.LATEST_NDK_VERSION = (ls $"($env.ANDROID_HOME)/ndk/" | get name | path basename | sort -r | get -o 0)
$env.NDK_HOME = $"($env.ANDROID_HOME)/ndk/($env.LATEST_NDK_VERSION)"
$env.CHROME_EXECUTABLE = "/usr/bin/chromium"

# Cargo
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.cargo/bin")

## Bob nvim
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/share/bob/nvim-bin")

# Jetbrains Toolbox
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/share/JetBrains/Toolbox/scripts")

# Editing
$env.EDITOR = 'nvim'
$env.LAUNCH_EDITOR = "launch_editor.sh"

# Git
$env.GCM_CREDENTIAL_STORE = "secretservice"

# Fzf
# Catppuccin
$env.FZF_DEFAULT_OPTS = "
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796
--color=selected-bg:#494d64
--multi"
# Rose-Pine
# $env.FZF_DEFAULT_OPTS = "
# 	--color=fg:#908caa,bg:#232136,hl:#ea9a97
# 	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
# 	--color=border:#44415a,header:#3e8fb0,gutter:#232136
# 	--color=spinner:#f6c177,info:#9ccfd8
# 	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
#     --multi"

# Paging
$env.LESS = '--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
$env.MANPAGER = 'bat -l man --italic-text always --decorations always --style=numbers,grid'

# Goose
$env.GOOSE_CLI_THEME = "ansi"

# DoNotTrack
$env.DO_NOT_TRACK = 1
$env.GLAB_SEND_TELEMETRY = false
