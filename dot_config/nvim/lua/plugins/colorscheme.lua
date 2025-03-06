---@type LazySpec
return {
  {
    "gbprod/nord.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(hls, colors)
        hls["LightBulbSign"] = { fg = colors.aurora.orange }
        hls["MiniHiFIXME"] = { bg = colors.aurora.red, fg = colors.snow_storm.origin, bold = true }
        hls["MiniHiNOTE"] = { bg = colors.aurora.green, fg = colors.polar_night.bright, bold = true }
        hls["MiniHiPERF"] = { bg = colors.aurora.purple, fg = colors.polar_night.bright, bold = true }
        hls["MiniHiTODO"] = { bg = colors.frost.artic_ocean, fg = colors.snow_storm.origin, bold = true }
        hls["MiniHiWARN"] = { bg = colors.aurora.yellow, fg = colors.polar_night.bright, bold = true }
        hls["RainbowBlue"] = { fg = colors.frost.artic_ocean, blend = 0 }
        hls["RainbowCyan"] = { fg = colors.frost.polar_water, blend = 0 }
        hls["RainbowGreen"] = { fg = colors.aurora.green, blend = 0 }
        hls["RainbowOrange"] = { fg = colors.aurora.orange, blend = 0 }
        hls["RainbowRed"] = { fg = colors.aurora.red, blend = 0 }
        hls["RainbowViolet"] = { fg = colors.aurora.purple, blend = 0 }
        hls["RainbowYellow"] = { fg = colors.aurora.yellow, blend = 0 }
        hls["SnacksDashboardIcon"] = { fg = colors.aurora.red, bold = true }
        hls["SnacksDashboardSpecial"] = { fg = colors.aurora.yellow, bold = true }
      end,
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = vim.fn.has "win32" == 0,
    optional = true, -- no needed for nord since the them is unique
    event = "VeryLazy",
    opts = {
      update_interval = 5000,
      set_dark_mode = function() vim.cmd [[set background=dark]] end,
      set_light_mode = function() vim.cmd [[set background=light]] end,
    },
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = { colorscheme = "nord" },
  },
}
