# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
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
$env.ANDROID_HOME = $"($env.HOME)/Android/Sdk"
let tools = [cmdline-tools/latest/bin emulator platform-tools tools]
$tools | each { |tool| $env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.ANDROID_HOME)/$($tool)") }

# TODO: Update this section
# mkdir ~/Android/Sdk/ndk
# LATEST_NDK_VERSION=$(ls -l "$ANDROID_HOME"/ndk/ | awk '{print $NF}' | sort -n | tail -n 1)
# export NDK_HOME="$ANDROID_HOME/ndk/$LATEST_NDK_VERSION"

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


# Editing
$env.EDITOR = 'nvim'
$env.LAUNCH_EDITOR = "launch_editor.sh"
## Bob nvim
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/share/bob/nvim-bin")
# Jetbrains Toolbox
$env.PATH = ($env.PATH | split row (char esep) | prepend $"($env.HOME)/.local/share/JetBrains/Toolbox/scripts")

# Git
$env.GCM_CREDENTIAL_STORE = "secretservice"

$env.ASDF_DIR = $"($env.HOME)/.asdf"

$env.LESS = '--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4 --no-init --window=-4'
$env.MANPAGER = 'bat -l man --italic-text always --decorations always --style=numbers,grid'

$env.SSH_AUTH_SOCK = (head -n 1 ~/.ssh/tmp)
$env.SSH_AGENT_PID = (tail -n 1 ~/.ssh/tmp)

$env.PET_GITHUB_ACCESS_TOKEN = (get_develop_secret PET_SNIPPET_SYNC)
$env.GEMINI_API_KEY = (get_develop_secret GEMINI_API_KEY)


# NOTE: This should always come last, to ensure we remove duplicates.
$env.PATH = ($env.PATH | uniq)
