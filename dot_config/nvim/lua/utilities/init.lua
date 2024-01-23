-- luacheck: globals vim

local M = {}

--- Checks if there is a git conflict in the current dir
--- This is used to know if we should enable git-conflicts
--- on startup or delay it.
---@return boolean
function M.has_conflicts()
  local obj = vim.system({ "git", "diff", "--check" }, { stderr = false, text = true }):wait()
  return obj.stdout ~= ""
end

return M
