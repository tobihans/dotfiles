return {
  "folke/snacks.nvim",
  specs = {
    {
      "AstroNvim/astrocore",
      opts = function(_, opts)
        local maps = opts.mappings
        local astro = require "astrocore"
        maps.n["<Leader>t"] = vim.tbl_get(opts, "_map_sections", "t")

        if vim.fn.executable "git" == 1 and vim.fn.executable "lazygit" == 1 then
          maps.n["<Leader>g"] = vim.tbl_get(opts, "_map_sections", "g")
          local lazygit = {
            callback = function()
              local worktree = astro.file_worktree()
              local flags = worktree and (" --work-tree=%s --git-dir=%s"):format(worktree.toplevel, worktree.gitdir)
                  or ""
              Snacks.terminal.toggle("mise x -- lazygit " .. flags)
            end,
            desc = "Lazygit",
          }
          maps.n["<Leader>gg"] = { lazygit.callback, desc = lazygit.desc }
          maps.n["<Leader>tl"] = { lazygit.callback, desc = lazygit.desc }
        end

        if vim.fn.executable "lazydocker" == 1 then
          maps.n["<Leader>td"] = { function() Snacks.terminal.toggle "mise x -- lazydocker" end, desc = "Lazydocker" }
        end

        if vim.fn.executable "node" == 1 then
          maps.n["<Leader>tn"] = { function() Snacks.terminal.toggle "mise x -- node" end, desc = "Node REPL" }
        end

        local gdu = "gdu"
        if vim.fn.executable(gdu) ~= 1 then
          if vim.fn.has "win32" == 1 then
            gdu = "gdu_windows_amd64.exe"
          elseif vim.fn.has "mac" == 1 then
            gdu = "gdu-go"
          end
        end
        if vim.fn.executable(gdu) == 1 then
          maps.n["<Leader>tu"] = { function() Snacks.terminal.toggle(gdu) end, desc = "Disk usage (gdu)" }
        end

        if vim.fn.executable "btop" == 1 then
          maps.n["<Leader>tt"] = { function() Snacks.terminal.toggle "btop" end, desc = "System stats (btop)" }
        end

        local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
        if python then
          maps.n["<Leader>tp"] = { function() Snacks.terminal.toggle("mise x -- " .. python) end, desc = "Python REPL" }
        end

        -- local opencode = function() Snacks.terminal.toggle "mise x node@latest npm:opencode-ai -- opencode" end
        -- maps.n["<F12>"] = { opencode, desc = "OpenCode CLI" }
        -- maps.n["<Leader>to"] = { opencode, desc = "OpenCode CLI" }
        -- maps.n["<F12>"] = { opencode, desc = "OpenCode CLI" }
        -- maps.t["<F12>"] = { opencode, desc = "OpenCode CLI" }
        -- maps.i["<F12>"] = { opencode, desc = "OpenCode CLI" }

        local terminal = function() Snacks.terminal.toggle() end
        maps.n["<Leader>th"] = { terminal, desc = "Toggle terminal" }
        maps.n["<F7>"] = { terminal, desc = "Toggle terminal" }
        maps.t["<F7>"] = { terminal, desc = "Toggle terminal" }
        maps.i["<F7>"] = { terminal, desc = "Toggle terminal" }
      end,
    },
  },
  ---@type snacks.Config
  opts = {
    terminal = {},
  },
}
