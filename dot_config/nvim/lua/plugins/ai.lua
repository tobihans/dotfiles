---@type LazySpec
return {
  {
    "olimorris/codecompanion.nvim",
    keys = {
      { "<F2>", "<cmd>CodeCompanion<cr>", desc = "Inline Assistant", mode = { "n", "v", "i" } },
      { "<F12>", "<cmd>CodeCompanionChat Toggle<cr>", desc = "󰭹 Open Chat Buffer", mode = { "n", "v", "i" } },
      { "<LocalLeader>ga", "<cmd>CodeCompanionChat Add<cr>", desc = "󱐏 Add to Chat Buffer", mode = "v" },
      { "<LocalLeader>gg", "<cmd>CodeCompanionActions<cr>", desc = " Code Companion Actions", mode = { "n", "v" } },
    },
    opts = {
      adapters = {
        http = {
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = {
                api_key = "cmd:get_develop_secret GEMINI_API_KEY",
              },
            })
          end,
          openrouter = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "https://openrouter.ai/api",
                api_key = "cmd:get_develop_secret OPENROUTER_API_KEY",
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = "qwen/qwen3-coder",
                },
              },
            })
          end,
          tavily = function()
            return require("codecompanion.adapters").extend("tavily", {
              env = {
                api_key = "cmd:get_develop_secret TAVILY_API_KEY",
              },
            })
          end,
        },
      },
      display = {
        action_palette = {
          provider = "snacks",
        },
        window = { width = 0.35 },
      },
      extensions = {},
      strategies = {
        chat = {
          adapter = "gemini",
          auto_scroll = false,
          keymaps = {
            clear = { modes = { n = "gX" }, opts = {} },
          },
          show_settings = true,
          slash_commands = {
            ["buffer"] = { opts = { provider = "snacks" } },
            ["fetch"] = { opts = { provider = "snacks" } },
            ["file"] = { opts = { provider = "snacks" } },
            ["help"] = { opts = { provider = "snacks" } },
            ["symbols"] = { opts = { provider = "snacks" } },
          },
        },
        inline = { adapter = { name = "openrouter", model = "qwen/qwen3-coder" } },
      },
    },
  },
}
