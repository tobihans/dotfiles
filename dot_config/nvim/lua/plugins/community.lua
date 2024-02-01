---@type LazySpec
local wk = {
  "Saecki/crates.nvim",
  init = function() end,
  opts = function(_, opts)
    opts.popup = {
      autofocus = true,
      hide_on_select = true,
      border = "rounded",
    }

    -- Setup some keybindings
    vim.api.nvim_create_autocmd("BufRead", {
      group = vim.api.nvim_create_augroup("CargoKeymap", { clear = true }),
      desc = "Setup crates.nvim keymaps into Cargo buffers",
      pattern = "Cargo.toml",
      callback = function()
        local crates = require "crates"
        local wk = require "which-key"
        wk.register({
          ["<Localleader>c"] = {
            name = " Cargo tools",
            t = { crates.toggle, "Toggle" },
            r = { crates.reload, "Reload" },
            p = { crates.show_popup, "Show popup" },
            v = { crates.show_versions_popup, "Show versions popup" },
            f = { crates.show_features_popup, "Show features popup" },
            d = { crates.show_dependencies_popup, "Show dependencies popup" },
            u = { crates.update_crate, "Update crate" },
            a = { crates.update_all_crates, "Update all crates" },
            U = { crates.upgrade_crate, "Upgrade crate" },
            A = { crates.upgrade_all_crates, "Upgrade all crates" },
            x = { crates.expand_plain_crate_to_inline_table, "Expand plain crate to inline table" },
            X = { crates.extract_crate_into_table, "Extract crate into table" },
            H = { crates.open_homepage, "Open homepage" },
            R = { crates.open_repository, "Open repository" },
            D = { crates.open_documentation, "Open documentation" },
            C = { crates.open_crates_io, "Open crates.io" },
          },
        }, { silent = true })

        wk.register({
          ["<Localleader>c"] = {
            name = " Cargo tools",
            u = { crates.update_crates, "Update crates" },
            U = { crates.upgrade_crates, "Upgrade crates" },
          },
        }, { mode = "v", silent = true })
      end,
    })

    return opts
  end,
}
return {
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      debugger = {
        enabled = true,
        run_via_dap = true,
        exception_breakpoints = {},
      },
    },
  },
  wk,
}
