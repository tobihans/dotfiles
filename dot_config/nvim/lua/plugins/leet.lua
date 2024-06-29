---@type LazySpec
return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html",
  opts = {
    lang = "python3",
    plugins = {
      non_standalone = false,
    },
    keys = {
      toggle = { "q" },
      confirm = { "<CR>" },
      reset_testcases = "r",
      use_testcase = "U",
      focus_testcases = "H",
      focus_result = "L",
    },
  },
}
