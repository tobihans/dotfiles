---@type LazySpec
return {
  "stevearc/resession.nvim",
  opts = function(_, opts)
    if not opts.extensions then opts.extensions = {} end

    -- opts.extensions.overseer = { unique = true }
    opts.extensions.dap = {}
    opts.extensions.quickfix = {}
    opts.extensions.scope = {}
    opts.extensions.aerial = {}

    return opts
  end,
  config = function(_, opts)
    local resession = require "resession"

    resession.setup(opts)
    resession.add_hook("post_load", function() vim.schedule(require("utilities").load_exrc) end)
  end,
}
