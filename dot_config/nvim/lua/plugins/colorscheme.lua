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
      search = { theme = "vscode" }, -- theme for highlighting search results
      styles = {
        comments = { italic = true },
        keywords = {},
        functions = {},
        variables = {},
      },
    },
    config = true,
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 10000,
    lazy = false,
    enabled = false, -- TODO: Enable later
    opts = {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
      },
    },
  },
}
