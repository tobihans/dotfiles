---@diagnostic disable: missing-fields
---@type LazySpec
return {
  { "tiagovla/scope.nvim", event = "VeryLazy", priority = 1500 },
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
    "akinsho/git-conflict.nvim",
    event = "User AstroGitFile",
    cmd = { "GitConflictListQf" },
    keys = {
      { "<Leader>gq", "<cmd>GitConflictListQf<cr>", desc = "Git Conflict List" },
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
}
