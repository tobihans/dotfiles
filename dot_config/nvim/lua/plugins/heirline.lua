---@type LazySpec
return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    local components = require "utilities.components"

    opts.winbar = nil

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode {
        mode_text = {
          icon = { kind = vim.uv.os_uname().sysname, padding = { right = 1, left = 1 } },
          padding = { right = 1 },
        },
      },
      status.component.git_branch {
        git_branch = { padding = { left = 1 } },
        surround = { separator = "none" },
      },
      status.component.file_info(),
      status.component.git_diff(),
      status.component.diagnostics(),
      components.ai,
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp { lsp_progress = false },
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav { percentage = false, scrollbar = false },
      components.clock,
    }
    components.start_clock_timer()

    opts.statuscolumn = {
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      status.component.signcolumn(),
      status.component.numbercolumn(),
      status.component.foldcolumn(),
    }

    return opts
  end,
}
