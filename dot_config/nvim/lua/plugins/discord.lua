---@type LazySpec
return {
  "vyfor/cord.nvim",
  enabled = vim.fn.has "win32" == 0,
  build = "./build",
  cmd = {
    "CordConnect",
    "CordReconnect",
    "CordDisconnect",
    "CordTogglePresence",
    "CordShowPresence",
    "CordHidePresence",
    "CordToggleIdle",
    "CordIdle",
    "CordUnidle",
  },
  opts = {
    editor = {
      client = "astronvim",
      tooltip = "An aesthetically pleasing and feature-rich Neovim configuration",
    },
    display = {
      show_repository = false,
      workspace_blacklist = {},
    },
    text = {
      workspace = "",
    },
    buttons = {
      { label = "View AstroNvim", url = "https://astronvim.com" },
      { label = "View my GitHub profile", url = "https://github.com/tobihans" },
    },
  },
}
