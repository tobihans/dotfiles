---@type LazySpec
return {
  "nvim-tree/nvim-web-devicons",
  opts = function()
    return {
      override = {
        astro = { icon = "", color = "#EF8547", name = "astro" },
      },
      override_by_filename = {
        justfile = { icon = "󱜧", color = "#8CB4FF", name = "Justfile" },
      },
    }
  end,
}
