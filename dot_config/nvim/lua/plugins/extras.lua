---@diagnostic disable: missing-fields

---@type LazySpec
return {
  { "tamton-aquib/duck.nvim" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "wakatime/vim-wakatime", lazy = false },
  { "tiagovla/scope.nvim", lazy = false, priority = 1500 },
  { "kylechui/nvim-surround", event = "VeryLazy", lazy = false, opts = {} },
  { "folke/zen-mode.nvim", cmd = "ZenMode", keys = { { "<Leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" } } },
  {
    "zeioth/garbage-day.nvim",
    enabled = true,
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      excluded_lsp_clients = {
        "copilot",
        "jdtls",
        "rust-analyzer",
      },
    },
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<Leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" } },
    opts = {},
    config = true,
  },
  {
    "mg979/vim-visual-multi",
    init = function()
      vim.g.VM_leader = "\\"
      vim.g.VM_default_mappings = 0
      vim.g.VM_mouse_mappings = 0
      vim.g.VM_quit_after_leaving_insert_mode = 1
      vim.g.VM_insert_special_keys = { "c-v", "c-a", "c-e" }
      vim.g.VM_reindent_filetypes = { "python", "yaml" }

      vim.g.VM_maps = {
        ["Find Under"] = "<C-n>",
        ["Find Subword Under"] = "<C-n>",
        ["Select Cursor Down"] = "<C-M-j>",
        ["Select Cursor Up"] = "<C-M-k>",
        ["Reselect Last"] = "<C-M-.>",
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
    keys = { { "<Leader>gq", "<cmd>GitConflictListQf<cr>", desc = "Git Conflicts quickfix" } },
    opts = { disable_diagnostics = false },
    config = true,
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
    keys = { { "<Leader>lg", "<cmd>Neogen<cr>", desc = "Generate symbol documentation" } },
    opts = { snippet_engine = "luasnip" },
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
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    init = function()
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
    end,
    config = true,
  },
}
