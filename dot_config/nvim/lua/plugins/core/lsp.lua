-- luacheck: globals vim
---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type function(str, table): AstroLSPOpts
  opts = function(_, opts)
    local lsp_util = require "lspconfig.util"

    -- window style for LSPInfo
    require("lspconfig.ui.windows").default_options.border = "rounded"

    local new_opts = {
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
        denols = {
          single_file_support = true,
          root_dir = lsp_util.root_pattern("deno.json", "deno.jsonc", "supabase"),
        },
        eslint = {
          root_dir = lsp_util.root_pattern("package.json", ".eslintrc.json", ".eslintrc.js"),
        },
        gopls = {
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
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
    }

    return require("astrocore").extend_tbl(opts, new_opts)
  end,
}
