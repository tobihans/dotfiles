---@type LazySpec
return {
  { "OXY2DEV/helpview.nvim", ft = "help" },
  { "tobihans/vim-caddyfile", ft = "caddyfile" },
  { "kaarmu/typst.vim", ft = "typst", init = function() vim.g.typst_syntax_highlight = 0 end },
  { "toppair/peek.nvim", build = "deno task --quiet build:fast" },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    opts = {
      file_types = { "markdown", "Avante" },
      render_modes = { "n", "v", "i", "c" },
    },
  },
}
