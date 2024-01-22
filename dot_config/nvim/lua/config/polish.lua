-- luacheck: globals vim
local utilities = require "utilities"

-- Custom filetypes
vim.filetype.add {
  extension = {
    yml = utilities.ft.yaml,
    yaml = utilities.ft.yaml,
    hurl = "hurl",
  },
  pattern = {
    -- Chezmoi dotfiles
    ["dot_bash.*"] = "bash",
    ["dot.*.sh"] = "bash",
    ["dot_functions.*"] = "bash",
    ["env.*"] = "bash",
    [".env.*"] = "bash",
  },
}

-- LSP highlights
-- https://www.reddit.com/r/neovim/comments/12gvms4/this_is_why_your_higlights_look_different_in_90/
local links = {
  ["@lsp.type.namespace"] = "@namespace",
  ["@lsp.type.type"] = "@type",
  ["@lsp.type.class"] = "@type",
  ["@lsp.type.enum"] = "@type",
  ["@lsp.type.interface"] = "@type",
  ["@lsp.type.struct"] = "@structure",
  ["@lsp.type.parameter"] = "@parameter",
  ["@lsp.type.variable"] = "@variable",
  ["@lsp.type.property"] = "@property",
  ["@lsp.type.enumMember"] = "@constant",
  ["@lsp.type.function"] = "@function",
  ["@lsp.type.method"] = "@method",
  ["@lsp.type.macro"] = "@macro",
  ["@lsp.type.decorator"] = "@function",
}
for newgroup, oldgroup in pairs(links) do
  vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end

pcall(require, "config.autocmds")
