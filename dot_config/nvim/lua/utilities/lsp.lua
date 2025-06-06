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
  if vim.env.VIRTUAL_ENV then return vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "python") end

  -- Poetry
  local glob = vim.fn.glob(vim.fs.joinpath(workspace, "poetry.lock"))
  if glob ~= "" then
    local obj = vim
        .system({ "mise", "x", "pipx:poetry", "--", "poetry", "env", "info", "-p" }, {
          text = true,
          cwd = vim.fn.fnamemodify(glob, ":h"),
        })
        :wait()

    if obj.code ~= 0 then
      vim.notify_once("Failed to inspect poetry environment", vim.log.levels.ERROR)
      return ""
    end

    return vim.fs.joinpath(vim.fn.trim(obj.stdout), "bin", "python")
  end

  -- Local virtualenv
  local envs = { ".venv", ".env", "venv", "env" }
  for _, venv in ipairs(envs) do
    local python_path = vim.fs.joinpath(workspace, venv, "bin", "python")
    if vim.fn.glob(python_path) ~= "" then return python_path end
  end

  return vim.fn.exepath "python3" or vim.fn.exepath "python" or "python"
end

return M
