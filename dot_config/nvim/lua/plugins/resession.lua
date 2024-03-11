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
  config = function(_, opts)
    local resession = require "resession"
    resession.setup(opts)

    -- NOTE: Highlights doesn't work on the current window when loading a session.
    resession.add_hook("post_load", function() vim.cmd [[edit %]] end)
  end,
}
