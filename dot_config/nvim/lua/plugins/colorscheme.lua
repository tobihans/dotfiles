---@type LazySpec
return {
  {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      background = {
        dark = "ink",
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
