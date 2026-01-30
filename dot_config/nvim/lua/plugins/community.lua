---@type LazySpec
return {
  -- Rust
  { "mrcjkb/rustaceanvim", lazy = false },
  {
    "Saecki/crates.nvim",
    opts = function(_, opts)
      opts.popup = {
        autofocus = true,
        hide_on_select = true,
        border = "rounded",
      }

      opts.null_ls = {
        enabled = false,
      }

      opts.lsp = {
        enabled = true,
        on_attach = function(_client, _buf)
          local crates = require "crates"
          local wk = require "which-key"
          wk.add {
            {
              silent = true,
              { "<Localleader>c", group = " Cargo tools" },
              { "<Localleader>ct", crates.toggle, desc = "Toggle" },
              { "<Localleader>cr", crates.reload, desc = "Reload" },
              { "<Localleader>cp", crates.show_popup, desc = "Show popup" },
              { "<Localleader>cv", crates.show_versions_popup, desc = "Show versions popup" },
              { "<Localleader>cf", crates.show_features_popup, desc = "Show features popup" },
              { "<Localleader>cd", crates.show_dependencies_popup, desc = "Show dependencies popup" },
              { "<Localleader>cu", crates.update_crate, desc = "Update crate" },
              { "<Localleader>ca", crates.update_all_crates, desc = "Update all crates" },
              { "<Localleader>cU", crates.upgrade_crate, desc = "Upgrade crate" },
              { "<Localleader>cA", crates.upgrade_all_crates, desc = "Upgrade all crates" },
              { "<Localleader>cX", crates.extract_crate_into_table, desc = "Extract crate into table" },
              { "<Localleader>cH", crates.open_homepage, desc = "Open homepage" },
              { "<Localleader>cR", crates.open_repository, desc = "Open repository" },
              { "<Localleader>cD", crates.open_documentation, desc = "Open documentation" },
              { "<Localleader>cC", crates.open_crates_io, desc = "Open crates.io" },
              {
                "<Localleader>cx",
                crates.expand_plain_crate_to_inline_table,
                desc = "Expand plain crate to inline table",
              },
            },
          }

          wk.add {
            {
              mode = "v",
              silent = true,
              { "<Localleader>c", group = " Cargo tools" },
              { "<Localleader>cu", crates.update_crates, desc = "Update crates" },
              { "<Localleader>cU", crates.upgrade_crates, desc = "Upgrade crates" },
            },
          }
        end,
      }

      return opts
    end,
  },
}
