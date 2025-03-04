--- NOTE: See https://github.com/AstroNvim/astrocommunity/blob/main/lua/astrocommunity/completion/blink-cmp/init.lua

--- @type fun(ctx: blink.cmp.DrawItemContext)
local icon_provider = function(ctx)
  local mini_icons = require "mini.icons"
  local is_specific_color = ctx.kind_hl and ctx.kind_hl:match "^HexColor" ~= nil

  if ctx.item.source_name == "LSP" then
    local icon, hl = mini_icons.get("lsp", ctx.kind or "")
    if icon then
      ctx.kind_icon = icon
      if not is_specific_color then ctx.kind_hl = hl end
    end
  elseif ctx.item.source_name == "supermaven" then
    ---@diagnostic disable-next-line: inject-field
    ctx.kind_icon, ctx.kind_hl_group, _ = mini_icons.get("lsp", "supermaven")
  elseif ctx.item.source_name == "Path" then
    ctx.kind_icon, ctx.kind_hl = mini_icons.get(ctx.kind == "Folder" and "directory" or "file", ctx.label)
  end
end

--- @type fun(ctx: blink.cmp.DrawItemContext)
local hl_provider = function(_ctx) end

local function get_kind_icon(CTX)
  -- Call resolved providers
  icon_provider(CTX)
  hl_provider(CTX)

  -- Return text and highlight information
  return { text = CTX.kind_icon .. CTX.icon_gap, highlight = CTX.kind_hl }
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
        text = function(ctx) return get_kind_icon(ctx).text end,
        highlight = function(ctx) return get_kind_icon(ctx).highlight end,
      }

      return opts
    end,
  },
}
