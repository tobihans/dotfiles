---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      features = {
        cmp = true,
        highlighturl = true,
        notifications = true,
      },
      diagnostics = {
        underline = true,
        virtual_text = false,
        virtual_lines = { current_line = true },
        update_in_insert = false,
      },
      sessions = {
        autosave = {
          last = true,
          cwd = true,
        },
        ignore = {
          dirs = {
            "/",
            "/tmp",
            vim.fn.expand "~",
            vim.fn.expand "~/dev",
            vim.fn.expand "~/dev/github",
            vim.fn.expand "~/dev/gitlab",
            vim.fn.expand "~/Downloads",
            vim.fn.expand "~/Documents/",
            vim.fn.expand "~/Desktop/",
          },
          filetypes = { "gitcommit", "gitrebase", "octo", "sql" },
          buftypes = {},
        },
      },
      mappings = {
        n = {
          ["<C-Up>"] = false,
          ["<C-Down>"] = false,
          ["<C-Left>"] = false,
          ["<C-Right>"] = false,
          ["<Leader>ua"] = false,
          ["<Leader>uA"] = false,
          ["<Leader>o"] = false,
          ["<Leader>th"] = false,
          ["<Leader>tv"] = false,
          ["<Leader>tb"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      features = { inlay_hints = true },
      formatting = {
        format_on_save = {
          enabled = true,
        },
        disabled = {},
        timeout_ms = 5000,
      },
      native_lsp_config = true,
      --- Loads extra mappings for the given language server, if any.
      on_attach = function(_client, bufnr)
        local mappings = require("config.mappings.lsp")[vim.bo[bufnr].filetype]
        if mappings then require("which-key").add(mappings, { buffer = bufnr }) end
      end,
    },
  },
  {
    "AstroNvim/astroui",
    opts = {
      icons = {
        Calendar = "",
        Clock = "",
        CloseNeovim = "󱎘",
        DiagnosticUnknown = "",
        GitAdd = "",
        GitBranch = "",
        GitChange = "",
        GitDelete = "",
        NeovimConfig = "",
        Project = "",
        ScrollText = "",
        VimIcon = "",
        Linux = "",
        Darwin = "",
      },
      status = {
        attributes = {
          mode = { bold = true },
        },
        icon_highlights = {
          file_icon = {
            statusline = false,
          },
        },
        separators = {
          center = { "  ", "  " },
          -- left = { "", "" },
          none = { "", "" },
          -- right = { " ", "" },
          -- tab = { "", "" },
        },
      },
      lazygit = false,
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
    },
  },
  { "AstroNvim/astrotheme",             enabled = false },
  { "L3MON4D3/LuaSnip",                 enabled = false },
  { "RRethy/vim-illuminate",            enabled = false },
  { "dmmulroy/tsc.nvim",                enabled = false },
  { "echasnovski/mini.icons",           enabled = false },
  { "linux-cultist/venv-selector.nvim", enabled = false },
  { "nvimtools/none-ls.nvim",           enabled = false },
  { "sigmasd/deno-nvim",                enabled = false },
  { "windwp/nvim-autopairs",            enabled = false },
  { "windwp/nvim-ts-autotag",           enabled = false },
  { "akinsho/toggleterm.nvim",          enabled = false },
}
