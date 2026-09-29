-- stylua: ignore start
local palette = {
  base00 = '#fcfaf5', base01 = '#f2eee5', base02 = '#e7e1d5', base03 = '#b8b1a4',
  base04 = '#837b6e', base05 = '#45413b', base06 = '#2f2c27', base07 = '#191714',
  base08 = '#a83c3e', base09 = '#b56a28', base0A = '#8a6d1d', base0B = '#4d7f4f',
  base0C = '#397d82', base0D = '#3f67a7', base0E = '#8355a8', base0F = '#9b5544',
}
-- stylua: ignore end

require("mini.base16").setup { palette = palette, use_cterm = true }

vim.api.nvim_set_hl(0, "LineNr", { fg = palette.base03 })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.base05, bold = true })
vim.api.nvim_set_hl(0, "SignColumn", { fg = palette.base03 })
vim.api.nvim_set_hl(0, "FoldColumn", { fg = palette.base03 })
vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = palette.base00, bg = palette.base00 })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = palette.base03 })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = palette.base03 })
vim.api.nvim_set_hl(0, "CursorLineSign", { fg = palette.base03 })
vim.api.nvim_set_hl(0, "CursorLineFold", { fg = palette.base0C })

vim.g.colors_name = "vellum-day"
