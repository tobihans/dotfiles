---@type LazySpec
return {
  {
    "yetone/avante.nvim",
    event = "User AstroFile",
    -- version = false,
    version = "0.0.9",
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
        "<leader>As",
        function() require("utilities.pickers").avante_switch_llm() end,
        desc = "avante: switch llm",
      },
    },
    opts = {
      provider = "copilot",
      copilot = {
        model = "claude-3.5-sonnet",
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
        ask = "<leader>Aa",
        edit = "<leader>Ae",
        refresh = "<leader>Ar",
        focus = "<leader>Af",
        toggle = {
          default = "<leader>At",
          debug = "<leader>Ad",
          hint = "<leader>Ah",
          suggestion = "<leader>As",
          repomap = "<leader>AR",
        },
      },
      vendors = {
        ---@type AvanteProvider
        groq = {
          endpoint = "https://api.groq.com/openai/v1/chat/completions",
          model = "llama-3.1-70b-versatile",
          api_key_name = "GROQ_API_KEY",
          parse_curl_args = function(opts, code_opts)
            return {
              url = opts.endpoint,
              headers = {
                ["Accept"] = "application/json",
                ["Content-Type"] = "application/json",
                ["Authorization"] = "Bearer " .. os.getenv(opts.api_key_name),
              },
              body = {
                model = opts.model,
                messages = require("avante.providers.openai").parse_messages(code_opts),
                temperature = 0,
                max_tokens = 4096,
                stream = true,
              },
            }
          end,
          parse_response_data = function(data_stream, event_state, opts)
            require("avante.providers").openai.parse_response(data_stream, event_state, opts)
          end,
        },
      },
    },
    config = function(_, opts)
      require("avante_lib").load()
      require("avante").setup(opts)
    end,
  },
}
