---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
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
