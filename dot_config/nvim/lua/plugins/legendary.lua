local animals = {
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

---@type LazySpec
return {
  "mrjones2014/legendary.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  keys = {
    { "<space><space>", "<cmd>Legendary<cr>", desc = "Legendary" },
  },
  opts = {
    select_prompt = " Legendary ",
    include_builtin = false,
    include_legendary_cmds = false,
    col_separator_char = "",
    ---@param item LegendaryItem
    ---@return string[]
    default_item_formatter = function(item)
      local Toolbox = require "legendary.toolbox"
      local icon = ""
      if Toolbox.is_keymap(item) then
        icon = "󰌆"
      elseif Toolbox.is_command(item) then
        icon = ""
      elseif Toolbox.is_function(item) then
        icon = "󰡱"
      elseif Toolbox.is_itemgroup(item) then
        icon = "󰋃"
      end
      return { icon, item.description }
    end,
    sort = {
      frecency = {
        db_root = string.format("%s/legendary/", vim.fn.stdpath "data"),
        max_timestamps = 20,
      },
    },
    extensions = {
      which_key = false,
    },
    commands = {
      { ":CopilotChatToggle", description = "Copilot Chat" },
      { ":Screenkey", description = "Screen Key" },
      { ":DevdocsOpenFloat", description = "Search documentation" },
    },
    funcs = {
      {
        require("peek").open,
        description = "Preview markdown",
      },
      {
        require("peek").close,
        description = "Close markdown preview",
      },
      {
        require("utilities").compare_to_clipboard,
        description = "Compare current buffer to clipboard",
      },
      {
        function()
          for _ = 1, 5 do
            require("duck").hatch(animals[math.random(#animals)])
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
            close_on_exit = false,
          }
        end,
        description = "Watch GitHub Action run",
      },
    },
  },
}
