---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      staticcheck = true,
      gofumpt = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
