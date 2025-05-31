---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  settings = {
    exportPdf = "never", -- Choose onType, onSave or never.
    fontPaths = {
      vim.env.HOME .. "/.local/share/fonts/",
    },
  },
  on_attach = function(client, bufnr)
    require("astrolsp").on_attach(client, bufnr)
    require("which-key").add(require("config.mappings.lsp").typst, { buffer = bufnr })
  end,
}
