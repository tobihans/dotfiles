-- luacheck: globals vim
---@type LazySpec
return {
  {
    "akinsho/toggleterm.nvim",
    init = function()
      require("which-key").register {
        ["<leader>t"] = {
          h = {
            function() vim.cmd(vim.v.count .. "ToggleTerm size=10 direction=horizontal") end,
            "ToggleTerm horizontal split",
          },
          v = {
            function() vim.cmd(vim.v.count .. "ToggleTerm size=80 direction=vertical") end,
            "ToggleTerm vertical split",
          },
          d = {
            function() require("astrocore").toggle_term_cmd "lazydocker" end,
            "ToggleTerm lazydocker",
          },
          b = {
            function() require("astrocore").toggle_term_cmd "btop" end,
            "ToggleTerm btop",
          },
        },
      }
    end,
  },
}
