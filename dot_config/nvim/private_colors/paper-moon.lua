-- stylua: ignore start
local palette = {
  base00 = '#f4f0e8', base01 = '#e9e2d6', base02 = '#ddd5c8', base03 = '#b7ab9e',
  base04 = '#897d73', base05 = '#514a45', base06 = '#393430', base07 = '#25211e',
  base08 = '#9f5f67', base09 = '#a97852', base0A = '#88743f', base0B = '#5b7b61',
  base0C = '#4d7c79', base0D = '#5977a1', base0E = '#80658e', base0F = '#966c58',
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

vim.g.colors_name = "paper-moon"
