-- Diagnostic Signs
local get_icon = require("astroui").get_icon

vim.fn.sign_define {
  { name = "DiagnosticSignInfo",  text = get_icon "DiagnosticInfo",  texthl = "DiagnosticInfo" },
  { name = "DiagnosticSignHint",  text = get_icon "DiagnosticHint",  texthl = "DiagnosticHint" },
  { name = "DiagnosticSignWarn",  text = get_icon "DiagnosticWarn",  texthl = "DiagnosticWarn" },
  { name = "DiagnosticSignError", text = get_icon "DiagnosticError", texthl = "DiagnosticError" },
}

vim.lsp.enable {
  "expert",
  "nushell",
  "pyrefly",
  "qmlls",
  -- "ty",
  "vue_ls",
}
