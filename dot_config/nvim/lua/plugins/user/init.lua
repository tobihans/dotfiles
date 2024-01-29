---@diagnostic disable: missing-fields
-- luacheck: globals vim

---@type LazySpec
return {
  { "kaarmu/typst.vim", ft = "typst" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "wakatime/vim-wakatime", lazy = false },
  { "folke/zen-mode.nvim", cmd = "ZenMode" },
  { "tiagovla/scope.nvim", lazy = false, priority = 1500 },
  { "kylechui/nvim-surround", event = "VeryLazy", lazy = false, opts = {} },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
    config = true,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    ft = "qf",
    opts = {
      filter = {
        fzf = {
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "│" },
        },
      },
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "User AstroGitFile",
    init = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_template = "  <author> • <date> • <summary> -- <sha>"
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    lazy = not require("utilities").has_conflicts(),
    cmd = "GitConflictListQf",
    event = "User AstroGitFile",
    opts = {
      disable_diagnostics = false,
    },
    init = function()
      require("which-key").register {
        ["<leader>gq"] = {
          function() vim.cmd [[GitConflictListQf]] end,
          "Git Conflicts quickfix",
          silent = true,
        },
      }
    end,
    config = true,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = {},
    init = function()
      local wk = require "which-key"
      local name = "󱌣 Refactoring"

      require("telescope").load_extension "refactoring"

      wk.register {
        ["<leader>r"] = {
          name = name,
          r = { function() require("telescope").extensions.refactoring.refactors() end, "Refactors" },
          p = { function() require("refactoring").debug.printf { below = true } end, "Debug print" },
          v = { function() require("refactoring").debug.print_var { below = true } end, "Debug print var" },
          c = { function() require("refactoring").debug.cleanup {} end, "Debug cleanup" },
        },
      }

      wk.register({
        ["<leader>r"] = {
          name = name,
          r = { function() require("telescope").extensions.refactoring.refactors() end, "Refactors" },
          v = { function() require("refactoring").debug.print_var { below = true } end, "Debug print var" },
        },
      }, { mode = "x" })
    end,
    config = true,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
    opts = { snippet_engine = "luasnip" },
    init = function()
      require("which-key").register {
        ["<leader>lg"] = {
          function() vim.cmd [[Neogen]] end,
          "Generate symbol documentation",
          silent = true,
        },
      }
    end,
    config = true,
  },
  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = function()
      -- local themes = { "leaves", "snow", "stars", "spring", "summer" }
      local opts = {
        max = 65,
        screensaver = 1000 * 60 * 5,
        -- theme = themes[math.random(#themes)],
        theme = "snow", -- to match my nord theme
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
