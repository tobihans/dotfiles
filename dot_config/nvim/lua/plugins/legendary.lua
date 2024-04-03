---@type LazySpec
return {
  "mrjones2014/legendary.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  priority = 10000,
  lazy = false,
  keys = {
    -- I'm only interested in running my own functions with this.
    -- I already have telescope pickers for commands and many other things.
    { "<space><space>", "<cmd>Legendary functions<cr>", desc = "Legendary" },
  },
  opts = {
    select_prompt = " Legendary ",
    include_builtin = false,
    include_legendary_cmds = false,
    sort = {
      frecency = {
        db_root = string.format("%s/legendary/", vim.fn.stdpath "data"),
        max_timestamps = 20,
      },
    },
    extensions = {
      which_key = false,
    },
    funcs = {
      { function() vim.cmd [[CopilotChatToggle]] end, description = "Copilot Chat" },
      {
        require("utilities").compare_to_clipboard,
        description = "Compare current buffer to clipboard",
      },
      {
        function()
          local candidates = {
            "🐉",
            "🦆",
            "🦕",
            "🐈",
            "🦀",
            "🦐",
            "🦜",
            "🐎",
            "🦖",
            "🐤",
            "🦑",
            "🐙",
            "🦎",
            "🐍",
            "🦚",
            "🦞",
            "🐢",
          }

          for _ = 1, 5 do
            require("duck").hatch(candidates[math.random(#candidates)])
          end
        end,
        description = "Release the duck 🦆",
      },
      {
        function()
          for _, duck in ipairs(require("duck").ducks_list) do
            duck["timer"]:stop()
            vim.api.nvim_win_close(duck["name"], true)
          end

          require("duck").ducks_list = {}
        end,
        description = "Catch the duck 🦆",
      },
      {
        function()
          require("astrocore").toggle_term_cmd {
            cmd = "gh run watch --exit-status",
            auto_scroll = true,
            close_on_exit = true,
            on_exit = function(_term, _job, exit_code, _name)
              if exit_code ~= 0 then
                require "notify"("😐 Looks like your run failed or there is nothing to watch !", "warn", {
                  title = "Github Actions",
                  icon = "",
                })
              end
            end,
          }
        end,
        description = "Watch GitHub Action run",
      },
    },
  },
}
