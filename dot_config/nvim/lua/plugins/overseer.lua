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
      component_aliases = {
        default = {
          { "display_duration",    detail_level = 2 },
          "on_output_summarize",
          "on_exit_set_status",
          "on_complete_notify",
          { "on_complete_dispose", require_view = { "SUCCESS", "FAILURE" }, timeout = 2400 },
        },
      },
    },
  },
}
