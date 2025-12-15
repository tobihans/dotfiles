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
    keys = {
      { "<Leader>or", "<cmd>OverseerRun<cr>",    desc = " Run Task" },
      { "<Leader>ot", "<cmd>OverseerToggle<CR>", desc = " Toggle tasks" },
    },
    opts = {
      templates_dirs = { "overseer" },
      task_list = {
        direction = "right",
      },
    },
  },
}
