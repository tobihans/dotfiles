---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<Leader>th",
        function()
          local cmd = string.format(
            [[%dToggleTerm size=10 direction=horizontal name='Interactive Terminal %d']],
            vim.v.count1,
            vim.v.count1
          )
          vim.cmd(cmd)
        end,
        desc = "ToggleTerm horizontal split",
      },
      {
        "<Leader>tv",
        function()
          local cmd = string.format(
            [[%dToggleTerm size=80 direction=vertical name='Interactive Terminal %d']],
            vim.v.count1,
            vim.v.count1
          )
          vim.cmd(cmd)
        end,
        desc = "ToggleTerm vertical split",
      },
      {
        "<Leader>td",
        function() require("astrocore").toggle_term_cmd "lazydocker" end,
        desc = "ToggleTerm lazydocker",
      },
      {
        "<Leader>tb",
        function() require("astrocore").toggle_term_cmd "btop" end,
        desc = "ToggleTerm btop",
      },
      {
        "<F1>",
        function() require("astrocore").toggle_term_cmd "goose project" end,
        desc = "ToggleTerm goose",
        mode = { "n", "t" },
      },
      {
        "<S-F1>",
        function() require("astrocore").toggle_term_cmd "opencode" end,
        desc = "ToggleTerm opencode",
        mode = { "n", "t" },
      },
    },
    opts = {
      direction = "float",
      on_open = function(terminal)
        local setl = function(name, value)
          vim.api.nvim_set_option_value(name, value, {
            win = terminal.window,
          })
        end

        setl("number", false)
        setl("relativenumber", false)
        setl("signcolumn", "no")
        setl("statuscolumn", "")
        setl("winfixbuf", true)
        -- setl("winfixheight", true)
        -- setl("winfixwidth", true)
      end,
    },
  },
}
