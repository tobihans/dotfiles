local M = {}

--- Returns true when there are meaningful buffers worth saving a session for.
--- Filters out dashboard-only, scratch, terminal, and unnamed buffers.
function M.has_meaningful_buffers()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if
      vim.bo[bufnr].buflisted
      and vim.bo[bufnr].buftype == ""
      and vim.api.nvim_buf_get_name(bufnr) ~= ""
      and vim.bo[bufnr].filetype ~= "snacks_dashboard"
    then
      return true
    end
  end
  return false
end

function M.save()
  if vim.fn.getreg "%" == "" then
    vim.ui.input({ prompt = "Path: ", completion = "file" }, function(input)
      if input then vim.cmd.write { input, bang = true } end
    end)
  else
    vim.cmd.write()
  end
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
    if source ~= nil and source ~= true then
      if exrc == ".nvim.lua" then
        assert(loadstring(source, exrc), ("Cannot load %s!"):format(exrc))()
      else
        vim.cmd(source)
      end
      return exrc
    end
  end
end

function M.which(bin)
  local result = vim.system({ "mise", "which", bin }):wait()
  if result.code ~= 0 then return nil end
  return vim.trim(result.stdout)
end

function M.where(tool)
  local result = vim.system({ "mise", "where", tool }):wait()
  if result.code ~= 0 then return nil end
  return vim.trim(result.stdout)
end

return M
