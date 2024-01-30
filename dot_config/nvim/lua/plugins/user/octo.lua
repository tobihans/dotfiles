---@type LazySpec
return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    init = function()
      require("which-key").register {
        ["<Leader>Oo"] = { "<cmd>Octo<cr>", " Pick" },
        ["<Leader>Oa"] = { "<cmd>Octo actions<cr>", " Actions" },
      }
    end,
    config = true,
    opts = {
      enable_builtin = true,
    },
  },
}
