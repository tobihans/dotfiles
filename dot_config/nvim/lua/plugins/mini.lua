---@type LazySpec
return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- mini.basic
    require("mini.basics").setup {
      options = false,
      mappings = {
        option_toggle_prefix = "",
      },
    }
    -- mini.move
    require("mini.move").setup()
    -- mini.surround
    require("mini.surround").setup {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
        find = "fs",
        find_left = "fS",
        highlight = "hs",
        update_n_lines = "ns",
      },
    }
    -- mini.pairs
    require("mini.pairs").setup {
      modes = { insert = true, command = true },
    }
    -- mini.cursorword
    require("mini.cursorword").setup {}
  end,
}
