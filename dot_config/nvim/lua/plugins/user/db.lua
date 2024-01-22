-- luacheck: globals vim
---@type LazySpec
return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dotenv", lazy = true },
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 30
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_use_nvim_notify = 1
      vim.g.db_ui_win_position = "left"

      require("which-key").register {
        ["<leader>D"] = {
          name = "󰆼 Db Tools",
          u = { "<cmd>DBUIToggle<cr>", " DB UI Toggle" },
          f = { "<cmd>DBUIFindBuffer<cr>", " DB UI Find buffer" },
          r = { "<cmd>DBUIRenameBuffer<cr>", " DB UI Rename buffer" },
          l = { "<cmd>DBUILastQueryInfo<cr>", " DB UI Last query infos" },
        },
      }
    end,
  },
}
