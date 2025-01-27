---@type LazySpec
return {
  { "OXY2DEV/helpview.nvim", ft = "help" },
  { "tobihans/vim-caddyfile", ft = "caddyfile" },
  { "kaarmu/typst.vim", ft = "typst", init = function() vim.g.typst_syntax_highlight = 0 end },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    opts = {
      file_types = { "Avante", "markdown", "noice" },
      render_modes = { "n", "v", "i", "c" },
    },
  },
  --
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = { { "<Leader>lg", "<cmd>Neogen<cr>", desc = "Generate symbol documentation" } },
    opts = { snippet_engine = "nvim" },
    config = true,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
    keys = {
      { "<Leader>rr", function() require("telescope").extensions.refactoring.refactors() end, desc = "Refactors" },
      { "<Leader>rp", function() require("refactoring").debug.printf { below = true } end, desc = "Debug print" },
      {
        "<Leader>rv",
        function() require("refactoring").debug.print_var { below = true } end,
        desc = "Debug print var",
      },
      { "<Leader>rc", function() require("refactoring").debug.cleanup {} end, desc = "Debug cleanup" },
      {
        "<Leader>rr",
        function() require("telescope").extensions.refactoring.refactors() end,
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
