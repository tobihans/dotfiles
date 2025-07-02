---@type LazySpec
return {
  "echasnovski/mini.nvim",
  event = "User AstroFile",
  version = false,
  init = function()
    -- mini.cursorword
    _G.minicursorword_disable = function()
      if #vim.fn.expand "<cword>" <= 2 then
        vim.b.minicursorword_disable = true
      elseif vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil then
        vim.b.minicursorword_disable = vim.iter(vim.treesitter.get_captures_at_cursor()):any(
          function(capture) return capture:match "^keyword" or capture:find "builtin" end
        )
      end
    end
    vim.cmd "au CursorMoved * lua _G.minicursorword_disable()"

    -- mini.icons
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
  config = function()
    require("mini.diff").setup {
      source = require("mini.diff").gen_source.none(),
    }
    require("mini.move").setup()
    require("mini.bufremove").setup()
    require("mini.cursorword").setup()
    require("mini.pairs").setup {
      modes = { insert = true, command = true },
    }
    require("mini.ai").setup {
      n_lines = 75,
      search_method = "cover_or_nearest",
    }
    require("mini.surround").setup {
      mappings = {
        add = "ys",
        delete = "ds",
        replace = "cs",
        find = "fs",
        find_left = "fS",
        highlight = "hs",
        update_n_lines = "ns",
      },
    }
    require("mini.icons").setup {
      style = "glyph",
      default = {},
      lsp = {
        supermaven = { glyph = "", hl = "MiniIconsBlue" },
      },
      extension = {
        d2 = { glyph = "", hl = "MiniIconsBlue" },
      },
    }
  end,
}
