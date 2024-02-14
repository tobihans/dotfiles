---@type LazySpec
return {
  {
    "sourcegraph/sg.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    init = function()
      require("which-key").register {
        ["<Leader>fs"] = {
          "<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<CR>",
          "Search Sourcegraph",
        },
      }
    end,
    opts = {
      -- FIXME: This throws an error
      -- .../share/nvim/lazy/sg.nvim/lua/sg/cody/plugin/commands.lua:211: Invalid command (not found): CodyChat
      -- # stacktrace:
      --   - /sg.nvim/lua/sg/cody/plugin/commands.lua:211 _in_ **delete_command**
      --   - /sg.nvim/lua/sg/cody/plugin/commands.lua:228 _in_ **setup**
      --   - /sg.nvim/lua/sg/init.lua:40 _in_ **setup**

      -- enable_cody = false,
      accept_tos = true,
      on_attach = require("astrolsp").on_attach,
    },
    config = true,
  },
}
