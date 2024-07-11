local M = {
  n = {
    ["0"] = { "^", desc = "First non-blank character" },

    ["<Leader>O"] = { name = "  Octo /  Overseer" },
    ["<Leader>G"] = { name = "󱎓 Games" },
    ["<Leader>n"] = { require("utilities.pickers").new_file, desc = "New File" },
    ["<Leader>m"] = {
      function() return "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm" end,
      desc = "Remove the ^M Windows line endings",
      silent = true,
      expr = true,
    },
    ["<Leader>w"] = {
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

    ["<Localleader>r"] = { "<cmd>edit<cr>", desc = "Reload Buffer" },

    ["<M-s>"] = {
      function()
        local config = vim.fn.stdpath "config"
        vim.cmd.cd(config)
        vim.cmd.edit(config .. "/init.lua")
      end,
      desc = "Open neovim settings in a separate tab",
    },
  },
  t = {
    ["<M-Esc>"] = { "<C-\\><C-n>", desc = " Exit Terminal Mode" },
    ["<C-`>"] = { "<C-\\><C-n>", desc = " Exit Terminal Mode" },
  },
  c = {},
}

-- stylua: ignore
if vim.g.neovide then
  M["t"]["<C-S-V>"] = { "<C-\\><C-n>pi", desc = "Paste clipboard content" }
end

return M
