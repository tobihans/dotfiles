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
      enable_cody = false,
      accept_tos = true,
      on_attach = require("astrolsp").on_attach,
    },
    config = true,
  },
}
