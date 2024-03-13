local log = require "overseer.log"

---@param opts overseer.SearchParams
---@return nil|string
local function get_manage_py(opts) return vim.fs.find("manage.py", { upward = true, type = "file", path = opts.dir })[1] end

---@type overseer.TemplateFileProvider
local tmpl = {
  cache_key = function(opts) return get_manage_py(opts) end,
  condition = {
    callback = function(opts)
      if not get_manage_py(opts) then return false, "No manage.py found" end
      return true
    end,
  },
  generator = function(opts, cb)
    local tasks = {}
    local manage_py = get_manage_py(opts)
    local cmd = vim.system({ "python", manage_py, "help", "--commands" }, { stderr = false, text = true }):wait()

    if cmd.code ~= 0 then
      log:error "Failed to get available commands from manage.py"
      cb(tasks)
      return
    end

    local commands = vim.split(cmd.stdout, "\n", { trimempty = true })

    for i, command in pairs(commands) do
      table.insert(tasks, {
        name = string.format("manage.py %s", command),
        priority = 70 + i,
        params = {
          args = { optional = true, type = "list", delimiter = " " },
        },
        builder = function(params)
          return {
            cmd = { "python", manage_py, command },
            args = params.args,
          }
        end,
      })
    end

    cb(tasks)
  end,
}

return tmpl
