---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "onenord",
    },
  },
  {
    "rmehri01/onenord.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      borders = true,
      fade_nc = false,
      styles = {
        comments = "italic",
        diagnostics = "undercurl",
      },
    },
  },
  -- {
  --   "mcchrish/zenbones.nvim",
  --   lazy = false,
  --   dependencies = { "rktjmp/lush.nvim" },
  -- },
}
