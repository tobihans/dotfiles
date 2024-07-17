---@type LazySpec
return {
  "luckasRanarison/nvim-devdocs",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = "DevdocsOpenFloat",
  opts = {
    -- TODO: This should adapt to resizes
    float_win = {
      relative = "editor",
      height = math.floor(0.6 * vim.o.lines),
      width = math.floor(0.7 * vim.o.columns),
      border = "rounded",
      style = "minimal",
    },
    mappings = {
      open_in_browser = "gx",
    },
    after_open = function(bufnr) vim.api.nvim_buf_set_keymap(bufnr, "n", "<Esc>", ":close<CR>", {}) end,
    ensure_installed = {
      "django-5.0",
      "django_rest_framework",
      "docker",
      "express",
      "fastapi",
      "flask-3.0",
      "go",
      "lua-5.2",
      "node",
      "postgresql-15",
      "python-3.11",
      "react",
      "react_router",
      "rust",
      "sqlite",
      "svg",
      "vite",
      "vue-3",
    },
  },
}
