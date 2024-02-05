---@type LazySpec
return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        htmldjango = { "djlint" },
        sh = { "shellcheck" },
        markdown = { "markdownlint" },
        php = { "psalm" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = function() require("lint").try_lint() end,
      })
    end,
  },
}
