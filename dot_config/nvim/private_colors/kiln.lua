-- stylua: ignore start
local palette = {
  base00 = '#241f22', base01 = '#2c2527', base02 = '#3b3030', base03 = '#615152',
  base04 = '#92807c', base05 = '#d5c9c4', base06 = '#e6dbd4', base07 = '#f5eee9',
  base08 = '#bd7273', base09 = '#c78b63', base0A = '#baaa72', base0B = '#8fa080',
  base0C = '#80a6a0', base0D = '#839bb8', base0E = '#a38dab', base0F = '#ad7d6c',
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

vim.g.colors_name = "kiln"
