---@type LazySpec
return {
  "stevearc/resession.nvim",
  opts = function(_, opts)
    opts.extensions = {
      astrocore = {},
      quickfix = {},
      scope = {},
      aerial = {},
      overseer = {
        unique = true,
        recent_first = true,
      },
    }
  end,
  config = true,
}
