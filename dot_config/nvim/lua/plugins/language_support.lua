---@type LazySpec
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
      file_types = { "markdown", "noice", "octo" },
      render_modes = { "n", "v", "c" },
    },
  },
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = { { "<Leader>lg", "<cmd>Neogen<cr>", desc = "Generate symbol documentation" } },
    opts = { snippet_engine = "nvim" },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
    keys = {
      { "<Leader>rr", function() require("refactoring").select_refactor() end, desc = "Refactors" },
      { "<Leader>rp", function() require("refactoring").debug.printf { below = true } end, desc = "Debug print" },
      {
        "<Leader>rv",
        function() require("refactoring").debug.print_var { below = true } end,
        desc = "Debug print var",
      },
      { "<Leader>rc", function() require("refactoring").debug.cleanup {} end, desc = "Debug cleanup" },
      {
        "<Leader>rr",
        function() require("refactoring").select_refactor() end,
        desc = "Refactors",
        mode = "x",
      },
      {
        "<Leader>rv",
        function() require("refactoring").debug.print_var { below = true } end,
        desc = "Debug print var",
        mode = "x",
      },
    },
    init = function()
      require("which-key").add {
        { "<Leader>r", group = "󱌣 Refactoring", mode = { "n", "v" } },
      }
    end,
    config = true,
  },
}
