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
