-- luacheck: globals vim, ignore 631

---@type LazySpec
local lazy_spec = {
  -- TODO: change `branch="v4"` to `version="^4"` on release
  {
    "AstroNvim/AstroNvim",
    branch = "v4",
    import = "astronvim.plugins",
    opts = function(_, opts)
      require "config.options"

      opts.mapleader = vim.g.mapleader
      opts.maplocalleader = vim.g.maplocalleader

      return opts
    end,
  },

  -- TODO: Remove branch v4 on release
  { "AstroNvim/astrocommunity", branch = "v4" },
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
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.test.neotest" },

  { import = "plugins" },
}

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

require("lazy").setup(lazy_spec, lazy_opts)
