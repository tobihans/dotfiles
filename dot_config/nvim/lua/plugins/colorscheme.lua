---@type LazySpec
return {
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      background = {
        dark = "mist",
        light = "pearl",
      },
      overrides = function(_colors)
        return {
          WinSeparator = { link = "FloatBorder" },
        }
      end,
    },
  },

  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = { colorscheme = "kanso" },
  },
}
