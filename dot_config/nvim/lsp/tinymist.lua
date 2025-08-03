---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  settings = {
    exportPdf = "never", -- Choose onType, onSave or never.
    fontPaths = {
      vim.fs.joinpath(vim.env.HOME, "/.local/share/fonts/"),
    },
  },
}
