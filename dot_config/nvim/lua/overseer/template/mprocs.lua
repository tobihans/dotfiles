local overseer = require "overseer"

return {
  name = "mprocs",
  builder = function()
    local obj = vim.system({ "mise", "which", "mprocs" }, { text = true }):wait()
    local bin = "mprocs"
    if obj.code == 0 then bin = obj.stdout end

    return {
      cmd = { bin },
    }
  end,
  desc = "Run multiple commands in parallel",
  tags = { overseer.TAG.BUILD },
  params = {},
  priority = 50,
  condition = {
    callback = function(search)
      local config_files = vim.fs.find(
        { "mprocs.yaml", "mprocs.yml" },
        { upward = true, type = "file", path = search.dir }
      )

      return #config_files > 0
    end,
  },
}
