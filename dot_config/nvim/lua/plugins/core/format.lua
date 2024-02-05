---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        htmldjango = { "djlint" },
        python = { "ruff_format" },
        sh = { "shfmt" },
        go = { "goimports", "gofmt" },
        kotlin = { "ktlint" },
        mardown = { "prettierd" },
        php = { "pint" },
        typescript = function(bufnr)
          local deno_root = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")

          if deno_root(vim.api.nvim_buf_get_name(bufnr)) then
            return { "deno_fmt" }
          else
            return { "prettierd" }
          end
        end,
      },
    },
  },
}
