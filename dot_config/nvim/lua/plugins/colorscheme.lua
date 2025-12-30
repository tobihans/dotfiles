---@type LazySpec
return {
  -- {
  --   "webhooked/kanso.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     background = {
  --       dark = "ink",
  --       light = "pearl",
  --     },
  --     overrides = function(_colors)
  --       return {
  --         WinSeparator = { link = "FloatBorder" },
  --       }
  --     end,
  --   },
  -- },

  -- https://github.com/everviolet/nvim

  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "warm",
    },
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = { colorscheme = "onedark" },
  },
}
