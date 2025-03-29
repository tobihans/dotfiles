local wk = require "which-key"

local M = {
  n = {
    { "0", "^", desc = "First non-blank character" },
    { "<M-Up>", "<Cmd>resize -2<CR>", desc = "Resize split up" },
    { "<M-Down>", "<Cmd>resize +2<CR>", desc = "Resize split down" },
    { "<M-Left>", "<Cmd>vertical resize -2<CR>", desc = "Resize split left" },
    { "<M-Right>", "<Cmd>vertical resize +2<CR>", desc = "Resize split right" },

    { "<Leader>a", group = "󱙺 AI Assistance" },
    { "<Leader>a", group = "󱙺 AI Assistance", mode = "v" },
    { "<Leader>G", group = "󱎓 Games" },
    { "<Leader>O", group = "  Octo /  Overseer" },
    { "<Leader>s", group = "󰛔 Search/Replace" },

    { "<Leader><Enter>", "<cmd>noh | NoiceDismiss<cr>", desc = "No Highlight" },
    { "<Leader>n", require("utilities.pickers").new_file, desc = "New File" },
    {
      "<Leader>um",
      function()
        vim.o.mouse = vim.o.mouse ~= "" and "" or "a"
        vim.notify("Mouse Mode: " .. (vim.o.mouse ~= "" and vim.o.mouse or "off"))
      end,
      desc = "Toggle mouse",
    },
    {
      "<Leader>m",
      function() return "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm" end,
      desc = "Remove the ^M Windows line endings",
      silent = true,
      expr = true,
    },
    {
      "<Leader>w",
      function()
        if vim.fn.getreg "%" == "" then
          vim.ui.input({ prompt = "Path: ", completion = "file" }, function(input)
            if input then vim.cmd.write { input, bang = true } end
          end)
        else
          vim.cmd.write()
        end
      end,
      desc = "Save",
    },

    { "<Localleader>R", "<cmd>edit<cr>", desc = "Reload Buffer" },

    {
      "<Leader>Sc",
      require("utilities").load_neovim_config,
      desc = "Open Config",
    },
  },
  t = {
    { "<C-`>", "<C-\\><C-n>", desc = " Exit Terminal Mode" },
  },
}

for mode, mappings in pairs(M) do
  wk.add {
    { mode = mode, unpack(mappings) },
  }
end
