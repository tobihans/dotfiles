---@type LazySpec
return {
  "stevearc/resession.nvim",
  opts = function(_, opts)
    opts.extensions.quickfix = {}
    opts.extensions.scope = {}
    opts.extensions.aerial = {}
    -- opts.extensions.overseer = {
    --   unique = true,
    --   recent_first = true,
    --   status = { "RUNNING" },
    -- }

    return opts
  end,
  config = function(_, opts)
    local resession = require "resession"

    resession.setup(opts)
    resession.add_hook("post_load", function() vim.schedule(require("utilities").load_exrc) end)
  end,
}
