local M = {}

function M.nvim_config()
  require("resession").load(vim.fn.stdpath "config", {
    dir = "dirsession",
    reset = true,
    silence_errors = false,
  })
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

return M
