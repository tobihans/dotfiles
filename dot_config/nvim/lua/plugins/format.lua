-- use async formatting when formatter is slow
local format_async = {}
local prettier_and_co = {
  "biome",
  "prettierd",
  "prettier",
  stop_after_first = true,
}

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
        typstyle = {
          meta = {
            url = "https://github.com/Enter-tainer/typstyle/",
            description = "Beautiful and reliable typst code formatter.",
          },
          command = "typstyle",
          args = { "-c", "120" },
        },
      },
      formatters_by_ft = {
        astro = prettier_and_co,
        css = prettier_and_co,
        go = { "goimports", "gofmt" },
        graphql = prettier_and_co,
        html = prettier_and_co,
        htmldjango = { "djlint" },
        hurl = { "hurlfmt", "injected" },
        javascript = prettier_and_co,
        javascriptreact = prettier_and_co,
        json = { "jq" },
        lua = { "stylua" },
        mardown = { "prettierd", "prettier", "injected" },
        php = { "pint", "php_cs_fixer" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        sql = { "sleek" },
        svelte = prettier_and_co,
        typescriptreact = prettier_and_co,
        typescript = function(bufnr)
          local deno_root = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
          if deno_root(vim.api.nvim_buf_get_name(bufnr)) then
            return { "deno_fmt" }
          else
            return prettier_and_co
          end
        end,
        typst = { "typstyle", "injected" },
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
