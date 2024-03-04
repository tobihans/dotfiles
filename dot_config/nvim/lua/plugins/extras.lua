---@diagnostic disable: missing-fields

---@type LazySpec
return {
  { "kaarmu/typst.vim", ft = "typst" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "wakatime/vim-wakatime", lazy = false },
  { "folke/zen-mode.nvim", cmd = "ZenMode" },
  -- { "tamton-aquib/keys.nvim", cmd = "KeysToggle" },
  { "tiagovla/scope.nvim", lazy = false, priority = 1500 },
  { "kylechui/nvim-surround", event = "VeryLazy", lazy = false, opts = {} },
  {
    "zeioth/garbage-day.nvim",
    enabled = false,
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      require("which-key").register {
        ["<Leader>fT"] = {
          "<cmd>TodoTelescope<CR>",
          "Find TODOs",
        },
      }
    end,
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
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_mouse_mappings = 0

      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Select Cursor Down"] = "<C-M-Down>",
        ["Select Cursor Up"] = "<C-M-Up>",
        -- Enable undo/redo experimental feature
        ["Undo"] = "u",
        ["Redo"] = "<C-r>",
      }
    end,
    lazy = false,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
    lazy = not require("utilities").has_conflicts(),
    cmd = "GitConflictListQf",
    event = "User AstroGitFile",
    opts = function(_, opts)
      opts.disable_diagnostics = false

      require("which-key").register {
        ["<Leader>gq"] = {
          function() vim.cmd [[GitConflictListQf]] end,
          "Git Conflicts quickfix",
          silent = true,
        },
      }

      return opts
    end,
    config = true,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    opts = function(_, opts)
      local wk = require "which-key"
      local name = "󱌣 Refactoring"

      require("telescope").load_extension "refactoring"

      wk.register {
        ["<Leader>r"] = {
          name = name,
          r = { function() require("telescope").extensions.refactoring.refactors() end, "Refactors" },
          p = { function() require("refactoring").debug.printf { below = true } end, "Debug print" },
          v = { function() require("refactoring").debug.print_var { below = true } end, "Debug print var" },
          c = { function() require("refactoring").debug.cleanup {} end, "Debug cleanup" },
        },
      }

      wk.register({
        ["<Leader>r"] = {
          name = name,
          r = { function() require("telescope").extensions.refactoring.refactors() end, "Refactors" },
          v = { function() require("refactoring").debug.print_var { below = true } end, "Debug print var" },
        },
      }, { mode = "x" })

      return opts
    end,
    config = true,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
    opts = function(_, opts)
      opts.snippet_engine = "luasnip"

      require("which-key").register {
        ["<Leader>lg"] = {
          function() vim.cmd [[Neogen]] end,
          "Generate symbol documentation",
          silent = true,
        },
      }

      return opts
    end,
    config = true,
  },
  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = function()
      local themes = { "leaves", "snow", "stars", "spring", "summer" }
      local opts = {
        max = 65,
        screensaver = 1000 * 60 * 15, -- 15 minutes
        theme = themes[math.random(#themes)],
        filetypes = { "dashboard", "alpha", "starter" },
      }
      return opts
    end,
  },
}
