---@type LazySpec
return {
  -- { "nushell/tree-sitter-nu", ft = "nu" },
  { "OXY2DEV/helpview.nvim", ft = "help" },
  { "tobihans/vim-caddyfile", ft = "caddyfile" },
  { "kaarmu/typst.vim", ft = "typst", init = function() vim.g.typst_syntax_highlight = 0 end },
  { "tpope/vim-rails", ft = { "ruby", "eruby" } },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    opts = {
      file_types = { "markdown", "Avante" },
      render_modes = { "n", "v", "i", "c" },
    },
  },
  --
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = { { "<Leader>lg", "<cmd>Neogen<cr>", desc = "Generate symbol documentation" } },
    opts = { snippet_engine = "luasnip" },
    config = true,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    event = "User AstroFile",
    init = function()
      local wk = require "which-key"

      wk.add {
        { "<Leader>r", group = "󱌣 Refactoring", mode = { "n", "v" } },
        { "<Leader>rr", function() require("telescope").extensions.refactoring.refactors() end, desc = "Refactors" },
        { "<Leader>rp", function() require("refactoring").debug.printf { below = true } end, desc = "Debug print" },
        {
          "<Leader>rv",
          function() require("refactoring").debug.print_var { below = true } end,
          desc = "Debug print var",
        },
        { "<Leader>rc", function() require("refactoring").debug.cleanup {} end, desc = "Debug cleanup" },
      }

      wk.add {
        {
          mode = { "x" },
          { "<Leader>rr", function() require("telescope").extensions.refactoring.refactors() end, desc = "Refactors" },
          {
            "<Leader>rv",
            function() require("refactoring").debug.print_var { below = true } end,
            desc = "Debug print var",
          },
        },
      }
    end,
    config = true,
  },
}
