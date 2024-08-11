---@type LazySpec
return {
  "goolord/alpha-nvim",
  opts = function(_, dashboard)
    local get_icon = require("astroui").get_icon

    dashboard.section.header.val = {
      os.date " %A, %d %B %Y  %I:%M:%S %p",
    }

    dashboard.section.buttons.val = {
      dashboard.button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
      dashboard.button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
      dashboard.button("LDR f '", get_icon("Bookmarks", 2, true) .. "Bookmarks  "),
      dashboard.button("LDR S F", get_icon("Project", 2, true) .. "Restore Session  "),
      dashboard.button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  "),
      dashboard.button("LDR Q  ", get_icon("CloseNeovim", 2, true) .. "Close Neovim  "),
    }

    dashboard.config.layout = {
      { type = "padding", val = vim.fn.max { 2, vim.fn.floor(vim.fn.winheight(0) * 0.34) } },
      dashboard.section.header,
      { type = "padding", val = 1 },
      dashboard.section.buttons,
      dashboard.section.footer,
    }

    return dashboard
  end,
  config = function(_, opts)
    require("alpha").setup(opts.config)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      desc = "Add Alpha dashboard footer",
      once = true,
      callback = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime * 100 + 0.5) / 100
        opts.section.footer.val = {
          " " .. stats.loaded .. "/" .. stats.count .. " " .. ms .. "ms",
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
