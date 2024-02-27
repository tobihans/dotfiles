local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

--@type LazySpec
return {
  {
    "zbirenbaum/copilot.lua",
    disabled = not vim.g.copilot_enabled,
    cmd = "Copilot",
    event = "User AstroFile",
    opts = { panel = { enabled = false }, suggestion = { enabled = false } },
  },
  {
    "onsails/lspkind.nvim",
    opts = {
      symbol_map = {
        Copilot = "",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-cmdline", enabled = false },
      {
        "zbirenbaum/copilot-cmp",
        dependencies = { "zbirenbaum/copilot.lua" },
        config = function() require("copilot_cmp").setup() end,
      },
    },
    opts = function(_, opts)
      local cmp, luasnip = require "cmp", require "luasnip"

      if not opts.sources then opts.sources = {} end
      table.insert(opts.sources, { name = "copilot", priority = 1500, group_index = 1 })

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
    config = function(_, opts)
      local cmp = require "cmp"
      -- local cmp_autopairs = require "nvim-autopairs.completion.cmp"

      cmp.setup(opts)
      -- Add parentheses after selecting function or method item
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

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
