local dap = require "dap"
local misc = require "misc"

local js_debug_dir = misc.where "js-debug"
if not js_debug_dir then return {} end

require("dap").adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    args = { string.format("%s/src/dapDebugServer.js", js_debug_dir), "${port}" },
  },
}

dap.configurations.javascript = {
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch with arguments",
    program = "${file}",
    args = function()
      local input = vim.fn.input "Arguments: "
      return vim.split(input, " ")
    end,
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Launch with .env",
    program = "${file}",
    envFile = "${workspaceFolder}/.env",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "attach",
    name = "Attach to process",
    port = 9229,
    cwd = "${workspaceFolder}",
  },
  -- Cloudflare Workers
  {
    type = "pwa-node",
    request = "attach",
    name = "Wrangler: Attach",
    port = 9229,
    cwd = "/",
    resolveSourceMapLocations = nil,
    attachExistingChildren = false,
    autoAttachChildProcesses = false,
    sourceMaps = true,
  },
  -- Jest
  {
    type = "pwa-node",
    request = "launch",
    name = "Debug Jest Tests",
    program = "${workspaceFolder}/node_modules/.bin/jest",
    args = { "--runInBand" },
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    cwd = "${workspaceFolder}",
  },
  -- Vitest
  {
    type = "pwa-node",
    request = "launch",
    name = "Debug Vitest",
    program = "${workspaceFolder}/node_modules/.bin/vitest",
    args = { "run", "--reporter=verbose", "${file}" },
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    cwd = "${workspaceFolder}",
  },
  {
    type = "pwa-node",
    request = "launch",
    name = "Debug Vitest (all)",
    program = "${workspaceFolder}/node_modules/.bin/vitest",
    args = { "run", "--reporter=verbose" },
    console = "integratedTerminal",
    internalConsoleOptions = "neverOpen",
    cwd = "${workspaceFolder}",
  },
}

dap.configurations.typescript = dap.configurations.javascript
