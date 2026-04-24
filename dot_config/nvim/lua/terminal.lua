local M = {}

function M.term_nav(dir)
  return function()
    if vim.api.nvim_win_get_config(0).zindex then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-" .. dir .. ">", true, false, true), "n", false)
    else
      vim.cmd.wincmd(dir)
    end
  end
end

return M
