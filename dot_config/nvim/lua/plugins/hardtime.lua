---@type LazySpec
return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {
      disable_mouse = false,
      disabled_filetypes = {
        "",
        "Avante",
        "aerial",
        "alpha",
        "copilot-chat",
        "crates.nvim",
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
        "leetcode.nvim",
        "lspinfo",
        "mason",
        "neo-tree",
        "neo-tree-popup",
        "neotest-summary",
        "netrw",
        "noice",
        "null-ls-info",
        "octo",
        "oil",
        "overseerform",
        "overseerlist",
        "qf",
        "spectre_panel",
        "toggleterm",
        "undotree",
      },
    },
    event = "BufEnter",
  },
}
