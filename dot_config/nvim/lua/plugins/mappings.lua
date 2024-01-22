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
          -- TODO: Consider honoring NVIM_APPNAME
          function()
            if vim.fn.has "unix" then
              vim.cmd "edit ~/.config/nvim/init.lua"
              vim.cmd "cd ~/.config/nvim/"
            else
              vim.fn.has "win32"
              vim.cmd "edit ~\\AppData\\Local\\nvim\\init.lua"
              vim.cmd "cd ~\\AppData\\Local\\nvim"
            end
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
