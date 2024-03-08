---@type LazySpec
return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        go = { "golangcilint" },
        htmldjango = { "djlint" },
        lua = { "selene" },
        markdown = { "markdownlint" },
        php = { "psalm", "tlint" },
        proto = { "protolint", "buf_lint" },
        sh = { "shellcheck" },
        sql = { "sqlfluff" },
        yaml = { "yamllint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
}
