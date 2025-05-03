---@type LazySpec
return {
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
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
      update_interval = 10000,
      set_dark_mode = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme "duskfox"
      end,
      set_light_mode = function()
        vim.o.background = "light"
        vim.cmd.colorscheme "nightfox"
      end,
    },
  },
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = { colorscheme = "duskfox" },
  },
}
