---@type LazySpec
return {
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    version = nil,
    init = function()
      local wk = require "which-key"

      wk.add {
        { "M-h", desc = "Move line right" },
        { "M-j", desc = "Move line down" },
        { "M-k", desc = "Move line up" },
        { "M-l", desc = "Move line left" },
      }

      wk.add({
        { "M-h", desc = "Move selection right" },
        { "M-j", desc = "Move selection down" },
        { "M-k", desc = "Move selection up" },
        { "M-l", desc = "Move selection left" },
      }, { mode = { "v" } })
    end,
    config = true,
  },
}

