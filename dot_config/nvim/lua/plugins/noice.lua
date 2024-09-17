---@type LazySpec
return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      messages = {
        enabled = true, -- enables the Noice messages UI
        view = "mini", -- default view for messages
        view_error = "mini", -- view for errors
        view_warn = "mini", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      lsp = {
        progress = {
          enabled = true,
        },
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        command_palette = true, -- position the cmdline and popupmenu together
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      views = {
        hover = {
          silent = true,
          scrollbar = not vim.g.neovide,
        },
      },
      ---@type NoiceRouteConfig[]
      routes = {
        ---@diagnostic disable-next-line: missing-fields
        {
          filter = {
            any = {
              { find = "No information available" },
              { find = "No code actions available" },
              { find = "No LSP client found that supports symbols" },
              { event = "msg_show", find = "written" },
              { event = "msg_show", find = "search hit" },
            },
          },
          opts = { skip = true },
        },
      },
    },
    init = function() vim.g.lsp_handlers_enabled = false end,
  },
}
