local TRASH_CMD = { "trash-put", "-f" }

if vim.uv.os_uname().sysname == "Darwin" then TRASH_CMD = { "trash", "-s" } end

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    source_selector = {
      winbar = false,
    },
    filesystem = {
      window = {
        mappings = {
          ["d"] = "trash",
          ["D"] = "delete",
        },
      },
      commands = {
        trash = function(state)
          local inputs = require "neo-tree.ui.inputs"
          local path = state.tree:get_node().path
          local msg = ("Are you sure you want to trash '%s'?"):format(path)
          inputs.confirm(msg, function(confirmed)
            if confirmed then
              vim.system({ unpack(TRASH_CMD), path }, {}):wait()
              require("neo-tree.sources.manager").refresh(state.name)
            end
          end)
        end,
        trash_visual = function(state, selected_nodes)
          local inputs = require "neo-tree.ui.inputs"
          local msg = ("Are you sure you want to trash %d items?"):format(#selected_nodes)
          inputs.confirm(msg, function(confirmed)
            if confirmed then
              local paths = vim.iter(selected_nodes):map(function(n) return n.path end):totable()
              vim.system({ unpack(TRASH_CMD), unpack(paths) }, {}):wait()
              require("neo-tree.sources.manager").refresh(state.name)
            end
          end)
        end,
      },
    },
  },
}
