local M = {}

function M.new_file()
  vim.ui.select(vim.fn.getcompletion("", "filetype"), {
    prompt = "New File",
  }, function(ft)
    if ft ~= nil then
      vim.cmd.enew()
      vim.cmd.setlocal(("ft=%s"):format(ft))
    end
  end)
end

function M.todos()
  Snacks.picker.grep {
    search = "FIXME|HACK|TODO|NOTE",
    regex = true,
    live = false,
    need_search = false,
    title = " Todo Comments",
  }
end

return M
