---@type LazySpec
return {
  { "tobihans/vim-caddyfile", ft = "caddyfile" },
  { "kaarmu/typst.vim", ft = "typst", init = function() vim.g.typst_syntax_highlight = 0 end },
  {
    "toppair/peek.nvim",
    ft = { "markdown" },
    build = "deno task --quiet build:fast",
  },
}
