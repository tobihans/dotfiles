---@type LazySpec
return {
  "AstroNvim/astroui",
  opts = {
    icons = {
      Calendar = "",
      Clock = "",
    },
    status = {
      attributes = {
        mode = { bold = true },
      },
      colors = {},
      separators = {
        none = { "", "" },
        left = { "", "  " },
        right = { "  ", "" },
        center = { "  ", "  " },
        -- https://github.com/ryanoasis/powerline-extra-symbols
        -- tab = { "", "" },
        -- tab = { "", "" },
        -- tab = { "", "" },
        breadcrumbs = "  ",
        path = "  ",
      },
    },
  },
}
