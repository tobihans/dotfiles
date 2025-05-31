local M = {}

function M.new_file()
  vim.ui.select(vim.fn.getcompletion("", "filetype"), {
    prompt = "New File",
  }, function(ft)
    vim.cmd "enew"
    vim.cmd("setlocal filetype=" .. ft)
  end)
end

function M.quick_actions()
  vim.ui.select(require "utilities.quick_actions", {
    prompt = "󱘆 Quick Actions 󱘆",
    format_item = function(item) return string.format("%s %s", item.icon, item.desc) end,
  }, function(item)
    if item then pcall(item.fn) end
  end)
end

return M
