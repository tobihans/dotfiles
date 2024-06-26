local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

--@type LazySpec
return {
  {
    "supermaven-inc/supermaven-nvim",
    opts = {
      disable_inline_completion = true,
      disable_keymaps = true,
    },
    event = "User AstroFile",
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
      vim.cmd [[SupermavenUseFree]]
      require("cmp").setup.global {
        sources = {
          { name = "supermaven", priority = 1200, group_index = 1 },
        },
      }
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    event = "User AstroFile",
    dependencies = {
      {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        opts = { panel = { enabled = false }, suggestion = { enabled = false } },
      },
    },
    config = function(_, opts)
      require("copilot_cmp").setup(opts)
      require("cmp").setup.global {
        sources = {
          { name = "copilot", priority = 1000, group_index = 1 },
        },
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { { "zbirenbaum/copilot-cmp" } },
    opts = function(_, opts)
      local cmp, luasnip = require "cmp", require "luasnip"

      if not opts.mappings then opts.mappings = {} end

      opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" })

      opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" })

      return opts
    end,
  },
}
