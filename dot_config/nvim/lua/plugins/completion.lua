--@type LazySpec
return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "User AstroFile",
    opts = {
      disable_inline_completion = true,
      disable_keymaps = true,
    },
  },
  {
    "saghen/blink.compat",
    version = "*",
    lazy = true,
    opts = {},
  },
  {
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    ---@module 'blink.cmp'
    ---@param _ LazySpec
    ---@param opts blink.cmp.Config
    ---@return blink.cmp.Config
    opts = function(_, opts)
      opts.snippets = nil
      opts.completion.ghost_text = {
        enabled = true,
      }
      opts.sources = {
        default = {
          "supermaven",
          "lsp",
          "dadbod",
          "path",
          "snippets",
          "buffer",
        },
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
      }

      return opts
    end,
  },
}
