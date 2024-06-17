---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/neotest-jest" },
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
      table.insert(
        opts.adapters,
        require "neotest-jest" {
          env = { CI = true },
        }
      )

      return opts
    end,
  },
  {
    "andythigpen/nvim-coverage",
    init = function()
      require("which-key").register {
        ["<Leader>Tc"] = { name = " Coverage" },
      }
    end,
    keys = {
      { "<Leader>Tcl", "<cmd>CoverageLoad<cr>", desc = "Load coverage" },
      { "<Leader>Tcc", "<cmd>CoverageClear<cr>", desc = "Clear coverage" },
      { "<Leader>Tcs", "<cmd>CoverageSummary<cr>", desc = "Summary" },
      { "<Leader>Tct", "<cmd>CoverageToggle<cr>", desc = "Toggle coverage signs" },
    },
    opts = {
      signs = {
        covered = { hl = "GitSignsAdd", text = "┊" },
        uncovered = { hl = "GitSignsDelete", text = "┊" },
      },
    },
  },
}
