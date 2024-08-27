---@type LazySpec
return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dotenv" },
      { "tpope/vim-dadbod" },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
        init = function()
          vim.api.nvim_create_autocmd("FileType", {
            desc = "dadbod completion",
            group = vim.api.nvim_create_augroup("dadbod_cmp", { clear = true }),
            pattern = { "sql", "mysql", "plsql" },
            callback = function() require("cmp").setup.buffer { sources = { { name = "vim-dadbod-completion" } } } end,
          })
          vim.api.nvim_create_autocmd("FileType", {
            desc = "dadbod output",
            group = vim.api.nvim_create_augroup("dadbod_output", { clear = true }),
            pattern = { "dbout" },
            command = [[setl nonumber norelativenumber]],
          })
        end,
      },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    keys = {
      { "<Leader>D", "<cmd>DBUIToggle<cr>", desc = "󰆼 Database Explorer" },
    },
    init = function()
      vim.g.db_ui_winwidth = 34
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_use_nvim_notify = 0
      vim.g.db_ui_win_position = "right"
      vim.g.db_ui_notification_width = 34
      vim.g.db_ui_force_echo_notifications = 1
    end,
  },
}
