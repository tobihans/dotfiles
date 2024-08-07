---@diagnostic disable: missing-fields
---@type LazySpec
return {
  { "tamton-aquib/duck.nvim" },
  { "theHamsta/nvim-dap-virtual-text" },
  { "wakatime/vim-wakatime", event = "VeryLazy" },
  { "tiagovla/scope.nvim", event = "VeryLazy", priority = 1500 },
  { "NStefan002/screenkey.nvim", cmd = "Screenkey", config = true },
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
  { "folke/zen-mode.nvim", cmd = "ZenMode", keys = { { "<Leader>z", "<cmd>ZenMode<cr>", desc = "ZenMode" } } },
  {
    "kosayoda/nvim-lightbulb",
    dev = true,
    opts = {
      autocmd = { enabled = true },
      ignore = {
        clients = { "ruff_lsp", "copilot" },
        ft = {},
        actions_without_kind = true,
      },
      sign = {
        enabled = true,
        text = "",
        hl = "SpecialChar",
      },
    },
    config = true,
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
      grace_period = 60 * 30,
      excluded_lsp_clients = {
        "copilot",
        "dartls",
        "jdtls",
        "rust-analyzer",
        "vtsls",
      },
    },
    config = true,
  },
  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = { { "<Leader>fT", "<cmd>TodoTelescope<cr>", desc = "Find TODOs" } },
    opts = {},
    config = true,
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_leader = "<Localleader>v"
      vim.g.VM_default_mappings = 1
      vim.g.VM_mouse_mappings = 1
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
    config = function(_, __)
      require("which-key").add {
        { "<Localleader>v", group = "Visual Multi", mode = { "n", "v" } },
      }
    end,
  },
  {
    "akinsho/git-conflict.nvim",
    version = "*",
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
    enabled = vim.fn.has "win32" == 0,
    event = "VimEnter",
    opts = function()
      local themes = {
        "april_fools",
        "arcade",
        "art",
        "bakery",
        "beach",
        "bugs",
        "business",
        "candy",
        "cards",
        "carnival",
        "cats",
        "coffee",
        "cyberpunk",
        "deepsea",
        "desert",
        "dice",
        "diner",
        "emotional",
        "explorer",
        "farm",
        "garden",
        "jungle",
        "leaves",
        "lunar",
        "mathematical",
        "musical",
        "mystery",
        "nocturnal",
        "ocean",
        "pirate",
        "retro",
        "snow",
        "spa",
        "space",
        "spring",
        "stars",
        "summer",
        "summer",
        "temporal",
        "travel",
        "tropical",
        "urban",
        "wilderness",
        "wildwest",
      }

      local opts = {
        max = 40,
        screensaver = 1000 * 60 * 15, -- 15 minutes
        theme = themes[math.random(#themes)],
        filetypes = vim.g.neovide and {} or { "dashboard", "alpha", "starter" },
      }
      return opts
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
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
