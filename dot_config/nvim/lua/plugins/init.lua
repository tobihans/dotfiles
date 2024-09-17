---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      features = {
        large_buf = { size = 1024 * 100, lines = 10000 },
        autopairs = true,
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
      disable = { ft = { "grug-far" } },
    },
  },
  { "dmmulroy/tsc.nvim", enabled = false },
  { "windwp/nvim-ts-autotag", dev = true }, -- TODO: Remove later
  -- { "stevearc/aerial.nvim", dev = true }, -- HACK: Using dev versions with patches to fix that treesitter `iter_matches` api change.
  { "AstroNvim/astrotheme", enabled = false },
  { "nvimtools/none-ls.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "linux-cultist/venv-selector.nvim", enabled = false },
}
