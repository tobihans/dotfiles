---@type LazySpec
return {
  {
    "mfussenegger/nvim-lint",
    event = "User AstroFile",
    config = function()
      local lint = require "lint"
      lint.linters_by_ft = {
        eruby = { "erb_lint" },
        ["eruby.yaml"] = { "yamllint" },
        go = { "golangcilint" },
        htmldjango = { "djlint" },
        lua = { "selene" },
        markdown = { "markdownlint" },
        php = { "tlint" },
        proto = { "protolint", "buf_lint" },
        sh = { "shellcheck" },
        sql = { "sqruff" },
        yaml = { "yamllint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
}
