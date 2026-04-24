---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  root_markers = {
    ".env/pyvenv.cfg",
    ".git",
    ".venv/pyvenv.cfg",
    "Pipfile",
    "env/pyvenv.cfg",
    "pyproject.toml",
    "pyrefly.toml",
    "pyrightconfig.json",
    "requirements.txt",
    "setup.cfg",
    "setup.py",
    "venv/pyvenv.cfg",
  },
  workspace_required = false,
}
