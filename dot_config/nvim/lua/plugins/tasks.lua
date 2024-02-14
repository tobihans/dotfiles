return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerBuild",
      "OverseerClearCache",
      "OverseerClose",
      "OverseerDeleteBundle",
      "OverseerInfo",
      "OverseerLoadBundle",
      "OverseerOpen",
      "OverseerQuickAction",
      "OverseerRun",
      "OverseerRunCmd",
      "OverseerSaveBundle",
      "OverseerTaskAction",
      "OverseerToggle",
    },
    opts = {
      strategy = {
        "toggleterm",
        use_shell = true,
        direction = "horizontal",
        quit_on_exit = "never",
      },
      templates = { "builtin" },
      task_list = {
        direction = "right",
      },
    },
    init = function()
      require("which-key").register {
        ["<Leader>Or"] = { "<cmd>OverseerRun<CR>", " Run Task" },
        ["<Leader>Ot"] = { "<cmd>OverseerToggle<CR>", " Toggle tasks" },
      }
    end,
  },
}
