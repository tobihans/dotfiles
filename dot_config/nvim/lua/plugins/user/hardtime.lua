---@type LazySpec
return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disabled_filetypes = {
        "",
        "aerial",
        "alpha",
        "dap-repl",
        "dapui_breakpoints",
        "dapui_console",
        "dapui_scopes",
        "dapui_stacks",
        "dapui_watches",
        "dbout",
        "dbui",
        "help",
        "lazy",
        "lspinfo",
        "mason",
        "neo-tree",
        "neo-tree-popup",
        "netrw",
        "noice",
        "null-ls-info",
        "octo",
        "oil",
        "overseerlist",
        "qf",
        "toggleterm",
        "undotree",
      },
    },
    event = "BufEnter",
  },
}
