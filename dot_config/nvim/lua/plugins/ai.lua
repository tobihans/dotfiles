---@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = { enabled = false },
      suggestion = { enabled = false },
      filetypes = {
        ["*"] = false,
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    keys = {
      {
        "<leader>As",
        function() require("utilities.pickers").avante_switch_llm() end,
        desc = "avante: switch llm",
      },
    },
    opts = {
      provider = "copilot",
      windows = {
        width = 25,
        height = 30,
        sidebar_header = {
          align = "left",
          rounded = false,
        },
        input = {
          prefix = " ",
        },
      },
      mappings = {
        suggestion = {
          accept = "<C-Enter>",
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-Esc>",
        },
        ask = "<leader>Aa",
        edit = "<leader>Ae",
        refresh = "<leader>Ar",
        toggle = {
          default = "<leader>At",
          debug = "<leader>Ad",
          hint = "<leader>Ah",
          suggestion = "<leader>As",
        },
      },
    },
  },
}
