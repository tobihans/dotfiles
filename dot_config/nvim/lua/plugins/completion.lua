local icon_provider = function(ctx)
  local mini_icons = require "mini.icons"
  local source = --[[@type string]]
    ctx.item.source_name

  if source == "LSP" then
    ctx.kind_icon, ctx.kind_hl_group, _ = mini_icons.get("lsp", ctx.kind or source:lower())
  elseif source == "supermaven" then
    ctx.kind_icon, ctx.kind_hl_group, _ = mini_icons.get("lsp", "supermaven")
  elseif source == "Path" then
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
    config = function(_, opts)
      require("blink-compat").setup(opts)

      -- INFO: This prevent an error from avante_mentions providers.
      -- TODO: Check if the error is fixed later.
      require("cmp").ConfirmBehavior = {
        Insert = "Insert",
      }
    end,
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
          "avante_commands",
          "avante_mentions",
          "avante_files",
          "supermaven",
          "lsp",
          "dadbod",
          "path",
          "snippets",
          "buffer",
        },
        providers = {
          avante_commands = { name = "avante_commands", module = "blink.compat.source", score_offset = 90 },
          avante_files = { name = "avante_files", module = "blink.compat.source", score_offset = 100 },
          avante_mentions = { name = "avante_mentions", module = "blink.compat.source", score_offset = 1000 },
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
          supermaven = { name = "supermaven", module = "blink.compat.source" },
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
