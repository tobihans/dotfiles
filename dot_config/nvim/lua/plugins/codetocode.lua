---@type LazySpec
return {
  {
    --- This is fun from time to time, you know. But most of the time, I prefer real world problems.
    "kawre/leetcode.nvim",
    build = ":TSUpdate html",
    cmd = "Leet",
    opts = {
      lang = "python3",
    },
  },
}
