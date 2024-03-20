---@type LazySpec
return {
  "jellydn/hurl.nvim",
  ft = "hurl",
  dependencies = { "MunifTanjim/nui.nvim" },
  init = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "hurl" },
      group = vim.api.nvim_create_augroup("hurl_nvim", { clear = true }),
      callback = function()
        require("which-key").register {
          ["<Localleader>h"] = {
            name = "󰯊 Hurl Tools",
            A = { "<cmd>HurlRunner<CR>", "Run All requests" },
            a = { "<cmd>HurlRunnerAt<CR>", "Run Api request" },
            e = { "<cmd>HurlRunnerToEntry<CR>", "Run Api request to entry" },
            m = { "<cmd>HurlToggleMode<CR>", "Hurl Toggle Mode" },
            v = { "<cmd>HurlVerbose<CR>", "Run Api in verbose mode" },
          },
        }
      end,
    })
  end,
  opts = {
    debug = false,
    show_notification = false,
    mode = "popup",
    env_file = {
      ".env.hurl",
      ".env.http",
    },
    formatters = {
      json = { "jq" },
      html = {
        "prettier",
        "--parser",
        "html",
      },
    },
  },
}
