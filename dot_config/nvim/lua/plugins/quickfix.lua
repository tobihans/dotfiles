---@type LazySpec
return {
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    init = function()
      _G.qftf = require("utilities").quickfixtextfunc
      vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

      vim.api.nvim_create_autocmd("Filetype", {
        group = vim.api.nvim_create_augroup("QuickfixUtils", { clear = true }),
        pattern = "qf",
        callback = function(event)
          vim.keymap.set(
            "n",
            "zf",
            "<cmd>silent close | Telescope quickfix<cr>",
            { desc = "Filter quickfix", silent = true, buffer = event.buf }
          )
        end,
      })
    end,
    opts = {
      preview = {
        border = { "━", "━", "━", " ", "━", "━", "━", " " },
      },
      func_map = {
        fzffilter = "",
      },
    },
  },
}
