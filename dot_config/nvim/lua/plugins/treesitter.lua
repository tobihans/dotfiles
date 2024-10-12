---@type LazySpec
return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User AstroFile",
    opts = {
      enable = true,
      max_lines = 5,
      line_numbers = true,
      multiline_threshold = 10,
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
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
