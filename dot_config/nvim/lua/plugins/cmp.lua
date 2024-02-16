local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

--@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    disabled = not vim.g.copilot_enabled,
    cmd = "Copilot",
    event = "User AstroFile",
    opts = { panel = { enabled = false }, suggestion = { auto_trigger = true, debounce = 150 } },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "zbirenbaum/copilot.lua", { "hrsh7th/cmp-cmdline", enabled = false } },
    opts = function(_, opts)
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local copilot = require "copilot.suggestion"

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

      if vim.g.copilot_enabled then
        opts.mapping["<C-c>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.accept() end
        end)

        opts.mapping["<C-x>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.next() end
        end)

        opts.mapping["<C-z>"] = cmp.mapping(function()
          if copilot.is_visible() then copilot.prev() end
        end)
      end

      return opts
    end,
    config = function(_, opts)
      local cmp = require "cmp"
      cmp.setup(opts)

      -- NOTE: Disabling for now as it breaks noice tab completion in cmdline mode

      ---@diagnostic disable-next-line: missing-fields
      -- cmp.setup.cmdline("/", {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = {
      --     { name = "buffer" },
      --   },
      -- })

      -- cmp.setup.cmdline(":", {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = "path" },
      --   }, {
      --     {
      --       name = "cmdline",
      --       option = {
      --         ignore_cmds = { "Man", "!" },
      --       },
      --     },
      --   }),
      -- })
    end,
  },
}
