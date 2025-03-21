---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      features = {
        large_buf = { size = 1024 * 100, lines = 10000 },
        cmp = true,
        highlighturl = true,
        notifications = true,
      },
      diagnostics = {
        virtual_text = false,
        underline = true,
        update_in_insert = true,
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
        },
      },
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
          left = { "", "" },
          none = { "", "" },
          right = { " ", "" },
          tab = { "", "" },
        },
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
      disable = { ft = { "grug-far" } },
    },
  },
  { "rcarriga/nvim-notify", opts = { render = "wrapped-compact" } },
  { "AstroNvim/astrotheme", enabled = false },
  { "L3MON4D3/LuaSnip", enabled = false },
  { "NvChad/nvim-colorizer.lua", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  { "dmmulroy/tsc.nvim", enabled = false },
  { "echasnovski/mini.bufremove", enabled = false },
  { "folke/todo-comments.nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "linux-cultist/venv-selector.nvim", enabled = false },
  { "nvim-tree/nvim-web-devicons", enabled = false },
  { "nvimtools/none-ls.nvim", enabled = false },
  { "onsails/lspkind.nvim", enabled = false },
  { "sigmasd/deno-nvim", enabled = false },
  { "windwp/nvim-autopairs", enabled = false },
  { "windwp/nvim-ts-autotag", enabled = false },
}
