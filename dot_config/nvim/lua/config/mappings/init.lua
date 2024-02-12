-- luacheck: globals vim

return {
  n = {
    ["0"] = { function() vim.api.nvim_feedkeys("^", "n", false) end, desc = "First non-blank character" },

    ["<space>"] = { function() vim.api.nvim_feedkeys("/", "n", false) end },
    ["<C-space>"] = { function() vim.api.nvim_feedkeys("?", "n", false) end },

    ["<Leader>O"] = { name = "  Octo /  Overseer" },
    ["<Leader><cr>"] = {
      function() vim.api.nvim_feedkeys(":noh" .. vim.api.nvim_replace_termcodes("<cr>", true, false, true), "n", false) end,
      desc = "noh",
    },
    ["<Leader>r"] = { function() vim.cmd [[edit %]] end, desc = "󰑓 Reload current buffer" },
    ["<Leader>m"] = {
      function() return "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm" end,
      desc = "Remove the ^M Windows line endings",
      silent = true,
      expr = true,
    },

    ["<Localleader>l"] = { name = " Lists" },
    ["<Localleader>lq"] = { "<cmd>cwindow<cr>", desc = "Quickfix list" },
    ["<Localleader>ll"] = { "<cmd>cwindow<cr>", desc = "Location list" },

    ["<M-s>"] = {
      function()
        local config = vim.fn.stdpath "config"
        vim.cmd.edit(config .. "/init.lua")
        vim.cmd.cd(config)
      end,
      desc = "Open neovim settings",
    },
  },
  t = {
    ["<M-esc>"] = { "<C-\\><C-n>", desc = " Exit Terminal Mode" },
  },
}
