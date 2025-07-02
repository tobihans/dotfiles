return {
  { icon = "", desc = "Screen Key", fn = function() vim.cmd "Screenkey" end },
  {
    icon = "󰡱",
    desc = "Compare to Clipboard",
    fn = require("utilities").compare_to_clipboard,
  },
  {
    icon = "󰡱",
    desc = "Github Action Watch",
    fn = function()
      require("astrocore").toggle_term_cmd {
        cmd = "gh run watch --exit-status",
        auto_scroll = true,
        close_on_exit = false,
      }
    end,
  },
  {
    icon = "󰡱",
    desc = "Gitlab CI View",
    function()
      require("astrocore").toggle_term_cmd {
        cmd = "glab pipeline ci view",
        auto_scroll = false,
        close_on_exit = true,
      }
    end,
  },
}
