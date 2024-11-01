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
        NeovimConfig = "",
        Project = "",
        DiagnosticUnknown = "",
      },
      status = {
        attributes = {
          mode = { bold = true },
        },
        colors = {},
        separators = {
          none = { "", "" },
          left = { "", "  " },
          right = { "  ", "" },
          center = { "  ", "  " },
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
  { "dmmulroy/tsc.nvim", enabled = false },
  { "sigmasd/deno-nvim", enabled = false },
  { "windwp/nvim-ts-autotag", enabled = false },
  { "AstroNvim/astrotheme", enabled = false },
  { "windwp/nvim-autopairs", enabled = false },
  { "RRethy/vim-illuminate", enabled = false },
  { "nvimtools/none-ls.nvim", enabled = false },
  { "NvChad/nvim-colorizer.lua", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "js-everts/cmp-tailwind-colors", enabled = true },
  { "linux-cultist/venv-selector.nvim", enabled = false },
  { "folke/todo-comments.nvim", enabled = false },
  { "echasnovski/mini.bufremove", enabled = false },
}
