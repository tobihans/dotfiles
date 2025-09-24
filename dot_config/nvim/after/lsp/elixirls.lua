---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  cmd = { vim.fs.joinpath(vim.env.MASON, "bin/elixir-ls") },
}
