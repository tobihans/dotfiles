---@type LazySpec
return {
  {
    "tobihans/instant.nvim",
    dev = true,
    cmd = {
      "InstantStartSingle",
      "InstantJoinSingle",
      "InstantStartSession",
      "InstantJoinSession",
      "InstantStop",
    },
    init = function() vim.g.instant_username = "tobihans" end,
  },
}
