local M = {}

function M.preferences(palette)
  -- improve columns
  vim.api.nvim_set_hl(0, "LineNr", { fg = palette.base03 })
  vim.api.nvim_set_hl(0, "CursorLineNr", { fg = palette.base05, bold = true })
  vim.api.nvim_set_hl(0, "SignColumn", { fg = palette.base03 })
  vim.api.nvim_set_hl(0, "FoldColumn", { fg = palette.base03 })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = palette.base00, bg = palette.base00 })
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = palette.base03 })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = palette.base03 })
  vim.api.nvim_set_hl(0, "CursorLineSign", { fg = palette.base03 })
  vim.api.nvim_set_hl(0, "CursorLineFold", { fg = palette.base0C })
end

return M
