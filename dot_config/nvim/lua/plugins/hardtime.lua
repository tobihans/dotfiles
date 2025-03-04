---@type LazySpec
return {
  {
    "m4xshen/hardtime.nvim",
    -- enabled = false,
    event = "User AstroFile",
    opts = {
      disable_mouse = false,
      force_exit_insert_mode = false,
      max_insert_idle_ms = 5 * 60 * 1000, -- 5 mins
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
        "grug-far",
        "grug-far-help",
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
  },
}
