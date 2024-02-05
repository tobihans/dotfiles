-- luacheck: globals vim
require("lspconfig.ui.windows").default_options.border = "rounded"

local lsp_util = require "lspconfig.util"

local deno_root = lsp_util.root_pattern("deno.json", "deno.jsonc")

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      inlay_hints = true,
    },
    diagnostics = {
      virtual_text = false,
      underline = true,
      update_in_insert = true,
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
      denols = { root_dir = deno_root },
      eslint = {
        root_dir = function(filename, _)
          if not deno_root(filename) then
            return lsp_util.root_pattern("package.json", ".eslintrc.json", ".eslintrc.js")(filename)
          end
        end,
      },
      gopls = {
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
            gofumpt = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").go, { buffer = bufnr })
        end,
      },
      metals = {
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").scala, { buffer = bufnr })
        end,
      },
      rust_analyzer = {
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").rust, { buffer = bufnr })
        end,
      },
      tailwindcss = {
        root_dir = function(filename, _)
          if not deno_root(filename) then return lsp_util.root_pattern "tailwind.config.js"(filename) end
        end,
      },
      ["typescript-tools"] = {
        single_file_support = false,
        root_dir = function(filename, _)
          if not deno_root(filename) then return lsp_util.root_pattern "package.json"(filename) end
        end,
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
