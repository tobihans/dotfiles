-- luacheck: globals vim, ignore 631

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or vim.loop.fs_stat(lazypath)) then
  vim.g.astronvim_first_install = true -- lets AstroNvim know that this is an initial installation
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

local lazy_loaded, lazy = pcall(require, "lazy") -- validate that lazy is available
if not lazy_loaded then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

---@type LazyConfig
local lazy_opts = {
  install = { colorscheme = { "astrodark", "habamax" } },
  ui = {
    border = "double",
    size = {
      width = 0.8,
      height = 0.8,
    },
  },
  dev = {
    path = "~/neovim",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  custom_keys = {},
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
      },
    },
  },
}

lazy.setup({
  -- TODO: change `branch="v4"` to `version="^4"` on release
  { "AstroNvim/AstroNvim", branch = "v4", import = "astronvim.plugins" },
  -- TODO: Remove branch v4 on release
  { "AstroNvim/astrocommunity", branch = "v4" },

  -- Packs
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.scala" },
  { import = "astrocommunity.pack.ansible" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.typescript-all-in-one" },

  -- Test
  { import = "astrocommunity.test.neotest" },

  -- Local
  { import = "plugins" },
  { import = "plugins.core" },
  { import = "plugins.user" },
} --[[@as LazySpec]], lazy_opts)
