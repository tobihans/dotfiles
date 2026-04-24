local M = {}

--- Check if a buffer is valid
---@param bufnr? integer The buffer to check, default to current buffer
---@return boolean # Whether the buffer is valid or not
function M.is_valid(bufnr)
  if not bufnr then bufnr = 0 end
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

--- Check if a buffer can be restored
---@param bufnr integer The buffer to check
---@return boolean # Whether the buffer is restorable or not
function M.is_restorable(bufnr)
  if not M.is_valid(bufnr) or vim.bo[bufnr].bufhidden ~= "" then return false end

  -- Check if it has a filename.
  if vim.api.nvim_buf_get_name(bufnr) == "" then return false end
  -- TODO: Add a check for local buffer option vim.b.is_restorable.

  return vim.bo[bufnr].buflisted
end

--- Close a given buffer
---@param bufnr? integer The buffer to close or the current buffer if not provided
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close(bufnr, force)
  if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
  if M.is_valid(bufnr) then
    require("snacks").bufdelete { buf = bufnr, force = force }
    -- or require("mini.bufremove").delete { buf = bufnr, force = force }
  end
  -- fallback
  local buftype = vim.bo[bufnr].buftype
  vim.cmd(("silent! %s %d"):format((force or buftype == "terminal") and "bdelete!" or "confirm bdelete", bufnr))
end

return M
