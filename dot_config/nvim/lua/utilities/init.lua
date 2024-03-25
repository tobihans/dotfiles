local M = {}

local get_icon = require("astroui").get_icon

--- Checks if there is a git conflict in the current dir
--- This is used to know if we should enable git-conflicts
--- on startup or delay it.
---@return boolean
function M.has_conflicts() return vim.fn.system { "git", "diff", "--check" } ~= "" end

--- Diff with clipboard
function M.compare_to_clipboard()
  local ftype = vim.api.nvim_eval "&filetype"
  vim.cmd "vsplit"
  vim.cmd "enew"
  vim.cmd "normal! P"
  vim.cmd "setlocal buftype=nowrite"
  vim.cmd("set filetype=" .. ftype)
  vim.cmd "diffthis"
  vim.cmd [[execute "normal! \<C-w>h"]]
  vim.cmd "diffthis"
end

--- Pretty display for quickfix and location list
--- From github.com/kevinhwang91/nvim-bqf
---@param info table<string, any>
---@return table<string>
function M.quickfixtextfunc(info)
  local fn = vim.fn
  local items
  local ret = {}

  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end
  local limit = 31
  local fname_fmt1, fname_fmt2 = "%-" .. limit .. "s", "…%." .. (limit - 1) .. "s"
  local valid_fmt = "%s ║%5d:%-3d║%s %s"
  for i = info.start_idx, info.end_idx do
    local e = items[i]
    ---@type string|nil
    local fname = ""
    local str
    if e.valid == 1 then
      if e.bufnr > 0 then
        fname = fn.bufname(e.bufnr)
        if not fname then
          fname = "[No Name]"
        else
          fname = fname:gsub("^" .. vim.env.HOME, "~")
        end
        -- char in fname may occur more than 1 width, ignore this issue in order to keep performance
        if #fname <= limit then
          fname = fname_fmt1:format(fname)
        else
          fname = fname_fmt2:format(fname:sub(1 - limit))
        end
      end
      local lnum = e.lnum > 99999 and -1 or e.lnum
      local col = e.col > 999 and -1 or e.col
      local qtype = e.type == "" and "" or " " .. e.type:sub(1, 1):upper()
      local icon = " "

      if e.type == "E" then
        icon = icon .. get_icon "DiagnosticError"
      elseif e.type == "W" then
        icon = icon .. get_icon "DiagnosticWarn"
      elseif e.type == "I" then
        icon = icon .. get_icon "DiagnosticInfo"
      elseif e.type == "H" or e.type == "N" then
        icon = icon .. get_icon "DiagnosticHint"
      end

      str = valid_fmt:format(fname, lnum, col, qtype .. icon .. " ", e.text)
    else
      str = e.text
    end
    table.insert(ret, str)
  end
  return ret
end

return M
