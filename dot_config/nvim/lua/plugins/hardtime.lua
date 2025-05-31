---@type LazySpec
return {
  {
    "m4xshen/hardtime.nvim",
    enabled = true,
    event = "User AstroFile",
    opts = {
      disable_mouse = false,
      force_exit_insert_mode = false,
      max_insert_idle_ms = 5 * 60 * 1000, -- 5 mins
      disabled_filetypes = {
        Avante = false,
        [""] = false,
        ["copilot-chat"] = false,
        ["crates.nvim"] = false,
        ["dap-repl"] = false,
        ["dapui*"] = false,
        ["grug-far*"] = false,
        ["neo-tree*"] = false,
        ["neotest*"] = false,
        ["overseer*"] = false,
        aerial = false,
        alpha = false,
        dbout = false,
        dbui = false,
        help = false,
        lazy = false,
        lspinfo = false,
        mason = false,
        netrw = false,
        noice = false,
        octo = false,
        qf = false,
        toggleterm = false,
        undotree = false,
      },
    },
  },
}
