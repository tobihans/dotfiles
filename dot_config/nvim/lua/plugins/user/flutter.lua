---@type LazySpec
return {
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    opts = {
      debugger = {
        enabled = true,
        run_via_dap = true,
        exception_breakpoints = {},
        -- register_configurations = function(_)
        --   require("dap").configurations.dart = {}
        --   require("dap.ext.vscode").load_launchjs()
        -- end,
      },
      lsp = {
        on_attach = function(client, bufnr)
          require("astronvim.utils.lsp").on_attach(client, bufnr)

          require("which-key").register({
            ["<localleader>f"] = {
              name = " Flutter Tools",
              c = { function() require("telescope").extensions.flutter.commands() end, "Flutter Commands" },
              s = { function() require("telescope").extensions.flutter.fvm() end, "Flutter SDK (fvm)" },
            },
          }, { buffer = bufnr })
        end,
      },
      settings = {
        showTodos = false,
        completeFunctionCalls = true,
        -- analysisExcludedFolders = { "<path-to-flutter-sdk-packages>" },
        renameFilesWithClasses = "prompt", -- "always"
        enableSnippets = true,
        updateImportsOnRename = true,
      },
    },
    config = true,
  },
}
