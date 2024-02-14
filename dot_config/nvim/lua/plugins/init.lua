---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      features = {
        large_buf = { size = 1024 * 100, lines = 10000 },
        autopairs = true,
        cmp = true,
        highlighturl = true,
        notifications = true,
      },
      mappings = require "config.mappings",
    },
  },
  { "nvimtools/none-ls.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  -- TODO: Remove the dev version once https://github.com/rcarriga/nvim-notify/pull/253 is merged
  -- or the issue is fixed
  { "rcarriga/nvim-notify", dev = true },
}
