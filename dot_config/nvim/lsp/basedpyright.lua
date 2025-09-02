local utils = require "utilities.lsp"

---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  on_init = function(client)
    if client.config.root_dir ~= nil then
      ---@diagnostic disable-next-line: inject-field
      client.config.settings.python.pythonPath = utils.get_python_path(client.config.root_dir)
    end
  end,
  workspace_required = true,
  settings = {
    basedpyright = {
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        disableOrganizeImports = true,
        typeCheckingMode = "standard",
        useLibraryCodeForTypes = true,
        inlayHints = {
          variableTypes = false,
          callArgumentNames = false,
          functionReturnTypes = false,
          genericTypes = false,
        },
      },
    },
    python = {},
  },
}
