---@type LazySpec
return {
  {
    "NStefan002/2048.nvim",
    cmd = "Play2048",
    init = function()
      require("which-key").register {
        ["<Leader>G2"] = { "<cmd>Play2048<cr>", "2048" },
      }
    end,
    config = true,
  },
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    init = function()
      require("which-key").register {
        ["<Leader>Gc"] = {
          name = " Cellular Automaton",
          g = { "<cmd>CellularAutomaton game_of_life<cr>", "Game of Life" },
          r = { "<cmd>CellularAutomaton make_it_rain<cr>", "Make it Rain" },
        },
      }
    end,
    config = true,
  },
  -- { 'zyedidia/vim-snake' }
}
