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
    fn = function() Snacks.terminal.toggle "gh run watch --exit-status" end,
  },
  {
    icon = "󰡱",
    desc = "Gitlab CI View",
    fn = function() Snacks.terminal.toggle "glab pipeline ci view" end,
  },
}
