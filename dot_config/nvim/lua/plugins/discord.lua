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
      client = "Neovide",
      tooltip = "I use Neovim BTW :), powered by AstroNvim.",
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
      { label = "View my LinkedIn profile", url = "https://www.linkedin.com/in/tobihans/" },
    },
  },
}
