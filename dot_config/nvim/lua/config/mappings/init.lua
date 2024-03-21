return {
  n = {
    ["0"] = { function() vim.api.nvim_feedkeys("^", "n", false) end, desc = "First non-blank character" },
    ["<space>"] = { function() vim.api.nvim_feedkeys("/", "n", false) end, desc = "Search forward" },
    ["<C-space>"] = { function() vim.api.nvim_feedkeys("?", "n", false) end, desc = "Search backward" },

    ["<Leader>O"] = { name = "  Octo /  Overseer" },
    ["<Leader>G"] = { name = "󱎓 Games" },
    ["<Leader>n"] = { require("utilities.pickers").new_file, desc = "New File" },
    ["<Leader><cr>"] = {
      function() vim.api.nvim_feedkeys(":noh" .. vim.api.nvim_replace_termcodes("<cr>", true, false, true), "n", false) end,
      desc = "noh",
    },
    ["<Leader>W"] = { "<cmd>wall<cr>", desc = "Save all" },
    ["<Leader>m"] = {
      function() return "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm" end,
      desc = "Remove the ^M Windows line endings",
      silent = true,
      expr = true,
    },

    ["<Localleader>l"] = { name = " Lists" },
    ["<Localleader>lq"] = { "<cmd>cwindow<cr>", desc = "Quickfix list" },
    ["<Localleader>ll"] = { "<cmd>lwindow<cr>", desc = "Location list" },

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
    ["<M-esc>"] = { "<C-\\><C-n>", desc = " Exit Terminal Mode" },
  },
}
