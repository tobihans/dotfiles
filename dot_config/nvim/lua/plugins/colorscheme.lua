---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      background = {
        light = "latte",
        dark = "frappe",
      },
      custom_highlights = function(colors)
        return {
          MiniJump = { bold = true, fg = "fg", bg = "bg" },
          MiniHipatternsFixme = { bg = colors.red, fg = colors.crust, bold = true },
          MiniHipatternsWarn = { bg = colors.yellow, fg = colors.crust, bold = true },
          MiniHipatternsTodo = { bg = colors.teal, fg = colors.crust, bold = true },
          MiniHipatternsNote = { bg = colors.green, fg = colors.crust, bold = true },
          MiniHipatternsPerf = { bg = colors.pink, fg = colors.crust, bold = true },
        }
      end,
      integrations = {
        aerial = true,
        dadbod_ui = true,
        dap = true,
        dap_ui = true,
        diffview = true,
        grug_far = true,
        indent_blankline = {
          enabled = true,
          scope_color = "",
          colored_indent_levels = true,
        },
        mason = false,
        neotree = false,
        neotest = true,
        treesitter = true,
        notify = true,
        window_picker = true,
        overseer = true,
        render_markdown = true,
        which_key = true,
      },
    },
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
