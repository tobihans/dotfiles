local dap = require "dap"

require("dap-view").setup {
  winbar = { controls = { enabled = true } },
  virtual_text = { enabled = true },
}

-- Set signs for DAP
local sign = function(opts) vim.fn.sign_define(opts.name, { texthl = opts.texthl, text = opts.text, numhl = "" }) end
sign { name = "DapBreakpoint", text = "●", texthl = "DiagnosticInfo" }
sign { name = "DapBreakpointCondition", text = "", texthl = "DiagnosticInfo" }
sign { name = "DapBreakpointRejected", text = "", texthl = "DiagnosticError" }
sign { name = "DapLogPoint", text = "", texthl = "DiagnosticInfo" }
sign { name = "DapStopped", text = "", texthl = "DiagnosticWarn" }

dap.listeners.after.event_initialized["dap_view"] = function() require("dap-view").open() end
dap.listeners.before.event_terminated["dap_view"] = function() require("dap-view").close() end
dap.listeners.before.event_exited["dap_view"] = function() require("dap-view").close() end
require "config.dap.javascript"
