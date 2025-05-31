---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  on_attach = function(client, bufnr)
    require("astrolsp").on_attach(client, bufnr)
    require("which-key").add(require("config.mappings.lsp").rust, { buffer = bufnr })
  end,
  settings = {
    ["rust-analyzer"] = {
      ---@type RustAnalyzerOpts
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
    },
  },
}
