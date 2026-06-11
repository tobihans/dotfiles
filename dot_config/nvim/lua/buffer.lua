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

--- Get the ordered list of listed buffers (matches mini.tabline display order)
---@return integer[] # List of buffer numbers in tabline order
function M.list()
  local bufs = {}
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if M.is_valid(bufnr) then bufs[#bufs + 1] = bufnr end
  end
  return bufs
end

--- Close a given buffer
---@param bufnr? integer The buffer to close or the current buffer if not provided
---@param force? boolean Whether or not to foce close the buffers or confirm changes (default: false)
function M.close(bufnr, force)
  if not bufnr or bufnr == 0 then bufnr = vim.api.nvim_get_current_buf() end
  if M.is_valid(bufnr) then
    require("snacks").bufdelete { buf = bufnr, force = force }
    return
  end
  -- fallback
  local buftype = vim.bo[bufnr].buftype
  vim.cmd(("silent! %s %d"):format((force or buftype == "terminal") and "bdelete!" or "confirm bdelete", bufnr))
end

--- Close buffers to the left of the current buffer
---@param force? boolean Whether or not to force close the buffers or confirm changes (default: false)
function M.close_left(force)
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(M.list()) do
    if bufnr == current then break end
    M.close(bufnr, force)
  end
end

--- Close buffers to the right of the current buffer
---@param force? boolean Whether or not to force close the buffers or confirm changes (default: false)
function M.close_right(force)
  local current = vim.api.nvim_get_current_buf()
  local after_current = false
  for _, bufnr in ipairs(M.list()) do
    if after_current then M.close(bufnr, force) end
    if bufnr == current then after_current = true end
  end
end

--- Split-open a buffer relative to current in the tabline order
---@param offset integer Number of positions (negative = left, positive = right)
---@param vertical? boolean Whether to split vertically (default: horizontal)
function M.split(offset, vertical)
  local bufs = M.list()
  local current = vim.api.nvim_get_current_buf()
  for i, bufnr in ipairs(bufs) do
    if bufnr == current then
      local target = bufs[i + offset]
      if not target then return end
      local dir = offset < 0 and "leftabove" or "rightbelow"
      if vertical then vim.cmd(dir .. " vsplit") else vim.cmd(dir .. " split") end
      vim.api.nvim_win_set_buf(0, target)
      return
    end
  end
end

return M
