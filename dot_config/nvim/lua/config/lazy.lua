---@type LazySpec
local lazy_spec = {
  {
    "AstroNvim/AstroNvim",
    import = "astronvim.plugins",
    opts = function(_, opts)
      opts.mapleader = ","
      opts.maplocalleader = ";"
    end,
  },

  { "AstroNvim/astrocommunity" },
  { import = "astrocommunity.pack.ansible" },
  { import = "astrocommunity.pack.cmake" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.dart" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.html-css" },
  { import = "astrocommunity.pack.java" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.proto" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.tailwindcss" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  { import = "astrocommunity.editing-support.conform-nvim" },
  { import = "astrocommunity.test.neotest" },
  { import = "astrocommunity.test.nvim-coverage" },

  { import = "plugins" },
}

---@type LazyConfig
local lazy_opts = {
  install = { colorscheme = { "habamax" } },
  ui = {
    border = "double",
    backdrop = 100,
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
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

require("lazy").setup(lazy_spec, lazy_opts)
