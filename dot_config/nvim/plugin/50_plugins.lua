local add = vim.pack.add
local now, now_if_args, later = Config.now, Config.now_if_args, Config.later

-- Builtins ===================================================================
later(function()
  vim.cmd.packadd "nvim.difftool"
  vim.cmd.packadd "nvim.undotree"
end)

-- Tree-sitter ================================================================
now_if_args(function()
  Config.on_packchanged("nvim-treesitter", { "update" }, function() vim.cmd "TSUpdate" end, ":TSUpdate")

  -- Treesitter plugins
  add {
    "gh:nvim-treesitter/nvim-treesitter",
    "gh:nvim-treesitter/nvim-treesitter-context",
    "gh:nvim-treesitter/nvim-treesitter-textobjects",
  }

  require("treesitter-context").setup {
    enable = true,
    max_lines = 5,
    line_numbers = true,
    multiline_threshold = 10,
  }
  require("nvim-treesitter-textobjects").setup { select = { lookahead = true } }

  local treesitter = require "nvim-treesitter"
  local is_lang_available = function(lang) return vim.list_contains(treesitter.get_available(), lang) end
  local isnt_installed = function(lang) return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) == 0 end
  local start = function(bufnr)
    local win = vim.api.nvim_get_current_win()
    vim.treesitter.start(bufnr)
    -- Folding
    vim.wo[win][0].foldmethod, vim.wo[win][0].foldexpr = "expr", "v:lua.vim.treesitter.foldexpr()"
  end
  Config.new_autocmd("FileType", nil, function(ev)
    local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
    if not lang then return end

    -- Auto install missing parsers
    if isnt_installed(lang) and is_lang_available(lang) then
      treesitter.install(lang):await(function() start(ev.buf) end)
      return
    end

    if is_lang_available(lang) then start(ev.buf) end
  end, "Treesitter")
end)

-- Language servers ===========================================================
now_if_args(function()
  add { "gh:neovim/nvim-lspconfig" }

  vim.lsp.enable {
    "basedpyright",
    "cssls",
    "elixirls",
    "emmet_ls",
    "expert",
    "gopls",
    "html",
    "lua_ls",
    "nushell",
    "pyrefly",
    "ruby_lsp",
    "rust_analyzer",
    "tailwindcss",
    "tinymist",
    "vtsls",
  }

  local gr = vim.api.nvim_create_augroup("code-action-sign", { clear = true })
  vim.fn.sign_define("CodeActionSign", { text = "⬥", texthl = "Constant" })

  Config.new_autocmd("LspAttach", nil, function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Folding
    if client and client:supports_method "textDocument/foldingRange" then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod, vim.wo[win][0].foldexpr = "expr", "v:lua.vim.lsp.foldexpr()"
    end
    -- Code action sign: place sign when code actions are available on line.
    if client and client:supports_method "textDocument/codeAction" then
      -- NOTE: guard to avoid setting up autocmd many times.
      local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/codeAction" }
      if #clients > 1 then return end

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        group = gr,
        callback = function()
          local params = vim.lsp.util.make_range_params(0, "utf-16")
          local lnum = vim.fn.line "." - 1
          ---@diagnostic disable-next-line: inject-field
          params.context = { diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum }) }

          vim.fn.sign_unplace("LspCodeActionSign", { buffer = bufnr })
          vim.lsp.buf_request(bufnr, "textDocument/codeAction", params, function(err, result, ctx, _)
            if err or ctx.bufnr ~= bufnr or not vim.api.nvim_buf_is_loaded(bufnr) then return end
            if result and not vim.tbl_isempty(result) then
              local success, cursor_pos = pcall(vim.api.nvim_win_get_cursor, 0)
              -- stylua: ignore
              if success and cursor_pos then vim.fn.sign_place( 0, "LspCodeActionSign", "CodeActionSign", bufnr, { lnum = cursor_pos[1], priority = 10 }) end
            end
          end)
        end,
      })
    end
  end)

  Config.new_autocmd("LspDetach", nil, function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Code action sign: remove when no lsp with codeAction is attached.
    if client and client:supports_method "textDocument/codeAction" then
      -- NOTE: guard to avoid many attempts.
      local clients = vim.lsp.get_clients { bufnr = bufnr, method = "textDocument/codeAction" }
      if #clients > 1 then return end

      vim.fn.sign_unplace("LspCodeActionSign", { buffer = bufnr })
      vim.api.nvim_clear_autocmds { group = gr, buffer = bufnr }
    end
  end)
end)

-- Formatting =================================================================
later(function()
  add { "gh:stevearc/conform.nvim" }

  local format_async = {} -- use async formatting when formatter is slow
  local function get_autoformat(bufnr)
    if vim.g.autoformat == nil then vim.g.autoformat = true end
    local autoformat = vim.b[bufnr].autoformat
    if autoformat == nil then autoformat = vim.g.autoformat end

    return autoformat
  end

  require("conform").setup {
    default_format_opts = {
      lsp_format = "fallback",
    },
    formatters = {
      injected = {
        options = {
          ignore_errors = true,
          lang_to_formatters = {},
        },
      },
    },
    formatters_by_ft = {
      astro = { "biome", "prettier", stop_after_first = true },
      css = { "biome", "prettier", stop_after_first = true },
      graphql = { "biome", "prettier", stop_after_first = true },
      htmldjango = { "djlint" },
      hurl = { "hurlfmt", "injected" },
      javascript = { "biome", "prettier", stop_after_first = true },
      javascriptreact = { "biome", "prettier", stop_after_first = true },
      json = { "biome", "prettier", stop_after_first = true },
      lua = { "stylua" },
      markdown = { "prettierd", "prettier", "injected" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
      sql = { "sqruff" },
      svelte = { "biome", "prettier", stop_after_first = true },
      typescriptreact = { "biome", "prettier", stop_after_first = true },
      typescript = { "biome", "prettier", stop_after_first = true },
      yaml = { "yamlfmt" },
    },
    format_on_save = function(bufnr)
      if format_async[vim.bo[bufnr].filetype] then return end
      local function on_format(err)
        if err and err:match "timeout$" then format_async[vim.bo[bufnr].filetype] = true end
      end

      ---@diagnostic disable-next-line: redundant-return-value
      if get_autoformat(bufnr) then return { timeout_ms = 500, lsp_fallback = true }, on_format end
    end,
    format_after_save = function(bufnr)
      if not format_async[vim.bo[bufnr].filetype] then return end

      if get_autoformat(bufnr) then return { lsp_fallback = true } end
    end,
  }
end)

-- Linting ====================================================================
later(function()
  add { "gh:mfussenegger/nvim-lint" }

  local lint = require "lint"

  lint.linters_by_ft = {
    eruby = { "erb_lint" },
    ["eruby.yaml"] = { "yamllint" },
    htmldjango = { "djlint" },
    lua = { "selene" },
    markdown = { "markdownlint" },
    proto = { "protolint", "buf_lint" },
    sh = { "shellcheck" },
    sql = { "sqruff" },
    yaml = { "yamllint" },
  }

  Config.new_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, nil, function() lint.try_lint() end, "Lint")
end)

-- Completion & Snippets ===================================================================
later(function()
  add {
    "gh:rafamadriz/friendly-snippets",
    "gh:supermaven-inc/supermaven-nvim",
    { src = "gh:saghen/blink.cmp", version = vim.version.range "1.*" },
    { src = "gh:saghen/blink.compat", version = vim.version.range "2.*" },
  }

  require("supermaven-nvim").setup { disable_inline_completion = true, disable_keymaps = true }
  require("blink.compat").setup {}
  require("blink.cmp").setup(require "config.blink")
end)

-- User Interface =============================================================
now(function()
  add {
    "gh:rebelot/kanagawa.nvim",
    "gh:nvim-lua/plenary.nvim",
    "gh:MunifTanjim/nui.nvim",
    "gh:folke/noice.nvim",
  }

  require("noice").setup(require "config.noice")
  require("kanagawa").setup {
    colors = {
      theme = {
        all = { ui = { bg_gutter = "none" } },
      },
    },
    -- selene: allow(unused_variable)
    --- @diagnostic disable-next-line: unused-local]]
    overrides = function(colors)
      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },
      }
    end,
  }
  vim.cmd.colorscheme "kanagawa-wave"
end)

-- Keymaps XP =================================================================
later(function()
  add { "gh:folke/which-key.nvim" }
  require("which-key").setup { preset = "modern" }
  require("which-key").add(Config.leader_groups)
  require("which-key").add(Config.localleader_groups)
end)
-- Session ====================================================================
later(function()
  add { "gh:stevearc/resession.nvim" }

  require("resession").setup {
    buf_filter = function(bufnr) return require("buffer").is_restorable(bufnr) end,
    tab_buf_filter = function(tabpage, bufnr) return vim.tbl_contains(vim.t[tabpage].bufs, bufnr) end,
    extensions = {
      dap = {},
      quickfix = {},
      scope = {},
    },
  }
  require("resession").add_hook("post_load", function() vim.schedule(require("misc").load_exrc) end)

  Config.new_autocmd("VimLeavePre", nil, function()
    local save = require("resession").save
    save("Last Session", { notify = false })
    save(vim.fn.getcwd(), { dir = "dirsession", notify = false })
  end, "Save session on close")
end)
-- File Tree ==================================================================
later(function()
  add {
    { src = "https://github.com/nvim-neo-tree/neo-tree.nvim", version = vim.version.range "3" },
  }
  require("neo-tree").setup(require "config.neo-tree")
end)
-- Utils ======================================================================
now(function()
  add {
    "gh:tiagovla/scope.nvim",
    "gh:mg979/vim-visual-multi",
  }

  require("scope").setup()
end)
-- QuickFix ======================================================================
later(function()
  add { "gh:kevinhwang91/nvim-bqf" }
  require("bqf").setup {
    preview = {
      border = { "━", "━", "━", " ", "━", "━", "━", " " },
    },
    func_map = {
      fzffilter = "",
    },
  }
end)
-- Languages support ================================================================
later(function()
  add {
    "gh:lewis6991/gitsigns.nvim",
  }

  local git_sign = "┃"
  require("gitsigns").setup {
    signs = {
      add = { text = git_sign },
      change = { text = git_sign },
      delete = { text = git_sign },
      topdelete = { text = git_sign },
      changedelete = { text = git_sign },
      untracked = { text = git_sign },
    },
    signs_staged = {
      add = { text = git_sign },
      change = { text = git_sign },
      delete = { text = git_sign },
      topdelete = { text = git_sign },
      changedelete = { text = git_sign },
      untracked = { text = git_sign },
    },
  }
end)
-- Languages support ================================================================
later(function()
  add {
    "gh:tpope/vim-rails",
    "gh:b0o/schemastore.nvim", -- TODO: Configure in LSPs
  }
end)
-- Search & Replace =================================================================
later(function()
  add { "gh:MagicDuck/grug-far.nvim" }
  require("grug-far").setup {
    transient = true,
    engines = {
      astgrep = {
        path = "ast-grep",
      },
    },
  }
end)
-- Datatabase supoort ===============================================================
later(
  function()
    add {
      "gh:tpope/vim-dotenv",
      "gh:tpope/vim-dadbod",
      "gh:kristijanhusak/vim-dadbod-ui",
      "gh:kristijanhusak/vim-dadbod-completion",
    }
  end
)
-- Other plugins ====================================================================
later(function()
  add {
    "gh:NMAC427/guess-indent.nvim",
    "gh:akinsho/git-conflict.nvim",
  }
  require("guess-indent").setup()
  require("git-conflict").setup()
end)
