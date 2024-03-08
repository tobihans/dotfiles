local M = {}

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

function M.new_file(opts)
  opts = opts or require("telescope.themes").get_dropdown {}
  pickers
    .new(opts, {
      prompt_title = "New File",
      finder = finders.new_table {
        results = vim.fn.getcompletion("", "filetype"),
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, _map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd "enew"
          vim.cmd("setlocal filetype=" .. selection[1])
        end)
        return true
      end,
    })
    :find()
end

return M
