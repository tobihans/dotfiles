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
    },
  },
  { "windwp/nvim-ts-autotag", dev = true }, -- TODO: Remove later
  { "AstroNvim/astrotheme", enabled = false },
  { "nvimtools/none-ls.nvim", enabled = false },
  { "jay-babu/mason-null-ls.nvim", enabled = false },
  { "dmmulroy/tsc.nvim", enabled = false },
  { "linux-cultist/venv-selector.nvim", enabled = false },
}
