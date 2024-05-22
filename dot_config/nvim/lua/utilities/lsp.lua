local util = require "lspconfig/util"

local path = util.path
local M = {
  py_root_files = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
    ".venv/pyvenv.cfg",
    ".env/pyvenv.cfg",
  },
}

function M.has_vue(root)
  local files = vim.fs.find(
    function(name, _path) return name:match ".*%.vue$" end,
    { limit = 1, type = "file", path = root }
  )
  return #files > 0
end

function M.get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then return path.join(vim.env.VIRTUAL_ENV, "bin", "python") end

  -- Find and use virtualenv via poetry in workspace directory.
  local match = vim.fn.glob(path.join(workspace, "poetry.lock"))
  if match ~= "" then
    local venv = vim.fn.trim(vim.fn.system "poetry env info -p")
    return path.join(venv, "bin", "python")
  end

  -- .venv
  local dot_venv = path.join(workspace, ".venv", "bin", "python")
  match = vim.fn.glob(dot_venv)
  if match ~= "" then return dot_venv end

  -- .env
  local dot_env = path.join(workspace, ".venv", "bin", "python")
  match = vim.fn.glob(dot_env)
  if match ~= "" then return dot_env end

  -- Fallback to system Python.
  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end
return M
