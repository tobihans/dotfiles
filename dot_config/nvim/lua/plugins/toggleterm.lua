---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    init = function()
      require("which-key").add {
        {
          "<Leader>th",
          function()
            vim.cmd(
              vim.v.count1
                .. "ToggleTerm size=10 direction=horizontal "
                .. "name='Interactive Terminal "
                .. vim.v.count1
                .. "'"
            )
          end,
          desc = "ToggleTerm horizontal split",
        },
        {
          "<Leader>tv",
          function()
            vim.cmd(
              vim.v.count1
                .. "ToggleTerm size=80 direction=vertical "
                .. "name='Interactive Terminal "
                .. vim.v.count1
                .. "'"
            )
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
      }
    end,
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
        setl("winfixheight", true)
        setl("winfixwidth", true)
      end,
    },
  },
}
