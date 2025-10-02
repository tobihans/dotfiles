---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
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
            direction = "horizontal",
            display_name = "Crush",
          }
        end,
        desc = "ToggleTerm crush",
        mode = { "n", "t" },
      },
    },
    opts = {
      size = function(term) return (term.direction == "horizontal" and (vim.o.lines * 0.35) or (vim.o.columns * 0.4)) end,
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
