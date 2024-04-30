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
    -- TODO: Fix alpha dashboard being black first
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 10000,
    opts = {
      term_colors = true,
      transparent_background = true,
      compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
      background = {
        light = "latte",
        dark = "macchiato",
      },
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dap = true,
        gitsigns = true,
        headlines = true,
        mason = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underdotted" },
            hints = {},
            warnings = { "undercurl" },
            information = {},
          },
          inlay_hints = {
            background = false,
          },
        },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        octo = true,
        overseer = true,
        treesitter = true,
        treesitter_context = true,
        ufo = true,
        which_key = true,
        window_picker = true,
      },
    },
  },
}
