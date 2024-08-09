---@type LazySpec
return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- mini.move
    require("mini.move").setup()
  end,
}
