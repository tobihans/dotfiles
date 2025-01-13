---@type LazySpec
return {
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "olimorris/neotest-rspec" },
    },
    ---@param _ LazySpec
    ---@param opts neotest.Config
    ---@return neotest.Config
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end
      opts.adapters = {
        unpack(opts.adapters),
        require "neotest-rspec",
      }

      return opts
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "suketa/nvim-dap-ruby", config = true },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "solargraph" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        emmet_ls = {
          filetypes = {
            "eruby",
          },
        },
        -- TODO: Will be useful once I leave all projects that are on 2.7
        ruby_lsp = {
          init_options = {
            enabledFeatures = {
              formatting = false,
              onTypeFormatting = false,
            },
            experimentalFeaturesEnabled = true,
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        -- ruby = { "rufo" },
        eruby = { "erb_format" },
        ["eruby.yaml"] = { "yamlfmt" },
      },
    },
  },
}
