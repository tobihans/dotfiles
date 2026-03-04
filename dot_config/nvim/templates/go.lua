--- TODO: Configure those mappings
local _mappings = {
  { "<Localleader>g", group = " Go Tools" },
  { "<Localleader>gf", "<cmd>GoIfErr<cr>", desc = " Generate if err" },
  { "<Localleader>gi", "<cmd>GoImpl<cr>", desc = " Implement interface" },

  { "<Localleader>gt", group = "󰗇 Tests" },
  { "<Localleader>gta", "<cmd>GoTestAdd<cr>", desc = " Generate test" },
  { "<Localleader>gte", "<cmd>GoTestsExp<cr>", desc = " Generate test for exported" },
  { "<Localleader>gtA", "<cmd>GoTestsAll<cr>", desc = " Generate test for all" },
}

---@type LazySpec
return {
  { import = "astrocommunity.pack.go" },
  {
    "stevearc/conform.nvim",
    opts = { formatters_by_ft = { go = { "goimports", "gofmt" } } },
  },
}
