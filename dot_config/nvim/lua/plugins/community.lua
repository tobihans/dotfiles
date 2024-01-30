---@type LazySpec
return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      debugger = {
        enabled = true,
        run_via_dap = true,
        exception_breakpoints = {},
      },
    },
  },
}
