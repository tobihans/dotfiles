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
      { "<Leader>Oo", "<cmd>Octo<cr>", desc = " Octo pick" },
    },
    config = true,
    opts = {
      enable_builtin = true,
    },
  },
}
