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

-- TODO: Finish this.
function M.worktrees()
  vim.system({ "mise", "x", "--", "wt", "list", "--format", "json" }, { text = true, timeout = 5000 }, function(job)
    if job.code ~= 0 then return end
    local worktrees = vim.json.decode(job.stdout)
    print(vim.inspect(worktrees))

    -- FIXME: Properly format worktree items
    vim.ui.select(worktrees, {
      prompt = "󱘆 Worktrees 󱘆",
      format_item = function(item) return ("%s %s"):format(item.icon, item.desc) end,
    }, function(item)
      if item then pcall(item.fn) end
    end)
  end)
end

return M
