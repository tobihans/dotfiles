---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    init = function()
      require("which-key").register {
        ["<Leader>t"] = {
          h = {
            function() vim.cmd(vim.v.count .. "ToggleTerm size=10 direction=horizontal") end,
            "ToggleTerm horizontal split",
          },
          v = {
            function() vim.cmd(vim.v.count .. "ToggleTerm size=80 direction=vertical") end,
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
        },
      }
    end,
    opts = {
      size = function(term)
        if term.direction == "vertical" and term.cmd:sub(1, 2) == "gh" then
          return 35
        else
          return 10
        end
      end,
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
      end,
    },
  },
}
