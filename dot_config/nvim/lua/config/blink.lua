local function has_words_before()
  local line, col = (unpack or table.unpack)(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
end

return {
  enabled = function() return vim.F.if_nil(vim.b.completion, vim.g.completion) end,
  completion = {
    ghost_text = { enabled = true },
    list = { selection = { preselect = false, auto_insert = true } },
    accept = {
      auto_brackets = { enabled = true },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      window = {
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      },
    },
  },
  sources = {
    default = { "supermaven", "lsp", "path", "snippets", "buffer", "dadbod" },
    providers = {
      dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      supermaven = {
        name = "supermaven",
        module = "blink.compat.source",
        transform_items = function(ctx, items)
          ---@diagnostic disable-next-line: inject-field
          ctx.kind_icon, ctx.kind_hl_group, _ = require("mini.icons").get("lsp", "supermaven")
          for _, item in ipairs(items) do
            item.kind_icon = ctx.kind_icon
            item.kind_name = "Supermaven"
          end
          return items
        end,
      },
    },
  },
  keymap = {
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<Up>"] = { "select_prev", "fallback" },
    ["<Down>"] = { "select_next", "fallback" },
    ["<C-N>"] = { "select_next", "show" },
    ["<C-P>"] = { "select_prev", "show" },
    ["<C-J>"] = { "select_next", "fallback" },
    ["<C-K>"] = { "select_prev", "fallback" },
    ["<C-U>"] = { "scroll_documentation_up", "fallback" },
    ["<C-D>"] = { "scroll_documentation_down", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },
    ["<Tab>"] = {
      "select_next",
      "snippet_forward",
      function(cmp)
        if has_words_before() or vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
      end,
      "fallback",
    },
    ["<S-Tab>"] = {
      "select_prev",
      "snippet_backward",
      function(cmp)
        if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
      end,
      "fallback",
    },
  },
  fuzzy = { implementation = "prefer_rust" },
  cmdline = {
    keymap = {
      ["<End>"] = { "hide", "fallback" },
    },
    completion = { ghost_text = { enabled = false } },
  },
  signature = {
    window = {
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
    },
  },
}
