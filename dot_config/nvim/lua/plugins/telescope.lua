---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-smart-history.nvim",
      dependencies = { "kkharji/sqlite.lua" },
    },
    { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
  },
  init = function()
    local wk = require "which-key"
    wk.add {
      {
        "<Leader>fg",
        function() require("telescope-live-grep-args.shortcuts").grep_word_under_cursor() end,
        desc = "Find word under cursor",
      },
      {
        "<Leader>fw",
        function() require("telescope").extensions.live_grep_args.live_grep_args() end,
        desc = "Find words",
      },
    }

    wk.add {
      {
        mode = { "v" },
        { "<Leader>f", group = " Find" },
        {
          "<Leader>fv",
          function() require("telescope-live-grep-args.shortcuts").grep_visual_selection() end,
          desc = "Find visual selection",
        },
      },
    }
  end,
  opts = function(_, opts)
    local lga_actions = require "telescope-live-grep-args.actions"

    opts["extensions"] = {
      smart_history = {},
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
            ["<C-l>"] = lga_actions.quote_prompt { postfix = " -t" },
          },
        },
      },
    }
  end,
}
