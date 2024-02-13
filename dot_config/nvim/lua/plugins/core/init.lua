---@type LazySpec
return {
  { "nvimtools/none-ls.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  -- TODO: Remove the dev version once https://github.com/rcarriga/nvim-notify/pull/253 is merged
  -- or the issue is fixed
  { "rcarriga/nvim-notify", dev = true },
}
