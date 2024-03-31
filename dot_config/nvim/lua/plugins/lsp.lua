require("lspconfig.ui.windows").default_options.border = "rounded"

local lsp_util = require "lspconfig.util"

local deno_root = lsp_util.root_pattern("deno.json", "deno.jsonc")
local ts_root = lsp_util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")

local function has_vue(root)
  return vim.fn.glob("`fd -d2 -tf -1 -e'vue' --base-directory " .. root .. " --glob '*'`") ~= ""
end

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    features = {
      inlay_hints = false,
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
          if not deno_root(filename) then return lsp_util.root_pattern "tailwind.config.js"(filename) end
        end,
      },
      tsserver = {
        single_file_support = false,
        init_options = {
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
            if root and has_vue(root) then return root end
          end
        end,
      },
      ["typescript-tools"] = {
        single_file_support = false,
        root_dir = function(filename, _)
          if not deno_root(filename) then
            local root = ts_root(filename)
            if root and not has_vue(root) then return root end
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
    },
    handlers = {
      -- function(server, opts) require("lspconfig")[server].setup(opts) end,
      tsserver = function(server, opts) require("lspconfig")[server].setup(opts) end,
    },
    mappings = {
      n = {
        K = { function() vim.lsp.buf.hover() end, desc = "Hover symbol details" },
      },
    },
  },
}
