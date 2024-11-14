---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1500,
    opts = {
      term_colors = true,
      background = {
        light = "frappe",
        dark = "macchiato",
      },
      custom_highlights = function(colors)
        return {
          LightBulbSign = { fg = colors.rosewater },
          MiniJump = { fg = "fg", bg = "bg", bold = true },
          MiniHiFIXME = { bg = colors.red, fg = colors.crust, bold = true },
          MiniHiWARN = { bg = colors.yellow, fg = colors.crust, bold = true },
          MiniHiTODO = { bg = colors.teal, fg = colors.crust, bold = true },
          MiniHiNOTE = { bg = colors.green, fg = colors.crust, bold = true },
          MiniHiPERF = { bg = colors.pink, fg = colors.crust, bold = true },
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
