---@diagnostic disable: inject-field
---@type LazySpec
return {
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
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
              onTypeFormatting = false,
            },
            experimentalFeaturesEnabled = true,
            indexing = {
              excludedPatterns = {
                "**/test/**/*.rb",
                "**/node_modules/**/*",
                "**/bin/**/*",
                "**/tmp/**/*",
                "**/.bundle/**/*",
              },
              -- includedPatterns = { "**/bin/**/*" },
              excludedGems = { "rubocop", "rubocop-performance", "debug" },
              excludedMagicComments = { "compiled:true" },
            },
            rubyVersionManager = {
              identifier = "mise",
            },
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
