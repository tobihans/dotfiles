---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<Leader>th",
        function()
          local cmd = string.format(
            [[%dToggleTerm size=10 direction=horizontal name='Interactive Terminal %d' ]],
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
            [[%dToggleTerm size=10 direction=vertical name='Interactive Terminal %d' ]],
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
        "<Leader>tP",
        function() require("astrocore").toggle_term_cmd "posting" end,
        desc = "ToggleTerm Posting",
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
