---@type LazySpec
return {
  { "theHamsta/nvim-dap-virtual-text" },
  { "mattn/emmet-vim", lazy = false },
  { "kaarmu/typst.vim", ft = "typst" },
  { "wakatime/vim-wakatime", lazy = false },
  { "folke/zen-mode.nvim", cmd = "ZenMode" },
  { "tiagovla/scope.nvim", lazy = false, priority = 1500 },
  { "kevinhwang91/nvim-bqf", event = "VeryLazy", ft = "qf" },
  { "kylechui/nvim-surround", event = "VeryLazy", lazy = false, opts = {} },
  { "akinsho/git-conflict.nvim", version = "*", config = true, event = "User AstroGitFile" },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    cmd = "Refactor",
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = function()
      vim.g.undotree_WindowLayout = 3
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
    opts = { snippet_engine = "luasnip" },
    config = true,
  },
  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = function(opts, _)
      local themes = { "leaves", "snow", "stars", "spring", "summer" }
      opts = {
        max = 65,
        screensaver = 1000 * 60 * 5,
        theme = themes[math.random(#themes)],
        filetypes = { "dashboard", "alpha", "starter" },
      }
      return opts
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
    config = function()
      vim.g.VM_default_mappings = 1
      vim.g.VM_mouse_mappings = 0

      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Select Cursor Down"] = "<M-C-Down>",
        ["Select Cursor Up"] = "<M-C-Up>",
        -- Enable undo/redo experimental feature
        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
      }
    end,
  },
}
