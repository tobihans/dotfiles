---@type LazySpec
return {
  "harrisoncramer/gitlab.nvim",
  build = function() require("gitlab.server").build(true) end,
  enabled = false,
  opts = {
    auth_provider = function() return require("utilities").secret "GLAB_TOKEN", nil, nil end,
  },
  config = function() require("gitlab").setup() end,
}
