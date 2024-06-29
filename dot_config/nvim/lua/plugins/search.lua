---@type LazySpec
return {
  {
    "nvim-pack/nvim-spectre",
    build = "./build.sh",
    opts = {
      line_sep_start = "╭────────────────────────────────────────────────────────────",
      result_padding = "│  ",
      line_sep = "╰────────────────────────────────────────────────────────────",
      highlight = {
        ui = "Label",
      },
      mapping = {
        ["select_template"] = {
          map = "rp",
        },
        ["delete_line"] = {
          map = "d_",
        },
      },
      default = {
        replace = {
          cmd = "oxi",
        },
      },
    },
  },
}
