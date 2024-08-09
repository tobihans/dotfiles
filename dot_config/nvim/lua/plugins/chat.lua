---@type LazySpec
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      opts = { panel = { enabled = false }, suggestion = { enabled = false } },
    },
  },
  cmd = { "CopilotChat" },
  opts = {
    question_header = "",
    answer_header = "**  Copilot** ",
    error_header = "**  Error** ",
    separator = "󱕆 ",
    window = {
      layout = "float",
      relative = "editor",
      border = "rounded",
      width = 0.8,
      height = 0.6,
      title = "  Copilot Chat  ",
      footer = "󰭹",
      zindex = 5,
    },
  },
}
