---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/neotest-jest" },
      -- { "marilari88/neotest-vitest" }, -- for vitest
      {
        "andythigpen/nvim-coverage",
        opts = {
          signs = {
            covered = { hl = "GitSignsAdd", text = "┊" },
            uncovered = { hl = "GitSignsDelete", text = "┊" },
          },
        },
      },
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>To"] = { function() require("neotest").output.open { enter = true } end, desc = "Output hover" },
            },
          },
        },
      },
    },
    ---@param _ LazySpec
    ---@param opts neotest.Config
    ---@return neotest.Config
    opts = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      opts["floating"] = {
        max_height = 0.5,
        max_width = 0.5,
      }
      ---@diagnostic disable-next-line: missing-fields
      opts["summary"] = {
        open = "botright vsplit | vertical resize 40 | setl nowrap",
      }

      -- additional adapters
      if not opts.adapters then opts.adapters = {} end
      table.insert(opts.adapters, require "rustaceanvim.neotest")
      table.insert(
        opts.adapters,
        require "neotest-jest" {
          env = { CI = true },
        }
      )

      return opts
    end,
  },
}
