---@type LazySpec
return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Octo",
    keys = {
      { "<Leader>Oo", "<cmd>Octo<cr>", desc = " Pick" },
      { "<Leader>Oa", "<cmd>Octo actions<cr>", desc = " Actions" },
    },
    config = true,
    opts = {
      enable_builtin = true,
    },
  },
}
