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
          require("which-key").register({
            ["<Localleader>p"] = {
              name = "󰏗 Package.json tools",
              t = { function() package_info.toggle { force = true } end, "Toggle" },
              d = { package_info.delete, "Delete package" },
              i = { package_info.install, "Install a package" },
              u = { package_info.update, "Update package" },
              v = { package_info.change_version, "Change package version" },
            },
          }, { silent = true, noremap = true })
        end,
      })
    end,
  },
}
