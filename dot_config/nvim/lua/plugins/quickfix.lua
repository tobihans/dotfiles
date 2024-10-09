---@type LazySpec
return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    init = function()
      _G.qftf = require("utilities").quickfixtextfunc
      vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
    end,
    opts = {
      preview = {
        border = { "━", "━", "━", " ", "━", "━", "━", " " },
      },
      func_map = {
        fzffilter = "", -- TODO: Replace fzf filtering with a custom one.
      },
    },
  },
}
