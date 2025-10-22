---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<Leader>th",
        function()
          local cmd = string.format(
            [[%dToggleTerm direction=horizontal name='Interactive Terminal %d']],
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
            [[%dToggleTerm direction=vertical name='Interactive Terminal %d']],
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
        function()
          require("astrocore").toggle_term_cmd {
            cmd = "goose project",
            direction = "horizontal",
            display_name = "Goose",
          }
        end,
        desc = "ToggleTerm goose",
        mode = { "n", "t" },
      },
      {
        "<F3>",
        function()
          require("astrocore").toggle_term_cmd {
            cmd = "crush",
            -- direction = "float",
            direction = "tab",
            display_name = "Crush",
          }
        end,
        desc = "ToggleTerm crush",
        mode = { "n", "t" },
      },
    },
    opts = function(_, opts)
      opts.size = function(term)
        return (term.direction == "horizontal" and (vim.o.lines * 0.4) or (vim.o.columns * 0.4))
      end
      opts.direction = "float"
      opts.on_open = function(term)
        local setl = function(name, value)
          vim.api.nvim_set_option_value(name, value, {
            win = term.window,
          })
        end

        setl("number", false)
        setl("relativenumber", false)
        setl("signcolumn", "no")
        setl("statuscolumn", "")
        setl("winfixbuf", true)
        -- setl("winfixheight", true)
        -- setl("winfixwidth", true)
      end

      return opts
    end,
  },
}
