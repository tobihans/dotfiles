---@type LazySpec
return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  keys = {
    { "<Leader>:",      function() Snacks.picker.command_history() end, desc = "Command History" },
    {
      "<Leader>c",
      function()
        local bufs = vim.fn.getbufinfo { buflisted = 1 }
        require("astrocore.buffer").close(0)
        if not bufs[2] then require("snacks").dashboard() end
      end,
      desc = "Close buffer",
    },
    { "<Localleader>.", function() Snacks.scratch() end,                desc = "Toggle Scratch Buffer" },
    { "<Localleader>S", function() Snacks.scratch.select() end,         desc = "Select Scratch Buffer" },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        _G.dd = function(...) Snacks.debug.inspect(...) end
        _G.bt = function() Snacks.debug.backtrace() end
        vim.print = _G.dd
      end,
    })
  end,
  ---@type snacks.Config
  opts = {
    dashboard = {
      preset = {
        header = os.date "%a, %d %B %Y %I:%M %p",
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "n", desc = "New File", action = "<leader>n" },
          { icon = "󰮗 ", key = "f", desc = "Find Files", action = "<leader>ff" },
          { icon = " ", key = "r", desc = "Recent Files", action = "<leader>fo" },
          { icon = " ", key = "b", desc = "Bookmarks", action = "<leader>f'" },
          { icon = " ", key = "c", desc = "Config", action = "<leader>Sc" },
          { icon = " ", key = "s", desc = "Restore Session", action = "<leader>SF" },
          { icon = " ", key = "l", desc = "Last Session", action = "<leader>Sl" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = "󰏗 ", key = "M", desc = "Mason", action = ":Mason" },
          { icon = " ", key = "q", desc = "Quit", action = "<leader>Q" },
        },
      },
      formats = {
        key = function(item) return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } } end,
      },
      sections = {
        { section = "header" },
        { section = "keys",   gap = 1, padding = 1 },
        { section = "startup" },
      },
    },
    gitbrowse = {
      notify = true,
      open = function(url) vim.fn.setreg("+", url) end,
    },
    input = { enabled = true },
    quickfile = { enabled = true },
    scratch = { enabled = true },
    styles = {
      input = { title_pos = "left", relative = "cursor", row = -3, col = 0, b = { completion = true } },
    },
    zen = { enabled = true },
  },
}
