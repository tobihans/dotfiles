local M = {}

function M.new_file()
  vim.ui.select(vim.fn.getcompletion("", "filetype"), {
    prompt = "New File",
  }, function(ft)
    if ft ~= nil then
      vim.cmd.enew()
      vim.cmd.setlocal(string.format("ft=%s", ft))
    end
  end)
end

function M.quick()
  vim.ui.select(require "utilities.quick", {
    prompt = "󱘆 Quick Actions 󱘆",
    format_item = function(item) return string.format("%s %s", item.icon, item.desc) end,
  }, function(item)
    if item then pcall(item.fn) end
  end)
end

return M
