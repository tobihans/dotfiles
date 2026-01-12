---@type LazySpec
return {
  "folke/snacks.nvim",
  specs = {
    {
      "AstroNvim/astrolsp",
      opts = function(_, opts)
        local fileOperations = {
          willRename = true,
          didRename = true,
          willCreate = true,
          didCreate = true,
          willDelete = true,
          didDelete = true,
        }
        opts.capabilities =
            vim.tbl_deep_extend("force", opts.capabilities or {}, { workspace = { fileOperations = fileOperations } })
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      opts = function(_, opts)
        local function on_move(data) Snacks.rename.on_rename_file(data.source, data.destination) end
        local events = require "neo-tree.events"
        opts.event_handlers = opts.event_handlers or {}
        vim.list_extend(opts.event_handlers, {
          { event = events.FILE_MOVED,   handler = on_move },
          { event = events.FILE_RENAMED, handler = on_move },
        })
      end,
    },
  },
  ---@type snacks.Config
  opts = {
    rename = {},
  },
}
