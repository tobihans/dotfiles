---@type LazySpec
return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<Leader>ss",
        function() require("grug-far").open {} end,
        desc = "Grug",
      },
      {
        "<Leader>sf",
        function() require("grug-far").open { prefills = { paths = vim.fn.expand "%" } } end,
        desc = "Grug (current file)",
      },
      {
        "<Leader>sc",
        function() require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } } end,
        desc = "Grug (current word)",
      },
      {
        "<Leader>ss",
        function() require("grug-far").with_visual_selection {} end,
        desc = "Grug",
        mode = "v",
      },
      {
        "<Leader>sf",
        function() require("grug-far").with_visual_selection { prefills = { paths = vim.fn.expand "%" } } end,
        desc = "Grug (current file)",
        mode = "v",
      },
    },
    opts = {
      transient = true,
      engines = {
        astgrep = {
          path = "ast-grep",
        },
      },
    },
  },
}
