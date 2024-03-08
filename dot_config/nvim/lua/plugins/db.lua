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
    event = "VeryLazy",
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_winwidth = 30
      vim.g.db_ui_show_help = 0
      vim.g.db_ui_use_nvim_notify = 1
      vim.g.db_ui_win_position = "left"

      require("which-key").register {
        ["<Leader>D"] = {
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
