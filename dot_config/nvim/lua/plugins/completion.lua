local icon_provider = function(ctx)
  local mini_icons = require "mini.icons"

  if ctx.item.source_name == "LSP" then
    ctx.kind_icon, ctx.kind_hl_group, _ = mini_icons.get("lsp", ctx.kind or "")
  elseif ctx.item.source_name == "supermaven" then
    ctx.kind_icon, ctx.kind_hl_group, _ = mini_icons.get("lsp", "supermaven")
  elseif ctx.item.source_name == "Path" then
    ctx.kind_icon, ctx.kind_hl_group = mini_icons.get(ctx.kind == "Folder" and "directory" or "file", ctx.label)
  end

  local tailwind_hl = require("blink.cmp.completion.windows.render.tailwind").get_hl(ctx)
  if tailwind_hl then ctx.kind_hl_group = tailwind_hl end
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
        default = { "supermaven", "lsp", "path", "snippets", "buffer", "dadbod" },
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          supermaven = {
            enabled = true,
            name = "supermaven",
            module = "blink.compat.source",
          },
        },
      }
      opts.completion.menu.draw.components.kind_icon = {
        text = function(ctx)
          icon_provider(ctx)
          return ctx.kind_icon .. ctx.icon_gap
        end,
        highlight = function(ctx)
          icon_provider(ctx)
          ---@diagnostic disable-next-line: undefined-field
          return ctx.kind_hl_group
        end,
      }

      return opts
    end,
  },
}
