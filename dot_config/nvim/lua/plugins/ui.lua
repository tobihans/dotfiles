---@type LazySpec
return {
  "AstroNvim/astroui",
  opts = {
    icons = {
      Clock = "\u{e641}",
      Calendar = "\u{f455}",
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
        -- tab = { "\u{e0ba}", "\u{e0bc}" },
        -- tab = { "\u{e0b2}\u{e0c6}", "\u{e0b0}" },
        tab = { "\u{e0d4}", "\u{e0d2}" },
        breadcrumbs = "  ",
        path = "  ",
      },
    },
  },
}
