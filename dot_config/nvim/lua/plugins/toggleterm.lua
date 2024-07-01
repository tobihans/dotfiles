---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    init = function()
      require("which-key").register {
        ["<Leader>t"] = {
          h = {
            function()
              vim.cmd(
                vim.v.count1
                  .. "ToggleTerm size=10 direction=horizontal "
                  .. "name='Interactive Terminal "
                  .. vim.v.count1
                  .. "'"
              )
            end,
            "ToggleTerm horizontal split",
          },
          v = {
            function()
              vim.cmd(
                vim.v.count1
                  .. "ToggleTerm size=80 direction=vertical "
                  .. "name='Interactive Terminal "
                  .. vim.v.count1
                  .. "'"
              )
            end,
            "ToggleTerm vertical split",
          },
          d = {
            function() require("astrocore").toggle_term_cmd "lazydocker" end,
            "ToggleTerm lazydocker",
          },
          b = {
            function() require("astrocore").toggle_term_cmd "btop" end,
            "ToggleTerm btop",
          },
          g = {
            function() require("astrocore").toggle_term_cmd "gh dash" end,
            "ToggleTerm Github Dashboard",
          },
        },
      }
    end,
    opts = {
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
      end,
    },
  },
}
