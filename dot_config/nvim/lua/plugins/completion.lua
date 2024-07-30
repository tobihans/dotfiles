local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

--@type LazySpec
return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "User AstroFile",
    opts = {
      disable_inline_completion = true,
      disable_keymaps = true,
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
      -- vim.cmd [[SupermavenUseFree]]
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
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { { "zbirenbaum/copilot-cmp" } },
    opts = function(_, opts)
      local cmp, luasnip = require "cmp", require "luasnip"

      if not opts.mappings then opts.mappings = {} end
      if not opts.sources then opts.sources = {} end

      table.insert(opts.sources, { name = "copilot", priority = 1000, group_index = 1 })
      table.insert(opts.sources, { name = "supermaven", priority = 1000, group_index = 1 })

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
