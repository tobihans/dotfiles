---@type LazySpec
return {
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
        dadbod_ui = true,
        diffview = true,
        grug_far = true,
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
        render_markdown = true,
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
}
