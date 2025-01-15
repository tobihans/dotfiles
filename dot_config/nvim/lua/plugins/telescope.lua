local function make_history_path()
  local history_path = vim.fn.expand "~/.local/share/nvim/databases"

  -- Check if directory exists and create it if not
  local stat = vim.uv.fs_stat(history_path)
  if not stat then vim.fn.mkdir(history_path, "p") end

  return history_path .. "/telescope_history.sqlite3"
end

---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    { "nvim-telescope/telescope-smart-history.nvim" },
  },
  keys = {
    {
      "<Leader>fc",
      function() require("telescope-live-grep-args.shortcuts").grep_word_under_cursor() end,
      desc = "Find word under cursor",
    },
    {
      "<Leader>fw",
      function() require("telescope").extensions.live_grep_args.live_grep_args() end,
      desc = "Find words",
    },
    {
      "<Leader>fv",
      function() require("telescope-live-grep-args.shortcuts").grep_visual_selection() end,
      mode = "v",
      desc = "Find visual selection",
    },
  },
  init = function()
    require("which-key").add {
      { "<Leader>f", group = " Find", mode = "v" },
    }
  end,
  opts = function(_, opts)
    local actions = require "telescope.actions"
    local lga_actions = require "telescope-live-grep-args.actions"

    opts.defaults.history = {
      path = make_history_path(),
      limit = 500,
    }

    opts.defaults.mappings = require("astrocore").extend_tbl(opts.defaults.mappings, {
      i = {
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-n>"] = actions.cycle_history_next,
      },
      n = {
        ["<C-p>"] = actions.cycle_history_prev,
        ["<C-n>"] = actions.cycle_history_next,
      },
    })

    opts["extensions"] = {
      live_grep_args = {
        auto_quoting = true,
        mappings = {
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
            ["<C-l>"] = lga_actions.quote_prompt { postfix = " -t" },
            ["<C-space>"] = actions.to_fuzzy_refine,
          },
        },
      },
    }
  end,
  config = function(...)
    require "astronvim.plugins.configs.telescope"(...)
    require("telescope").load_extension "smart_history"
    require("telescope").load_extension "live_grep_args"
  end,
}
