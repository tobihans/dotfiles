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

    if not manage_py then return end

    local python = require("utilities.lsp").get_python_path(vim.fn.fnamemodify(manage_py, ":h"))

    vim.system({ python, manage_py, "help", "--commands" }, {
      text = true,
      timeout = 5000,
      stderr = false,
      stdout = function(err, data)
        if err ~= nil then
          vim.schedule(function() log:error(("`python %s help --commands` failed: %s."):format(manage_py, err)) end)
        end
        if data == nil or err ~= nil then return end

        for i, command in pairs(vim.split(data, "\n", { trimempty = true })) do
          table.insert(tasks, {
            name = ("manage.py %s"):format(command),
            priority = 70 + i,
            params = {
              args = { optional = true, type = "list", delimiter = " " },
            },
            builder = function(params)
              return {
                cmd = { python, manage_py, command },
                args = params.args,
              }
            end,
          })
        end

        vim.schedule(function() cb(tasks) end)
      end,
    }, function(obj)
      if obj.code ~= 0 then
        vim.schedule(
          function() log:error(("`python %s help --commands` exited with %d code."):format(manage_py, obj.code)) end
        )
      end
    end)
  end,
}

return tmpl
