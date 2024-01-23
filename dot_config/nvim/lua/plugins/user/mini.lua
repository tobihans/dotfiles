---@type LazySpec
return {
  {
    "echasnovski/mini.move",
    lazy = false,
    version = nil,
    init = function()
      local wk = require "which-key"

      wk.register {
        ["M-j"] = { desc = "Move line down" },
        ["M-k"] = { desc = "Move line up" },
        ["M-l"] = { desc = "Move line left" },
        ["M-h"] = { desc = "Move line right" },
      }

      wk.register({
        ["M-j"] = { desc = "Move selection down" },
        ["M-k"] = { desc = "Move selection up" },
        ["M-l"] = { desc = "Move selection left" },
        ["M-h"] = { desc = "Move selection right" },
      }, { mode = "v" })
    end,
    config = true,
  },
}
