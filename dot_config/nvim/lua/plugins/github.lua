---@type LazySpec
return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    keys = {
      { "<Leader>Oo", "<cmd>Octo<cr>", desc = " Octo pick" },
    },
    config = true,
    opts = {
      picker = "snacks",
      enable_builtin = true,
      left_bubble_delimiter = "",
      right_bubble_delimiter = "",
    },
  },
}
