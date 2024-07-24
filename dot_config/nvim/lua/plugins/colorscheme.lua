---@type LazySpec
return {
  {
    "rmehri01/onenord.nvim",
    enabled = false,
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
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    init = function()
      vim.g.everforest_background = "soft"
      vim.g.everforest_enable_italic = true
      vim.g.everforest_diagnostic_virtual_text = "colored"
      vim.g.everforest_better_performance = 1
    end,
  },
  {
    "rose-pine/neovim",
    enabled = false,
    name = "rose-pine",
    opts = {
      dark_variant = "moon",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      background = {
        light = "latte",
        dark = "frappe",
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
