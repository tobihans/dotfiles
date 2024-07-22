local wk = require "which-key"

local M = {
  n = {
    { "0", "^", desc = "First non-blank character" },

    { "<Leader>G", group = "󱎓 Games" },
    { "<Leader>O", group = "  Octo /  Overseer" },

    { "<Leader><Enter>", "<cmd>noh<cr>", desc = "No Highlight" },
    { "<Leader>n", require("utilities.pickers").new_file, desc = "New File" },
    {
      "<Leader>um",
      function()
        vim.o.mouse = vim.o.mouse ~= "" and "" or "a"
        vim.notify("Mouse: " .. (vim.o.mouse ~= "" and vim.o.mouse or "off"))
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
      "<M-s>",
      function()
        local config = vim.fn.stdpath "config"
        vim.cmd.cd(config)
        vim.cmd.edit(config .. "/init.lua")
      end,
      desc = "Open ~/.config/nvim",
    },
  },
  t = {
    { "<C-`>", "<C-\\><C-n>", desc = " Exit Terminal Mode" },
  },
}

-- stylua: ignore
if vim.g.neovide then
  table.insert(M["t"], {
    "<C-S-V>", "<C-\\><C-n>pi",
    desc = "Paste clipboard content",
  })
end

for mode, mappings in pairs(M) do
  wk.add {
    { mode = mode, unpack(mappings) },
  }
end
