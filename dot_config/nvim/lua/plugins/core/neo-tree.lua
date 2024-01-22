---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.source_selector["winbar"] = false
    return opts
  end,
}

