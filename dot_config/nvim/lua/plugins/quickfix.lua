---@type LazySpec
return {
  {
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    ft = "qf",
    init = function()
      _G.qftf = require("utilities").quickfixtextfunc
      vim.o.qftf = "{info -> v:lua._G.qftf(info)}"
    end,
    opts = {
      filter = {
        fzf = {
          extra_opts = { "--bind", "ctrl-o:toggle-all", "--delimiter", "║" },
        },
      },
    },
  },
}
