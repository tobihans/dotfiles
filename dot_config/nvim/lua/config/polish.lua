require "config.ft"
require "config.options"
require "config.mappings"
require "config.autocmds"

-- Diagnostic Signs
local get_icon = require("astroui").get_icon
vim.fn.sign_define {
  { name = "DiagnosticSignInfo", text = get_icon "DiagnosticInfo", texthl = "DiagnosticInfo" },
  { name = "DiagnosticSignHint", text = get_icon "DiagnosticHint", texthl = "DiagnosticHint" },
  { name = "DiagnosticSignWarn", text = get_icon "DiagnosticWarn", texthl = "DiagnosticWarn" },
  { name = "DiagnosticSignError", text = get_icon "DiagnosticError", texthl = "DiagnosticError" },
}

-- Additional LSPs
require("lspconfig").nushell.setup {}

vim.loader.enable()
