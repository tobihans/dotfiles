---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    priority = 3000,
    opts = function(_, opts)
      opts.ui = {
        border = "double",
        width = 0.8,
        height = 0.8,
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      }

      return opts
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        "ansiblels",
        "bashls",
        "bufls",
        "clangd",
        "cssls",
        "denols",
        "docker_compose_language_service",
        "dockerls",
        "eslint",
        "gopls",
        "graphql",
        "html",
        "intelephense",
        "jdtls",
        "jsonls",
        "kotlin_language_server",
        "lua_ls",
        "lua_ls",
        "marksman",
        "phpactor",
        "prismals",
        "pyright",
        "ruff_lsp",
        "rust_analyzer",
        "taplo",
        "tsserver",
        "typst_lsp",
        "unocss",
        "vimls",
        "volar",
        "yamlls"
      )

      return opts
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      ensure_installed = {
        "clang_format",
        "gofumpt",
        "goimports",
        "gomodifytags",
        "iferr",
        "impl",
        "djlint",
        "ktlint",
        "prettier",
        "protolint",
        "shellcheck",
        "shfmt",
        "stylua",
      },
      handlers = {
        prettier = function()
          require("null-ls").register(require("null-ls").builtins.formatting.prettier.with {
            condition = function(utils)
              return utils.root_has_file "package.json"
                or utils.root_has_file ".prettierrc"
                or utils.root_has_file ".prettierrc.json"
                or utils.root_has_file ".prettierrc.js"
            end,
          })
        end,
        deno_fmt = function()
          require("null-ls").register(require("null-ls").builtins.formatting.deno_fmt.with {
            condition = function(utils) return utils.root_has_file "deno.json" or utils.root_has_file "deno.jsonc" end,
          })
        end,
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        "bash",
        "codelldb",
        "delve", -- go
        "java-debug-adapter",
        "java-test",
        "kotlin",
        "php",
        "python"
      )

      return opts
    end,
  },
}
