-- NOTE: Copied minus comments from
-- https://www.reddit.com/r/neovim/comments/13rh66h/comment/jlm33v2
--https://www.fhug.org.uk/kb/kb-article/understanding-lua-patterns/
local mk_cs_pattern = function(pattern)
  return function(buf_id)
    local cs = vim.bo[buf_id].commentstring
    if cs == nil or cs == "" then cs = "# %s" end

    local left, right = cs:match "^(.*)%%s(.-)$"
    left, right = vim.trim(left), vim.trim(right)

    return string.format("^%%s*%s%%s*()[%%s]%s[%%p%%s]?().*%s%%s*$", vim.pesc(left), pattern, vim.pesc(right))
  end
end

---@type LazySpec
return {
  "echasnovski/mini.nvim",
  priority = 500,
  event = "User AstroFile",
  version = false,
  init = function()
    _G.minicursorword_disable = function()
      local cword = vim.fn.expand "<cword>"

      if #cword < 3 then
        vim.b.minicursorword_disable = true
        return
      end

      if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] ~= nil then
        vim.b.minicursorword_disable = not vim
          .iter(vim.treesitter.get_captures_at_cursor())
          :any(function(capture) return capture:sub(1, #"keyword") == "keyword" end)
      end

      local filetype = vim.bo.filetype

      -- Add any disabling global or filetype-specific logic here
      local blocklist = {}
      if filetype == "lua" then
        blocklist = { "local", "require" }
      elseif filetype == "javascript" then
        blocklist = { "import" }
      end

      vim.b.minicursorword_disable = vim.tbl_contains(blocklist, cword)
    end

    vim.cmd "au CursorMoved * lua _G.minicursorword_disable()"
  end,
  config = function()
    require("mini.ai").setup()
    require("mini.map").setup()
    require("mini.move").setup()
    require("mini.bufremove").setup()
    require("mini.cursorword").setup()
    require("mini.pairs").setup {
      modes = { insert = true, command = true },
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
    local hi = require "mini.hipatterns"
    require("mini.hipatterns").setup {
      highlighters = {
        warn = { pattern = mk_cs_pattern "WARN", group = "MiniHiWARN" },
        hack = { pattern = mk_cs_pattern "HACK", group = "MiniHiWARN" },
        todo = { pattern = mk_cs_pattern "TODO", group = "MiniHiTODO" },
        note = { pattern = mk_cs_pattern "NOTE", group = "MiniHiNOTE" },
        info = { pattern = mk_cs_pattern "INFO", group = "MiniHiNOTE" },
        hint = { pattern = mk_cs_pattern "HINT", group = "MiniHiNOTE" },
        perf = { pattern = mk_cs_pattern "PERF", group = "MiniHiPERF" },
        test = { pattern = mk_cs_pattern "TEST", group = "MiniHiPERF" },
        fixme = { pattern = mk_cs_pattern "FIXME", group = "MiniHiFIXME" },

        hex_color = hi.gen_highlighter.hex_color { priority = 2000 },
        shorthand = {
          pattern = "()#%x%x%x()%f[^%x%w]",
          group = function(_, _, data)
            ---@type string
            local match = data.full_match
            local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
            local hex_color = "#" .. r .. r .. g .. g .. b .. b

            -- selene: allow(undefined_variable)
            return MiniHipatterns.compute_hex_color_group(hex_color, "bg")
          end,
          extmark_opts = { priority = 2000 },
        },
      },
    }
  end,
}
