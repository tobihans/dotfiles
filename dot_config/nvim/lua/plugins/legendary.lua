---@type LazySpec
return {
  "mrjones2014/legendary.nvim",
  dependencies = { "kkharji/sqlite.lua" },
  priority = 10000,
  lazy = false,
  keys = {
    -- I'm only interested in running my own functions with this.
    -- I already have telescope pickers for commands and many other things.
    { "<Leader>fl", "<cmd>Legendary functions<cr>", desc = "Legendary" },
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
      -- TODO: Still some ideas from https://www.reddit.com/r/neovim/comments/um3epn/what_are_your_prizedfavorite_lua_functions/ :)
      {
        require("utilities").compare_to_clipboard,
        description = "Compare current buffer to clipboard",
      },
    },
  },
}
