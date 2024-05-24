local utilities = require "utilities"

local M = {}

function M.has_vue(root)
  local files = vim.fs.find(
    function(name, _path) return name:match ".*%.vue$" end,
    { limit = 1, type = "file", path = root }
  )
  return #files > 0
end

--- Find a virtualenv in the workspace directory.
---@param workspace string
---@return string
function M.get_python_path(workspace)
  if vim.env.VIRTUAL_ENV then return utilities.join_paths(vim.env.VIRTUAL_ENV, "bin", "python") end

  -- Poetry
  if vim.fn.glob(utilities.join_paths(workspace, "poetry.lock")) ~= "" then
    return utilities.join_paths(vim.fn.trim(vim.fn.system "poetry env info -p"), "bin", "python")
  end

  -- Local virtualenv
  local envs = { ".venv", ".env", "venv", "env" }
  for _, venv in ipairs(envs) do
    local python_path = utilities.join_paths(workspace, venv, "bin", "python")
    if vim.fn.glob(python_path) ~= "" then return python_path end
  end

  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

return M
