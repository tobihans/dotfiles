---@type LazySpec
return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>ss",
        function() require("grug-far").open {} end,
        desc = "Grug",
      },
      {
        "<leader>sf",
        function() require("grug-far").open { prefills = { paths = vim.fn.expand "%" } } end,
        desc = "Grug (current file)",
      },
      {
        "<leader>sc",
        function() require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } } end,
        desc = "Grug (current word)",
      },
      {
        "<leader>ss",
        function() require("grug-far").with_visual_selection {} end,
        desc = "Grug",
        mode = "v",
      },
      {
        "<leader>sf",
        function() require("grug-far").with_visual_selection { prefills = { paths = vim.fn.expand "%" } } end,
        desc = "Grug (current file)",
        mode = "v",
      },
    },
    opts = {
      transient = true,
    },
  },
}
