-- Diagnostic Signs
local get_icon = require("astroui").get_icon

vim.fn.sign_define {
  { name = "DiagnosticSignInfo",  text = get_icon "DiagnosticInfo",  texthl = "DiagnosticInfo" },
  { name = "DiagnosticSignHint",  text = get_icon "DiagnosticHint",  texthl = "DiagnosticHint" },
  { name = "DiagnosticSignWarn",  text = get_icon "DiagnosticWarn",  texthl = "DiagnosticWarn" },
  { name = "DiagnosticSignError", text = get_icon "DiagnosticError", texthl = "DiagnosticError" },
}

-- Ensures values that are not merged in config are set.
table.insert(vim.lsp.config.vtsls.filetypes, "vue")
table.insert(vim.lsp.config.html.filetypes, "templ")
table.insert(vim.lsp.config.html.filetypes, "eruby")
table.insert(vim.lsp.config.html.filetypes, "htmldjango")
vim.lsp.config("emmet_ls", {
  filetypes = {
    "css",
    "eruby",
    "html",
    "htmldjango",
    "javascriptreact",
    "less",
    "markdown",
    "php",
    "pug",
    "sass",
    "scss",
    "typescriptreact",
  },
})
vim.lsp.config("denols", { root_markers = { "deno.json", "deno.jsonc" } })
-- FIXME: mrcjkb/rustaceanvim passes the filename instead of bufnr to the cb.
-- This is supposed to be used as a workaround for now.
-- Too tired to report and fix for now.
-- local ra_root_dir = vim.lsp.config.rust_analyzer.root_dir
-- if type(ra_root_dir) == "function" then
--   vim.lsp.config("rust_analyzer", {
--     root_dir = function(fname, on_dir)
--       local bufnr = require("utilities").find_buffer_by_name(fname)
--       return ra_root_dir(bufnr, on_dir)
--     end,
--   })
-- end

-- Enabled LSPs
vim.lsp.enable {
  "nushell",
  "pyrefly",
  "vue_ls",
}
-- Disabled LSPs
vim.lsp.enable({
  "volar",
}, false) -- FIXME: Remove after lspconfig 3.0
