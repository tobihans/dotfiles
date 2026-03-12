---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = {
    gh = {},
    picker = {
      sources = {
        gh_issue = {},
        gh_pr = {},
      },
    },
  },
  keys = {
    { "<Leader>gI", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<Leader>gP", function() Snacks.picker.gh_pr() end,    desc = "GitHub Pull Requests (open)" },
  },
}
