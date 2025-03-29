---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    event = "User AstroFile",
    version = false,
    build = vim.fn.has "win32" == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    dependencies = {
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
    },
    keys = {
      {
        "<Leader>as",
        function() require("utilities.pickers").avante_switch_llm() end,
        desc = "avante: switch llm",
      },
    },
    ---@type avante.Config
    opts = {
      provider = "copilot",
      copilot = {
        model = "claude-3.5-sonnet",
      },
      file_selector = {
        provider = "telescope",
        provider_opts = {},
      },
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
        -- ask = "<Leader>Aa",
        -- edit = "<Leader>Ae",
        -- refresh = "<Leader>Ar",
        -- focus = "<Leader>Af",
        -- select_model = "<Leader>A?",
        -- select_history = "<Leader>Ah",
        -- toggle = {
        --   default = "<Leader>At",
        --   debug = "<Leader>Ad",
        --   hint = "<Leader>Ah",
        --   suggestion = "<Leader>As",
        --   repomap = "<Leader>AR",
        -- },
        sidebar = {
          close = { "q" },
        },
      },
      vendors = {
        ---@type AvanteProvider
        ---@diagnostic disable-next-line: missing-fields
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-coder",
        },
        ---@type AvanteProvider
        ---@diagnostic disable-next-line: missing-fields
        groq = {
          __inherited_from = "openai",
          endpoint = "https://api.groq.com/openai/v1/chat/completions",
          model = "llama-3.3-70b-versatile",
          api_key_name = "GROQ_API_KEY",
        },
      },
    },
    config = function(_, opts)
      require("avante_lib").load()
      require("avante").setup(opts)

      require("utilities").secret("TAVILY_API_KEY", true)
    end,
  },
}
