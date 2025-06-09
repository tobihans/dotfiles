---@type LazySpec
return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 2000,
    opts = {
      styles = {
        comments = "italic",
      },
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    enabled = vim.fn.has "win32" == 0,
    event = "VeryLazy",
    opts = {
      update_interval = 7500,
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme "terafox"
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme "dawnfox"
      end,
    },
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = { colorscheme = "duskfox" },
  },
}
