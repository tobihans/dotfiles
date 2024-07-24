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
        require("which-key").add {
          { "<Localleader>h", name = "󰯊 Hurl Tools" },
          { "<Localleader>hA", "<cmd>HurlRunner<CR>", desc = "Run All requests" },
          { "<Localleader>ha", "<cmd>HurlRunnerAt<CR>", desc = "Run Api request" },
          { "<Localleader>he", "<cmd>HurlRunnerToEntry<CR>", desc = "Run Api request to entry" },
          { "<Localleader>hm", "<cmd>HurlToggleMode<CR>", desc = "Hurl Toggle Mode" },
          { "<Localleader>hv", "<cmd>HurlVerbose<CR>", desc = "Run Api in verbose mode" },
          { "<Localleader>h", ":HurlRunner<CR>", desc = "Hurl Runner", mode = "v" },
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
      ".vars",
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
