local list_insert_unique = require("astrocore").list_insert_unique

---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    priority = 5000,
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
      opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
        "ansiblels",
        "astro",
        "basedpyright",
        "bashls",
        "biome",
        "cssls",
        "denols",
        "docker_compose_language_service",
        "dockerls",
        "gopls",
        "html",
        "intelephense",
        "jdtls",
        "jsonls",
        "lua_ls",
        "ruff_lsp",
        "taplo",
        "tinymist",
        "unocss",
        "volar",
        "vtsls",
        "yamlls",
        "psalm",
      })

      if not vim.fn.has "win32" then
        opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
          "phpactor",
        })
      end

      return opts
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
        "bash",
        "codelldb",
        "delve",
        "java-debug-adapter",
        "java-test",
        "php",
        "python",
      })

      return opts
    end,
  },
}
