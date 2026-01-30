# Agentic Guidelines

This repository contains a Neovim configuration built on top of [AstroNvim](https://astronvim.com).

## Build, Lint, and Test Commands

Since this is a Neovim configuration, "building" implies valid Lua code that Neovim can load.

### Linting

This project uses `selene` for linting Lua code.

- **Run linting:** `selene .`
- **Configuration:** `selene.toml` (standard `neovim` ruleset, with some relaxed rules like `global_usage`, `multiple_statements`).
- **Globals:** `neovim.yml` defines allowed globals like `vim`, `Snacks`, and LuaSnip shortcuts (`s`, `t`, `i`).

### Formatting

Code formatting is handled by Stylua.
- **Run formatting:** `stylua .`
- **Configuration:** `stylua.toml` (if present, otherwise default). Note that `vim.opt.expandtab = true`, `shiftwidth = 2`, `tabstop = 4` are set in `lua/config/options.lua`.

### Testing

Tests are managed using `lazy.nvim` and presumably `neotest` (referenced in `lua/plugins/neotest.lua` and `astrocommunity.test.neotest`).
- **Run all tests:** `nvim --headless -c "PlenaryBustedDirectory tests/ { minimal_init = 'tests/minimal_init.lua' }"` (Standard Plenary pattern, check `tests/` directory if exists).
- **Run a single test:** Inside Neovim via `neotest` or using Plenary's command line with a specific file argument.

## Code Style and Conventions

### General Structure

- **Entry point:** `init.lua` bootstraps `lazy.nvim`.
- **Configuration:** Split into `lua/config/` (core options, lazy setup) and `lua/plugins/` (plugin specs).
- **Plugin Management:** Uses `lazy.nvim`. Plugin specifications return a table or a function returning a table.

### Lua Guidelines

- **Indentation:** 2 spaces.
- **Quotes:** Double quotes `"` are preferred over single quotes `'` (e.g., `require "config.lazy"`, `vim.opt.mouse = "a"`).
- **Function Calls:** Parentheses can be omitted for single string arguments (e.g., `require "module"`).
- **Global Variables:** Avoid global variables (`_G`) unless necessary. Use `local` variables.
- **Vim API:**
    - Use `vim.opt` for options (e.g., `vim.opt.relativenumber = true`).
    - Use `vim.g` for global variables (e.g., `vim.g.mapleader = ","`).
    - Use `vim.fn` for Vimscript functions.
    - Use `vim.api` for Neovim API calls.

### AstroNvim Specifics

- **Community Plugins:** Imported in `lua/config/lazy.lua` via `{ import = "astrocommunity..." }`. Specific configurations for community plugins (like Rust, JS/TS) are found in `lua/plugins/community.lua`.
- **Core Options:** `AstroCoreOpts` in `lua/plugins/init.lua` handles core features, diagnostics, sessions, and mappings.
- **LSP Configuration:** `AstroLSPOpts` in `lua/plugins/init.lua` or `lua/plugins/astrolsp.lua` handles LSP settings, formatting, and on_attach logic.
- **User Config:** Custom user configuration often resides in `lua/config/polish.lua` for imperative setup or `lua/config/options.lua`.

### Naming Conventions

- **Files:** snake_case (e.g., `lua/config/options.lua`).
- **Variables:** snake_case (e.g., `lazy_opts`).
- **Plugin Specs:** Return a table with short URL (e.g., `"author/repo"`) as the first element.

### Key Bindings

- Mappings are centrally managed in `lua/config/mappings/` or within `AstroCoreOpts`.
- Use `which-key.nvim` syntax for defining mappings (e.g., `desc` field is mandatory).
- Avoid overwriting standard Vim motions unless justified.

### Error Handling

- Use `pcall` (protected call) when requiring modules that might fail (e.g., `if not pcall(require, "lazy") then ... end`).
- Use `vim.notify` or `vim.api.nvim_echo` for user-facing error messages.

### Documentation

- Use EmmyLua annotations for types (e.g., `---@type LazySpec`, `---@param info table<string, any>`).
- Document function parameters and return types clearly using `---` comments.

### Autocommands

- Use `vim.api.nvim_create_augroup` to group related autocommands and avoid duplication.
- Use `vim.api.nvim_create_autocmd` for creating autocommands.

### Git Conventions

- This project doesn't contain a git repository. It's managed with [chezmoi](https://www.chezmoi.io/)
- Ensure `selene` passes before user adds it to his config.
