local now, later = Config.now, Config.later

-- Step one ===================================================================

-- mini.basics -> Common configuration presets.
now(
  function()
    require("mini.basics").setup {
      options = { basic = false, extra_ui = false, win_borders = "bold" },
      mappings = {
        basics = false,
        windows = true,
        option_toggle_prefix = [[<Leader>u]],
        move_with_alt = true,
      },
    }
  end
)
-- mini.extras -> Extra useful functionalities.
now(function() require("mini.extra").setup {} end)

-- mini.icons -> Icon provider.
now(function()
  local ext3_blocklist = { scm = true, txt = true, yml = true }
  local ext4_blocklist = { json = true, yaml = true }
  require("mini.icons").setup {
    style = "glyph",
    default = {},
    use_file_extension = function(ext, _) return not (ext3_blocklist[ext:sub(-3)] or ext4_blocklist[ext:sub(-4)]) end,
    lsp = {
      supermaven = { glyph = "", hl = "MiniIconsBlue" },
    },
    extension = {
      d2 = { glyph = "", hl = "MiniIconsBlue" },
    },
  }

  later(MiniIcons.mock_nvim_web_devicons)
  later(MiniIcons.tweak_lsp_kind)
end)

-- mini.statusline -> Statusline. Sets `:h 'statusline'` to show more info in a line below window.
now(function() require("mini.statusline").setup() end)

-- mini.tabline -> Tabline. Sets `:h 'tabline'` to show all listed buffers in a line at the top.
now(function() require("mini.tabline").setup() end)

-- Step two ===================================================================
-- Load now if Neovim is started like `nvim -- path/to/file`, otherwise - later.
-- e.g now_if_args(...)

-- Step three ===================================================================

-- mini.ai -> Extend and create a/i textobjects, like `:h a(`, `:h a'`, and more).
later(function()
  local ai = require "mini.ai"
  local gen_ai_spec = require("mini.extra").gen_ai_spec
  ai.setup {
    n_lines = 75,
    search_method = "cover_or_nearest",
    custom_textobjects = {
      B = gen_ai_spec.buffer(),
      D = gen_ai_spec.diagnostic(),
      I = gen_ai_spec.indent(),
      L = gen_ai_spec.line(),
      N = gen_ai_spec.number(),
    },
  }
end)

-- mini.bracketed -> Go forward/backward with square brackets.
later(function()
  require("mini.bracketed").setup {
    treesitter = { suffix = "" },
  }
end)

-- mini.bufremove -> Remove buffers. Opened files occupy space in tabline and buffer picker.
later(function() require("mini.bufremove").setup() end)

-- mini.comment -> Comment lines. Provides functionality to work with commented lines.
-- Uses `:h 'commentstring'` option to infer comment structure.
later(function() require("mini.comment").setup() end)

-- mini.cursorword -> Autohighlight word under cursor.
later(function()
  local minicursorword_disable = function()
    if #vim.fn.expand "<cword>" <= 3 then
      vim.b.minicursorword_disable = true
    elseif vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil then
      vim.b.minicursorword_disable = vim.iter(vim.treesitter.get_captures_at_cursor()):any(
        function(capture) return capture:match "^keyword" or capture:find "builtin" end
      )
    end
  end
  Config.new_autocmd("CursorMoved", "*", minicursorword_disable, "mini.cursorword disable")

  require("mini.cursorword").setup()
end)

-- Work with diff hunks that represent the difference between the buffer text and
-- some reference text set by a source. Default source uses text from Git index.
-- Also provides summary info used in developer section of 'mini.statusline'.
-- Example usage:
-- - `ghip` - apply hunks (`gh`) within *i*nside *p*aragraph
-- - `gHG` - reset hunks (`gH`) from cursor until end of buffer (`G`)
-- - `ghgh` - apply (`gh`) hunk at cursor (`gh`)
-- - `gHgh` - reset (`gH`) hunk at cursor (`gh`)
-- - `<Leader>go` - toggle overlay
--
-- See also:
-- - `:h MiniDiff-overview` - overview of how module works
-- - `:h MiniDiff-diff-summary` - available summary information
-- - `:h MiniDiff.gen_source` - available built-in sources
-- later(function() require("mini.diff").setup() end)

-- mini.hipatterns -> Highlight patterns in text.
later(function()
  local hipatterns = require "mini.hipatterns"
  local hi_words = MiniExtra.gen_highlighter.words
  hipatterns.setup {
    highlighters = {
      -- Highlight a fixed set of common words. Will be highlighted in any place,
      -- not like "only in comments".
      fixme = hi_words({ "FIXME", "Fixme", "fixme" }, "MiniHipatternsFixme"),
      hack = hi_words({ "HACK", "Hack", "hack" }, "MiniHipatternsHack"),
      todo = hi_words({ "TODO", "Todo", "todo" }, "MiniHipatternsTodo"),
      note = hi_words({ "NOTE", "Note", "note" }, "MiniHipatternsNote"),
      -- Highlight hex color string (#aabbcc) with that color as a background
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  }
end)

-- mini.indentscope -> Visualize and work with indent scope.
later(function() require("mini.indentscope").setup() end)

-- mini.keymap -> Special key mappings.
later(function()
  require("mini.keymap").setup()
  --- Escape into Normal mode from Insert or Command-line mode
  MiniKeymap.map_combo({ "i", "c", "x", "s" }, "jk", "<BS><BS><Esc>")
  MiniKeymap.map_combo({ "i", "c", "x", "s" }, "kj", "<BS><BS><Esc>")
  -- Escape into Normal mode from Terminal mode
  MiniKeymap.map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
  MiniKeymap.map_combo("t", "kj", "<BS><BS><C-\\><C-n>")
  -- Reload in normal mode
  MiniKeymap.map_combo({ "n" }, "jk", "<cmd>edit<cr>")
  MiniKeymap.map_combo({ "n" }, "kj", "<cmd>edit<cr>")
  --- Hide search highlighting
  MiniKeymap.map_combo({ "n", "i", "x", "c" }, "<Esc><Esc>", "<cmd>noh | NoiceDismiss<cr>")
end)

-- mini.move -> Move any selection in any direction.
later(function() require("mini.move").setup() end)

-- mini.pairs -> Autopairs functionality.
later(function() require("mini.pairs").setup { modes = { insert = true, command = true } } end)

-- mini.surround -> Surround actions: add/delete/replace/find/highlight.
later(
  function()
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
  end
)
