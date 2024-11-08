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

-- HACK: Override astrocore.is_available to also check if module exists.
-- E.g mini.bufremove comes from mini.nvim. No need to add it to lazy.nvim.
local astro = require "astrocore"
astro.is_available = function(plugin)
  local ok, _ = pcall(require, plugin)
  return ok or astro.get_plugin(plugin) ~= nil
end

vim.loader.enable()
