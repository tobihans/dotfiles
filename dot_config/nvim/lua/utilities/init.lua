local is_windows = vim.fn.has "win32" == 1

local M = {
  PATH_SEPARATOR = is_windows and "\\" or "/",
}

local get_icon = require("astroui").get_icon

function M.tbl_flatten(t) return vim.iter(t):flatten(math.huge):totable() end

function M.join_paths(...) return table.concat(M.tbl_flatten { ... }, M.PATH_SEPARATOR) end

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

function M.trim(s) return (string.gsub(s, "^%s*(.-)%s*$", "%1")) end

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
  local valid_fmt = "%s ┃%5d:%-4d┃%s %s"

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
      local icon = " %s"

      if e.type == "E" then
        icon = icon:format(get_icon "DiagnosticError")
      elseif e.type == "W" then
        icon = icon:format(get_icon "DiagnosticWarn")
      elseif e.type == "I" then
        icon = icon:format(get_icon "DiagnosticInfo")
      elseif e.type == "H" or e.type == "N" then
        icon = icon:format(get_icon "DiagnosticHint")
      else
        icon = icon:format(get_icon "DiagnosticUnknown")
      end

      str = valid_fmt:format(fname, lnum, col, qtype .. icon .. " ", e.text)
    else
      -- NOTE: Don't trim unless it's actually empty.
      str = string.format("%-" .. limit .. "s" .. " ┃%10s┃ %s", " ", " ", M.trim(e.text) ~= "" and e.text or "")
    end

    table.insert(ret, str)
  end
  return ret
end

--- Open a file. Provided for integration purposes
---@param filename string
---@param line integer
---@param column integer
function M.open_file(filename, line, column)
  -- local window = require("window-picker").pick_window()
  print(string.format("Display file from %s:%s,%s", filename, line, column))
  -- vim.fn.cursor(line, column)
end

--- Loads local configuration file. Useful when cwd changes in process.
function M.load_exrc()
  if not (vim.o.secure or vim.o.exrc) then return end
  for _, exrc in pairs {
    ".nvim.lua",
    ".nvimrc",
    ".exrc",
  } do
    local source = vim.secure.read(exrc)
    if source ~= nil then
      if exrc == ".nvim.lua" then
        assert(loadstring(source, exrc), string.format("Cannot load %s!", exrc))()
      else
        vim.cmd(source)
      end
      return exrc
    end
  end
end

function M.load_neovim_config()
  vim.cmd.cd(vim.fn.stdpath "config")
  vim.cmd.edit "init.lua"
  require("resession").load(vim.fn.getcwd(), { dir = "dirsession", reset = true, silence_errors = true })
end

---@param key string
function M.secret(key)
  local job = vim.system({ "get_develop_secret", key }, { text = true }):wait()
  if job.code == 0 then return job.stdout:gsub("%s+", "") end
end

return M
