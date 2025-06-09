local secret = require("utilities").secret

---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
    dependencies = {},
    keys = {},
    ---@type avante.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      provider = "gemini",
      file_selector = {},
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
        sidebar = {
          close = { "q" },
        },
      },
      providers = {
        gemini = {
          api_key_name = "cmd:get_develop_secret GEMINI_API_KEY",
          model = "gemini-2.5-flash-preview-05-20",
        },
      },
      vendors = {},
    },
    config = function(_, opts)
      require("avante_lib").load()
      require("avante").setup(opts)

      secret("TAVILY_API_KEY", true)
    end,
  },
}
