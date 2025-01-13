---@type LazySpec
return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      term_colors = true,
      background = {
        light = "latte",
        dark = "frappe",
      },
      custom_highlights = function(colors)
        return {
          LightBulbSign = { fg = colors.rosewater },
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
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      dark_variant = "moon",
      enable = {
        legacy_highlights = false,
        migrations = true,
      },
      highlight_groups = {
        RainbowRed = { fg = "love", blend = 0 },
        RainbowYellow = { fg = "gold", blend = 0 },
        RainbowBlue = { fg = "pine", blend = 0 },
        RainbowOrange = { fg = "#f7914d", blend = 0 },
        RainbowGreen = { fg = "#a6d089", blend = 0 },
        RainbowViolet = { fg = "iris", blend = 0 },
        RainbowCyan = { fg = "foam", blend = 0 },
        LightBulbSign = { fg = "rosewater" },
        MiniHiFIXME = { bg = "love", fg = "surface", bold = true },
        MiniHiWARN = { bg = "gold", fg = "surface", bold = true },
        MiniHiTODO = { bg = "foam", fg = "surface", bold = true },
        MiniHiNOTE = { bg = "#098d8f", fg = "text", bold = true },
        MiniHiPERF = { bg = "rose", fg = "surface", bold = true },
      },
    },
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
