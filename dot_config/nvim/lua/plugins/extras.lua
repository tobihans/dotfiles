---@diagnostic disable: missing-fields
---@type LazySpec
return {
  { "tiagovla/scope.nvim", event = "VeryLazy", priority = 1500 },
  { "NStefan002/screenkey.nvim", cmd = "Screenkey", config = true },
  -- { "folke/zen-mode.nvim", cmd = "ZenMode", keys = { { "<Leader>uZ", "<cmd>ZenMode<cr>", desc = "ZenMode" } } },
  {
    "kosayoda/nvim-lightbulb",
    event = "LspAttach",
    opts = {
      autocmd = { enabled = true },
      link_highlights = false,
      sign = {
        text = "",
        lens_text = "",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = nil,
    cmd = { "DiffviewOpen" },
    keys = {
      { "<Leader>gd", "<cmd>DiffviewOpen -- %<cr>", desc = "View Git diff" },
      { "<Leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    },
    opts = {
      default_args = {
        DiffviewOpen = { "--imply-local" },
        DiffviewFileHistory = {},
      },
    },
  },
  {
    "zeioth/garbage-day.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "LspAttach",
    opts = {
      grace_period = 60 * 30,
      excluded_lsp_clients = {
        "copilot",
        "dartls",
        "jdtls",
        "rust-analyzer",
      },
    },
    config = true,
  },
  {
    "mg979/vim-visual-multi",
    event = "User AstroFile",
    init = function()
      vim.g.VM_leader = "<Localleader>v"
      vim.g.VM_default_mappings = 1
      vim.g.VM_mouse_mappings = 1
      vim.g.VM_quit_after_leaving_insert_mode = 0
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
    "folke/drop.nvim",
    enabled = vim.fn.has "win32" == 0,
    event = "User AstroFile",
    opts = function()
      local themes = {
        "bugs",
        "cats",
        "deepsea",
        "desert",
        "explorer",
        "farm",
        "garden",
        "jungle",
        "leaves",
        "lunar",
        "nocturnal",
        "ocean",
        "retro",
        "snow",
        "space",
        "spring",
        "stars",
        "summer",
        "tropical",
        "wilderness",
        "wildwest",
      }

      local opts = {
        max = 15,
        screensaver = 1000 * 60 * 15, -- 15 minutes
        theme = themes[math.random(#themes)],
        filetypes = {},
      }
      return opts
    end,
  },
}
