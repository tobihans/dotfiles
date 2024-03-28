---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
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
    ---@type neotest.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ---@diagnostic disable-next-line: missing-fields
      floating = {
        max_height = 0.5,
        max_width = 0.5,
      },
      ---@diagnostic disable-next-line: missing-fields
      summary = {
        open = "botright vsplit | vertical resize 40",
      },
    },
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
