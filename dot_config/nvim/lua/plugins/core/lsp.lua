---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
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
      timeout_ms = 2500,
    },
    servers = {},
    ---@diagnostic disable: missing-fields
    config = {
      cssls = {
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      },
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
      },
      tsserver = {
        root_dir = require("lspconfig.util").root_pattern "package.json",
        single_file_support = false,
      },
      eslint = {
        root_dir = require("lspconfig.util").root_pattern("package.json", ".eslintrc.json", ".eslintrc.js"),
      },
      denols = {
        root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
      },
    },
    setup_handlers = {
      -- function(server, opts) require("lspconfig")[server].setup(opts) end
      rust_analyzer = false,
    },
    mappings = {
      n = {
        K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
        gl = { function() vim.diagnostic.open_float() end, desc = "Hover diagnostics" },
        gD = {
          function() vim.lsp.buf.declaration() end,
          desc = "Declaration of current symbol",
          cond = "textDocument/declaration",
        },
        ["<leader>uY"] = {
          function() require("astrolsp.toggles").buffer_semantic_tokens() end,
          desc = "Toggle LSP semantic highlight (buffer)",
          cond = function(client) return client.server_capabilities.semanticTokensProvider and vim.lsp.semantic_tokens end,
        },
      },
    },
  },
}
