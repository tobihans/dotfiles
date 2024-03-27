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

    vim.system({ "python", manage_py, "help", "--commands" }, {
      text = true,
      timeout = 5000,
      stderr = false,
      stdout = function(err, data)
        if err ~= nil then log:error(string.format("`python %s help --commands` failed: %s.", manage_py, err)) end
        if data == nil or err ~= nil then return end

        for i, command in pairs(vim.split(data, "\n", { trimempty = true })) do
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
    }, function(obj)
      if obj.code ~= 0 then
        log:error(string.format("`python %s help --commands` exited with %d code.", manage_py, obj.code))
      end
    end)
  end,
}

return tmpl
