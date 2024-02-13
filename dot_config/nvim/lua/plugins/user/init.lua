---@diagnostic disable: missing-fields
-- luacheck: globals vim

---@type LazySpec
return {
  { "kaarmu/typst.vim", ft = "typst" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "wakatime/vim-wakatime", lazy = false },
  { "mg979/vim-visual-multi", lazy = false },
  { "folke/zen-mode.nvim", cmd = "ZenMode" },
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
}
