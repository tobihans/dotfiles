Config.now(function()
  require("snacks").setup {
    dashboard = {
      preset = {
        header = os.date "%a, %d %B %Y %I:%M %p",
        keys = {
          { icon = " ", key = "n", desc = "New File", action = "<leader>n" },
          { icon = "󰮗 ", key = "f", desc = "Find Files", action = "<leader>ff" },
          { icon = " ", key = "r", desc = "Recent Files", action = "<leader>fo" },
          { icon = " ", key = "b", desc = "Bookmarks", action = "<leader>f'" },
          { icon = " ", key = "c", desc = "Config", action = "<leader>Sc" },
          { icon = " ", key = "s", desc = "Restore Session", action = "<leader>SF" },
          { icon = " ", key = "l", desc = "Last Session", action = "<leader>Sl" },
          { icon = "󰒲 ", key = "p", desc = "Packages", action = function() vim.pack.update() end },
          { icon = " ", key = "q", desc = "Quit", action = "<leader>Q" },
        },
      },
      formats = {
        key = function(item) return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } } end,
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
      },
    },
    gh = {},
    gitbrowse = {
      notify = false,
      open = function(url) vim.fn.setreg("+", url) end,
    },
    input = { enabled = true },
    picker = {
      ui_select = true,
      sources = {
        gh_issue = {},
        gh_pr = {},
      },
    },
    quickfile = { enabled = true },
    rename = {},
    scratch = { enabled = true },
    statuscolumn = { folds = { open = true, git_hl = true } },
    styles = {
      input = { title_pos = "left", relative = "cursor", row = -3, col = 0, b = { completion = true } },
    },
    terminal = {},
    zen = { enabled = true },
  }
end)
