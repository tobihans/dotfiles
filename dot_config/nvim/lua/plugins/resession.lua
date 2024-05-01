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
    -- HACK: Restore global statusline after loading session.
    -- Can't really explain why it happens.
    resession.add_hook("post_load", function() vim.cmd [[set laststatus=3]] end)
  end,
}
