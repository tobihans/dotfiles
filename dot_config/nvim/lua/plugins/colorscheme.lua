---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "nord",
    },
  },
  {
    "gbprod/nord.nvim",
    priority = 10000,
    lazy = false,
    enabled = true,
    opts = {
      transparent = false,
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      diff = { mode = "fg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
      borders = true, -- Enable the border between verticaly split windows visible
      errors = { mode = "fg" }, -- Display mode for errors and diagnostics
      -- values : [bg|fg|none]
      search = { theme = "vscode" }, -- theme for highlighting search results
      -- values : [vim|vscode]
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = {},
        functions = {},
        variables = {},
      },
    },
    config = true,
  },
}
