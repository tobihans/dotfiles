---@type LazySpec
return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    init = function()
      require("which-key").register {
        ["<Leader>Oo"] = { "<cmd>Octo<cr>", " Pick" },
        ["<Leader>Oa"] = { "<cmd>Octo actions<cr>", " Actions" },
      }
    end,
    config = true,
    opts = {
      enable_builtin = true,
    },
  },
  {
    "topaxi/gh-actions.nvim",
    cmd = "GhActions",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    opts = {
      refresh_interval = 7,
      icons = {
        workflow_dispatch = "⚡️",
        conclusion = {
          success = "✓",
          failure = "󰅖",
          startup_failure = "",
        },
      },
      split = {
        size = 48,
        win_options = {
          wrap = false,
          number = false,
          foldlevel = nil,
          foldcolumn = "0",
          signcolumn = "no",
          cursorcolumn = false,
          relativenumber = false,
        },
      },
    },
    config = true,
  },
}
