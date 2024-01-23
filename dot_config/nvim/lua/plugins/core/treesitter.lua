---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = false,
    opts = {
      enable = true,
      max_lines = 5,
      multiline_threshold = 10,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(
        opts.ensure_installed,
        "awk",
        "bash",
        "c",
        "cpp",
        "css",
        "csv",
        "dart",
        "diff",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "graphql",
        "html",
        "htmldjango",
        "http",
        "hurl",
        "java",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "kotlin",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "php",
        "phpdoc",
        "po",
        "prisma",
        "proto",
        "python",
        "query",
        "regex",
        "requirements",
        "ruby",
        "rust",
        "scss",
        "sql",
        "swift",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "yaml"
      )

      opts.highlight = { enable = true }
      opts.indent = { enable = true }
      opts.autotag = {
        enable = true,
        filetypes = {
          "html",
          "javascript",
          "javascriptreact",
          "svelte",
          "typescript",
          "typescriptreact",
          "vue",
          "xml",
        },
      }

      return opts
    end,
  },
}
