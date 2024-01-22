---@type LazySpec
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^3", -- Recommended
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        tools = {},
        server = {
          on_attach = function(client, bufnr)
            require("astronvim.utils.lsp").on_attach(client, bufnr)

            require("which-key").register({
              ["<localleader>r"] = {
                name = "󱘗 Rust Tools",
                x = { function() vim.cmd.RustLsp "expandMacro" end, " Expand Macros Recursively" },
                m = { function() vim.cmd.RustLsp "rebuildProcMacros" end, " Rebuild proc macros" },
                j = { function() vim.cmd.RustLsp "joinLines" end, " Join Lines" },
                c = { function() vim.cmd.RustLsp "openCargo" end, " Open Cargo.toml" },
                g = { function() vim.cmd.RustLsp "crateGraph" end, " View Crate Graph" },
                r = { function() vim.cmd.RustLsp { "runnables", "last" } end, " Runnables" },
                d = { function() vim.cmd.RustLsp { "debuggables", "last" } end, " Debuggables" },
                l = { function() vim.cmd.RustLsp "explainError" end, " Explain Error" },
                p = { function() vim.cmd.RustLsp "parentModule" end, " Go to parent module" },
                t = { function() vim.cmd.RustLsp "syntaxTree" end, " View syntax tree" },
              },
            }, { buffer = bufnr })
          end,
          settings = {
            ["rust-analyzer"] = {},
          },
        },
        dap = {},
      }
    end,
  },
  {
    "Saecki/crates.nvim",
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          ---@diagnostic disable-next-line: missing-fields
          require("cmp").setup.buffer { sources = { { name = "crates", priority = 2000 } } }
          require "crates"
        end,
      })
    end,
    opts = {
      null_ls = {
        enabled = true,
        name = "crates",
      },
    },
  },
}
