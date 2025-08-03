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
            desc = "dadbod output",
            group = vim.api.nvim_create_augroup("dadbod_output", { clear = true }),
            pattern = { "dbout" },
            callback = function(event)
              vim.cmd [[setl nonumber norelativenumber]]
              vim.keymap.set("n", "q", "<Cmd>q<CR>", { desc = "Close output", silent = true, buffer = event.buf })
            end,
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
