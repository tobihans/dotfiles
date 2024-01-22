-- luacheck: globals vim
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        ["0"] = { function() vim.api.nvim_feedkeys("^", "n", false) end, desc = "First non-blank character" },

        ["<space>"] = { function() vim.api.nvim_feedkeys("/", "n", false) end },
        ["<C-space>"] = { function() vim.api.nvim_feedkeys("?", "n", false) end },

        ["<leader><cr>"] = { function() return ":noh<cr>" end, desc = "noh", silent = true, expr = true },
        ["<leader>m"] = {
          function() return "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm" end,
          desc = "Remove the ^M Windows line endings",
          silent = true,
          expr = true,
        },
        ["<leader>O"] = { name = "  Octo /  Overseer" },

        ["<M-s"] = {
          -- TODO: Use stdpath 'config'
          function()
            local config = vim.fn.stdpath("config")
            vim.cmd("edit " .. config .. "/init.lua")
          end,
          desc = "Open neovim settings",
        },
      },
      t = {
        ["<M-esc>"] = { "<C-\\><C-n>", desc = " Exit Terminal Mode" },
      },
    },
  },
}
