---@type LazySpec
return {
  {
    "brenoprata10/nvim-highlight-colors",
    event = "User AstroFile",
    opts = {
      render = "virtual",
      virtual_symbol = "",
      virtual_symbol_prefix = " ",
      virtual_symbol_suffix = "",
      virtual_symbol_position = "eow",
      enable_named_colors = true,
      enable_tailwind = true,
    },
  },
  {
    "akinsho/flutter-tools.nvim",
    opts = {
      dev_log = {
        enabled = false,
        notify_errors = true,
        open_cmd = "40vnew",
      },
      widget_guides = {
        enabled = false,
      },
      debugger = {
        enabled = true,
        run_via_dap = false,
        exception_breakpoints = {},
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    dependencies = {
      "stevearc/overseer.nvim",
    },
    ---@type RustaceanOpts
    opts = {
      tools = {
        reload_workspace_from_cargo_toml = true,
        hover_actions = {
          replace_builtin_hover = false,
        },
        executor = {
          execute_command = function(cmd, args, cwd, _opts)
            local task = require("overseer").new_task { cmd = cmd, args = args, cwd = cwd }
            task:start()
          end,
        },
      },
    },
  },
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
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    init = function()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("PackageJsonKeymap", { clear = true }),
        desc = "Setup package-info.nvim keymaps into package.json buffers",
        pattern = "package.json",
        callback = function()
          local package_info = require "package-info"

          require("telescope").load_extension "package_info"
          require("which-key").add({
            { "<Localleader>p", group = "󰏗 Package.json tools" },
            { "<Localleader>pt", function() package_info.toggle { force = true } end, desc = "Toggle" },
            { "<Localleader>pd", package_info.delete, desc = "Delete package" },
            { "<Localleader>pi", package_info.install, desc = "Install a package" },
            { "<Localleader>pu", package_info.update, desc = "Update package" },
            { "<Localleader>pv", package_info.change_version, desc = "Change package version" },
          }, { silent = true, noremap = true })
        end,
      })
    end,
  },
}
