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
  on_attach = function(client, bufnr)
    require("astrolsp").on_attach(client, bufnr)
    require("which-key").add(require("config.mappings.lsp").go, { buffer = bufnr })
  end,
}
