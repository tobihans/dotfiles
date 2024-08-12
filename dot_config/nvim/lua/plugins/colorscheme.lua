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
      term_colors = true,
      integrations = {
        aerial = true,
        diffview = true,
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
        nvim_surround = true,
        window_picker = true,
        overseer = true,
        which_key = true,
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
  {
    -- auto switch theme
    "f-person/auto-dark-mode.nvim",
    enabled = false,
    opts = {
      update_interval = 1200,
      set_dark_mode = function() vim.api.nvim_set_option_value("background", "dark", {}) end,
      set_light_mode = function() vim.api.nvim_set_option_value("background", "light", {}) end,
    },
  },
}
