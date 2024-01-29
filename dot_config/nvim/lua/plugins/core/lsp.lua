-- luacheck: globals vim
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      diagnostics_mode = 2,
      inlay_hints = true,
    },
    diagnostics = {
      virtual_text = false,
      underline = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {
          "lua",
        },
      },
      disabled = {},
      timeout_ms = 4500,
    },
    servers = {},
    ---@diagnostic disable: missing-fields
    config = {
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
      },
      cssls = {
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      },
      dartls = {
        settings = {
          showTodos = false,
        },
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").dart, { buffer = bufnr })
        end,
      },
      denols = {
        root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
      },
      eslint = {
        root_dir = require("lspconfig.util").root_pattern("package.json", ".eslintrc.json", ".eslintrc.js"),
      },
      metals = {
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").scala, { buffer = bufnr })
        end,
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {},
        },
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").rust, { buffer = bufnr })
        end,
      },
      -- tsserver = {
      --   root_dir = require("lspconfig.util").root_pattern "package.json",
      --   single_file_support = false,
      -- },
      ["typescript-tools"] = {
        single_file_support = false,
      },
    },
    handlers = {
      -- function(server, opts) require("lspconfig")[server].setup(opts) end, or false to deactivate the deault setup
    },
    mappings = {
      n = {
        K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
      },
    },
  },
}
