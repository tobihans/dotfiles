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
        ["send_to_qf"] = {
          map = "<LocalLeader>q",
        },
        ["replace_cmd"] = {
          map = "<Localleader>c",
        },
        ["show_option_menu"] = {
          map = "<Localleader>o",
        },
        ["run_current_replace"] = {
          map = "<Localleader>rc",
        },
        ["run_replace"] = {
          map = "<Localleader>R",
        },
        ["change_view_mode"] = {
          map = "<Localleader>v",
        },
        ["resume_last_search"] = {
          map = "<Localleader>l",
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
