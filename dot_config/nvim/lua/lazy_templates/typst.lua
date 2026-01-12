-- TODO: Configure mappings
local _typst = {
  { "<Localleader>t", group = "󰈦 Typst tools" },
  { "<Localleader>tw", "<cmd>TypstWatch<cr>", desc = " Watch and compile your document" },
  { "<Localleader>tc", "<cmd>Tocv<cr>", desc = " Table of contents" },
}

---@type LazySpec
return {
  { "kaarmu/typst.vim", ft = "typst", init = function() vim.g.typst_syntax_highlight = 0 end },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        typstyle = {
          command = "typstyle",
          args = { "-c", "120" },
        },
      },
      formatters_by_ft = {
        typst = { "typstyle", "injected" },
      },
    },
  },
}
