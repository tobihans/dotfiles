---@type LazySpec
return {
  {
    "rebelot/kanagawa.nvim",
    enabled = false,
    opts = {
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    opts = {},
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = { colorscheme = "poimandres" },
  },
}
