---@diagnostic disable: inject-field
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
      table.insert(opts.adapters, require "neotest-rspec")

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
      opts.ensure_installed =
        require("astrocore").list_insert_unique(opts.ensure_installed, { "solargraph", "ruby_lsp" })
    end,
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      config = {
        ruby_lsp = {
          init_options = {
            enabledFeatures = {
              formatting = true,
              onTypeFormatting = true,
            },
            experimentalFeaturesEnabled = true,
          },
        },
        solargraph = {
          settings = {
            solargraph = {
              autoformat = false,
              formatting = false,
              completion = true,
              diagnostic = true,
              folding = true,
              references = true,
              rename = true,
              symbols = true,
            },
          },
        },
      },
      handlers = {
        solargraph = false, -- disable for now
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
