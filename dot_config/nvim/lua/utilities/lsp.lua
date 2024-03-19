-- TODO: This is roughly copied from https://github.com/Saecki/crates.nvim/issues/78#issuecomment-1773834720
-- I will clean this up later and make it generic
-- Example: https://github.com/gh-liu/dotfiles/blob/6e4d59dd97dbb175bf5383d0affb11d51b59f74f/xdg_config/nvim/lua/liu/lsp/helper.lua
local lsp = {}

---@class lsp.server.opts
---@field handlers? table<string, fun(method: string, params: any): any>
---@field on_request? fun(method: string, params)
---@field on_notify? fun(method: string, params)
---@field capabilities? table

--- Create a in-process LSP server that can be used as `cmd` with |vim.lsp.start|
--- Example:
--- <pre>lua
--- vim.lsp.start({
---   name = "my-in-process-server",
---   cmd = vim.lsp.server({
---   handlers = {
---
---   }
---   })
--- })
---
--- @param opts nil|lsp.server.opts
function lsp.server(opts)
  opts = opts or {}
  local capabilities = opts.capabilities or {}
  local on_request = opts.on_request or function(_, _) end
  local on_notify = opts.on_notify or function(_, _) end
  local handlers = opts.handlers or {}

  return function(dispatchers)
    local closing = false
    local srv = {}
    local request_id = 0

    function srv.request(method, params, callback)
      pcall(on_request, method, params)
      local handler = handlers[method]
      if handler then
        local response, err = handler(method, params)
        callback(err, response)
      elseif method == "initialize" then
        callback(nil, {
          capabilities = capabilities,
        })
      elseif method == "shutdown" then
        callback(nil, nil)
      end
      request_id = request_id + 1
      return true, request_id
    end

    function srv.notify(method, params)
      pcall(on_notify, method, params)
      if method == "exit" then dispatchers.on_exit(0, 15) end
    end

    function srv.is_closing() return closing end

    function srv.terminate() closing = true end

    return srv
  end
end

lsp.enable_crates = function()
  local actions = {
    "update_crate",
    "upgrade_crate",
    "expand_crate_to_inline_table",
    "extract_crate_into_table",
    "remove_duplicate_section",
    "remove_original_section",
    "remove_invalid_dependency_section",
    "remove_duplicate_crate",
    "remove_original_crate",
    "rename_crate",
    "remove_duplicate_feature",
    "remove_original_feature",
    "remove_invalid_feature",
    "open_documentation",
    "open_crates.io",
    "update_all_crates",
    "upgrade_all_crates",
  }
  for _, value in ipairs(actions) do
    vim.lsp.commands[value] = function(cmd, ctx)
      local actions = require "crates.actions"
      local action = actions.get_actions()[cmd.command]
      vim.api.nvim_buf_call(ctx.bufnr, action)
    end
  end

  local api = vim.api
  local server = lsp.server {
    capabilities = {
      codeActionProvider = true,
    },
    handlers = {
      ---@param params lsp.CodeActionParams
      ["textDocument/codeAction"] = function(_, params)
        local actions = require "crates.actions"
        local function format_title(name) return name:sub(1, 1):upper() .. name:gsub("_", " "):sub(2) end

        local code_actions = {}
        for key, action in pairs(actions.get_actions()) do
          table.insert(code_actions, {
            title = format_title(key),
            kind = "refactor.rewrite",
            command = key,
          })
        end
        return code_actions
      end,
    },
  }
  vim.lsp.start { name = "crates-ls", cmd = server }
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "Cargo.toml",
  callback = function() lsp.enable_crates() end,
})
