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
      { "<Leader>Or", "<cmd>OverseerRun<cr>", desc = " Run Task" },
      { "<Leader>Ot", "<cmd>OverseerToggle<CR>", desc = " Toggle tasks" },
    },
    opts = {
      strategy = {
        "toggleterm",
        use_shell = false,
        direction = "horizontal",
        quit_on_exit = "success",
        on_create = function(terminal) terminal.display_name = string.format("%s", terminal.cmd) end,
      },
      templates = { "builtin", "custom" },
      task_list = {
        direction = "right",
      },
    },
  },
}
