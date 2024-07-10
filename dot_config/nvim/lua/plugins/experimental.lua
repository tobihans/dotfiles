---@type LazySpec
return {
  {
    "trunk-io/neovim-trunk",
    enabled = false,
    lazy = false,
    -- optionally pin a version
    tag = "v0.1.0",
    opts = {
      -- trunkPath = "trunk",
      -- lspArgs = {},
      formatOnSave = false,
      -- formatOnSaveTimeout = 10, -- seconds
      -- logLevel = "info",
    },
    main = "trunk",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
