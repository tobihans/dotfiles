---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        css = { "prettier" },
        go = { "goimports", "gofmt" },
        graphql = { "prettier" },
        html = { "prettier" },
        htmldjango = { "djlint" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        mardown = { "prettier" },
        markdown = { "prettier" },
        php = { "pint", "php-cs-fixer" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        sql = { "sqlfluff" },
        svelte = { "prettier" },
        typescriptreact = { "prettier" },
        typescript = function(bufnr)
          local deno_root = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
          if deno_root(vim.api.nvim_buf_get_name(bufnr)) then
            return { "deno_fmt" }
          else
            return { "prettier" }
          end
        end,
        -- typst = { "typstfmt" },
        yaml = { "prettier" },
      },
      format_on_save = function(bufnr)
        if vim.g.autoformat == nil then vim.g.autoformat = true end
        local autoformat = vim.b[bufnr].autoformat
        if autoformat == nil then autoformat = vim.g.autoformat end
        if autoformat then return { timeout_ms = 1000, lsp_fallback = true } end
      end,
    },
  },
}
