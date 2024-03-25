---@type LazySpec
return {
  { "tobihans/vim-caddyfile" },
  { "kaarmu/typst.vim", ft = "typst", init = function() vim.g.typst_syntax_highlight = 0 end },
}
