---@type LazySpec
return {
  { "nushell/tree-sitter-nu", ft = "nu" },
  { "OXY2DEV/helpview.nvim", ft = "help" },
  { "tobihans/vim-caddyfile", ft = "caddyfile" },
  { "kaarmu/typst.vim", ft = "typst", init = function() vim.g.typst_syntax_highlight = 0 end },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    opts = {
      file_types = { "markdown", "Avante" },
      render_modes = { "n", "v", "i", "c" },
    },
  },
}
