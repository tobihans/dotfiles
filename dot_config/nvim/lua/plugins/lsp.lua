require("lspconfig.ui.windows").default_options.border = "rounded"

local lsp_util = require "lspconfig.util"
local utils = require "utilities.lsp"
local join_paths = require("utilities").join_paths

local deno_root = lsp_util.root_pattern("deno.json", "deno.jsonc")
local ts_root = lsp_util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")
local py_root = lsp_util.root_pattern(
  "pyproject.toml",
  "setup.py",
  "setup.cfg",
  "requirements.txt",
  "Pipfile",
  "pyrightconfig.json",
  ".git",
  ".venv/pyvenv.cfg",
  ".env/pyvenv.cfg",
  "venv/pyvenv.cfg",
  "env/pyvenv.cfg"
)

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      inlay_hints = true,
    },
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {
          "lua",
          "python",
          "toml",
          "yaml",
          "rust",
        },
      },
      disabled = {},
      timeout_ms = 4500,
    },
    servers = {},
    ---@diagnostic disable: missing-fields
    config = {
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
      },
      cssls = {
        settings = {
          css = {
            lint = {
              unknownAtRules = "ignore",
            },
          },
        },
      },
      dartls = {
        settings = {
          showTodos = false,
        },
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").dart, { buffer = bufnr })
        end,
      },
      denols = { root_dir = deno_root },
      eslint = {
        root_dir = function(filename, _)
          if not deno_root(filename) then
            return lsp_util.root_pattern("package.json", ".eslintrc.json", ".eslintrc.js")(filename)
          end
        end,
      },
      emmet_ls = {
        filetypes = {
          "css",
          "eruby",
          "html",
          "htmldjango",
          "javascriptreact",
          "less",
          "pug",
          "sass",
          "scss",
          "typescriptreact",
          "markdown",
        },
      },
      gopls = {
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            staticcheck = true,
            gofumpt = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").go, { buffer = bufnr })
        end,
      },
      pyright = {
        on_init = function(client)
          if client.config.root_dir ~= nil then
            client.config.settings.python.pythonPath = utils.get_python_path(client.config.root_dir)
          end
        end,
        root_dir = py_root,
        settings = {
          pyright = {
            -- Using Ruff's import organizer
            disableOrganizeImports = true,
          },
          python = {
            analysis = {
              autoImportCompletions = true,
              typeCheckingMode = "standard",
            },
          },
        },
      },
      rust_analyzer = {
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").rust, { buffer = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = {
            ---@type RustAnalyzerOpts
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
          },
        },
      },
      tailwindcss = {
        root_dir = function(filename, _)
          if not deno_root(filename) then
            return lsp_util.root_pattern("tailwind.config.js", "tailwind.config.ts")(filename)
          end
        end,
      },
      tsserver = {
        single_file_support = false,
        init_options = {
          preferences = {
            includeCompletionsForModuleExports = false,
          },
          plugins = {
            {
              name = "@vue/typescript-plugin",
              location = vim.fn.stdpath "data"
                .. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin/",
              languages = { "vue" },
            },
          },
        },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "vue",
        },
        root_dir = function(filename, _)
          if not deno_root(filename) then
            local root = ts_root(filename)
            if root and utils.has_vue(root) then return root end
          end
        end,
      },
      ["typescript-tools"] = {
        single_file_support = false,
        root_dir = function(filename, _)
          if not deno_root(filename) then
            local root = ts_root(filename)
            if root and not utils.has_vue(root) then return root end
          end
        end,
      },
      typst_lsp = {
        settings = {
          exportPdf = "never", -- Choose onType, onSave or never.
        },
        on_attach = function(client, bufnr)
          require("astrolsp").on_attach(client, bufnr)
          require("which-key").register(require("config.mappings.lsp").typst, { buffer = bufnr })
        end,
      },
      volar = {
        filetypes = { "vue" },
        init_options = {
          vue = {
            hybridMode = false,
          },
        },
      },
    },
    handlers = {
      -- function(server, opts) require("lspconfig")[server].setup(opts) end,
      tsserver = function(server, opts) require("lspconfig")[server].setup(opts) end,
      ruff = false, -- use the ruff_lsp server
    },
    mappings = {
      n = {
        K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
      },
    },
  },
}
