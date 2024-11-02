local M = {}

---Get the saved data for this extension
---@param _opts resession.Extension.OnSaveOpts Information about the session being saved
---@return any
M.on_save = function(_opts)
  local breakpoints = {}

  for bufnr, buf_breakpoints in pairs(require("dap.breakpoints").get()) do
    breakpoints[vim.api.nvim_buf_get_name(bufnr)] = buf_breakpoints
  end

  return breakpoints
end

---Restore the extension state
---@param breakpoints The value returned from on_save
M.on_post_load = function(breakpoints)
  local set = require("dap.breakpoints").set

  -- Build a table of <filename, buffer number>
  local loaded_buffers = {}
  vim.iter(vim.api.nvim_list_bufs()):each(function(bufnr)
    if vim.api.nvim_buf_is_loaded(bufnr) then
      local fname = vim.api.nvim_buf_get_name(bufnr)
      loaded_buffers[fname] = bufnr
    end
  end)

  -- Iterate over the breakpoints and restore them
  vim.iter(breakpoints):each(function(fname, buf_breakpoints)
    local bufnr = loaded_buffers[fname]
    if bufnr ~= nil then
      vim.iter(buf_breakpoints):each(
        function(bp)
          set({
            condition = bp.condition,
            log_message = bp.logMessage,
            hit_condition = bp.hitCondition,
          }, tonumber(bufnr), bp.line)
        end
      )
    end
  end)
end

return M
