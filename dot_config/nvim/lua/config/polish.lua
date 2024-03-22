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

-- Custom signs
local get_icon = require("astroui").get_icon
vim.fn.sign_define {
  { name = "DiagnosticSignInfo", text = get_icon "DiagnosticInfo", texthl = "DiagnosticInfo" },
  { name = "DiagnosticSignHint", text = get_icon "DiagnosticHint", texthl = "DiagnosticHint" },
  { name = "DiagnosticSignWarn", text = get_icon "DiagnosticWarn", texthl = "DiagnosticWarn" },
  { name = "DiagnosticSignError", text = get_icon "DiagnosticError", texthl = "DiagnosticError" },
}

require "config.options"
require "config.ft"
require "config.autocmds"
