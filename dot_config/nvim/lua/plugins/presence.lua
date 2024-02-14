---@type LazySpec
return {
  "andweeb/presence.nvim",
  lazy = false,
  enabled = false,
  opts = {
    buttons = false,
    blacklist = {
      "pitch-cardinal-coding",
      "private",
      "winlife-hq",
    },
  },
  config = true,
}
