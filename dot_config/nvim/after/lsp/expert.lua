---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  cmd = { "expert" },
  root_markers = { "mix.exs", ".git" },
  filetypes = { "elixir", "eelixir", "heex" },
}
