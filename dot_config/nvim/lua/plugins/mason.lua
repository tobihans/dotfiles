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
        "bufls",
        "clangd",
        "cssls",
        "denols",
        "docker_compose_language_service",
        "dockerls",
        "gopls",
        "graphql",
        "html",
        "intelephense",
        "jdtls",
        "jsonls",
        "lua_ls",
        "prismals",
        "pyright",
        "ruff_lsp",
        "taplo",
        -- "tinymist",
        "unocss",
        "vimls",
        "volar",
        "vtsls",
        "yamlls",
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
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = function(_, opts)
      opts.ensure_installed = list_insert_unique(opts.ensure_installed, {
        "buf",
        "clang-format",
        "djlint",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golangci-lint",
        "golines",
        "gomodifytags",
        "iferr",
        "impl",
        "markdownlint",
        "php-cs-fixer",
        "pint",
        "prettier",
        "prettierd",
        "protolint",
        "psalm",
        "selene",
        "shellcheck",
        "shfmt",
        "sqlfluff",
        "stylua",
        "tlint",
        "typstfmt",
        "yamllint",
        "yamlfmt",
      })

      local windows_blacklist = {
        "ansible-lint",
        "pint",
        "psalm",
        "tlint",
      }
      if vim.fn.has "win32" then
        opts.ensure_installed = vim
          .iter(opts.ensure_installed)
          :filter(function(tool)
            -- Remove any tool blacklisted on Windows
            return not vim.iter(windows_blacklist):any(function(item) return item == tool end)
          end)
          :totable()
      end

      return opts
    end,
    config = true,
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
