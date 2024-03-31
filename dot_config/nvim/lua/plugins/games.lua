---@type LazySpec
return {
  {
    "NStefan002/2048.nvim",
    cmd = "Play2048",
    init = function()
      require("which-key").register {
        ["<Leader>G2"] = { "<cmd>Play2048<cr>", "2048" },
      }
    end,
    config = true,
  },
}
