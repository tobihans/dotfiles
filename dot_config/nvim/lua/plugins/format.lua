local util = require "lspconfig.util"
local root_p = util.root_pattern

-- use async formatting when formatter is slow
local format_async = {}

local function biome_or_prettier(bufnr)
  local biome_root = root_p("biome.json", "biome.jsonc")(vim.api.nvim_buf_get_name(bufnr))

  if biome_root then
    -- Assuming formatting is always enabled
    return { "biome" }
  else
    return {
      "prettierd",
      "prettier",
      stop_after_first = true,
    }
  end
end

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
        astro = biome_or_prettier,
        css = biome_or_prettier,
        go = { "goimports", "gofmt" },
        graphql = biome_or_prettier,
        html = biome_or_prettier,
        htmldjango = { "djlint" },
        hurl = { "hurlfmt", "injected" },
        javascript = biome_or_prettier,
        javascriptreact = biome_or_prettier,
        json = biome_or_prettier,
        lua = { "stylua" },
        mardown = { "prettierd", "prettier", "injected" },
        php = { "pint", "php_cs_fixer" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        sh = { "shfmt" },
        sql = { "sleek" },
        svelte = biome_or_prettier,
        typescriptreact = biome_or_prettier,
        typescript = function(bufnr)
          local deno_root = root_p("deno.json", "deno.jsonc")(vim.api.nvim_buf_get_name(bufnr))

          if deno_root then
            return { "deno_fmt" }
          else
            return biome_or_prettier(bufnr)
          end
        end,
        typst = { "typstyle", "injected" },
        yaml = { "yamlfmt" },
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
