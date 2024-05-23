local join_paths = require("utilities").join_paths

local M = {}

function M.has_vue(root)
  local files = vim.fs.find(
    function(name, _path) return name:match ".*%.vue$" end,
    { limit = 1, type = "file", path = root }
  )
  return #files > 0
end

function M.get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then return join_paths(vim.env.VIRTUAL_ENV, "bin", "python") end

  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(join_paths(workspace, "poetry.lock"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
    return join_paths(venv, "bin", "python")
  end

  local envs = { ".venv", ".env", "venv", "env" }

  for _, venv in ipairs(envs) do
    local python_path = join_paths(workspace, venv, "bin", "python")
    match = vim.fn.glob(python_path)
    if match ~= "" then return python_path end
  end

  -- Fallback to system Python.
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end
return M
