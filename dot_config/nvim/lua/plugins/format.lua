-- use async formatting when formatter is slow
local format_async = {}

local function get_autoformat(bufnr)
  if vim.g.autoformat == nil then vim.g.autoformat = true end
  local autoformat = vim.b[bufnr].autoformat
  if autoformat == nil then autoformat = vim.g.autoformat end

  return autoformat
end

---@type LazySpec
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        hurlfmt = {
          meta = {
            url = "https://github.com/Orange-OpenSource/hurl",
            description = "Run HTTP requests defined in a simple plain text format.",
          },
          command = "hurlfmt",
          args = {},
        },
        injected = {
          options = {
            ignore_errors = true,
            lang_to_formatters = {},
          },
        },
      },
      formatters_by_ft = {
        css = { "prettier" },
        go = { "goimports", "gofmt" },
        graphql = { "prettier" },
        html = { "prettier" },
        htmldjango = { "djlint" },
        hurl = { "hurlfmt", "injected" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "jq" },
        lua = { "stylua" },
        mardown = { "prettier", "injected" },
        php = { "pint", "php_cs_fixer" },
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
        typst = { "typstfmt", "injected" },
        yaml = { "yq" },
      },
      format_on_save = function(bufnr)
        if format_async[vim.bo[bufnr].filetype] then return end
        local function on_format(err)
          if err and err:match "timeout$" then format_async[vim.bo[bufnr].filetype] = true end
        end

        if get_autoformat(bufnr) then return { timeout_ms = 500, lsp_fallback = true }, on_format end
      end,
      format_after_save = function(bufnr)
        if not format_async[vim.bo[bufnr].filetype] then return end

        if get_autoformat(bufnr) then return { lsp_fallback = true } end
      end,
    },
  },
}
