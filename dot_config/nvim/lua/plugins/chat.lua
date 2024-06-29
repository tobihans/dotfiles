---@type LazySpec
return {
  "CopilotC-Nvim/CopilotChat.nvim",
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim" },
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
