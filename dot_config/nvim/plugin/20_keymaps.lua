local pickers = require "pickers"
local misc = require "misc"

-- Helpers ====================================================================
local map = vim.keymap.set
local nmap = function(lhs, rhs, desc, opts) map("n", lhs, rhs, vim.tbl_extend("force", { desc = desc }, opts or {})) end
local xmap = function(lhs, rhs, desc, opts) map("x", lhs, rhs, vim.tbl_extend("force", { desc = desc }, opts or {})) end
local vmap = function(lhs, rhs, desc, opts) map("v", lhs, rhs, vim.tbl_extend("force", { desc = desc }, opts or {})) end
local imap = function(lhs, rhs, desc, opts) map("i", lhs, rhs, vim.tbl_extend("force", { desc = desc }, opts or {})) end
local tmap = function(lhs, rhs, desc, opts) map("t", lhs, rhs, vim.tbl_extend("force", { desc = desc }, opts or {})) end

Config.leader_groups = {
  { "<Leader>f", group = " Find" },
  { "<Leader>g", group = " Git" },
  { "<Leader>l", group = " Language", icon = "" },
  { "<Leader>s", group = " Search/Replace" },
  { "<Leader>S", group = " Session" },
  { "<Leader>t", group = " Terminal" },
  { "<Leader>u", group = " UX", icon = "󰘵" },
  { "<Leader>x", group = " List", icon = "" },
}
local nmap_leader = function(suffix, rhs, desc, opts) nmap("<Leader>" .. suffix, rhs, desc, opts) end
local xmap_leader = function(suffix, rhs, desc, opts) xmap("<Leader>" .. suffix, rhs, desc, opts) end
local vmap_leader = function(suffix, rhs, desc, opts) vmap("<Leader>" .. suffix, rhs, desc, opts) end

Config.localleader_groups = {}
local nmap_localleader = function(suffix, rhs, desc, opts) nmap("<LocalLeader>" .. suffix, rhs, desc, opts) end
-- local xmap_localleader = function(suffix, rhs, desc, opts) xmap("<LocalLeader>" .. suffix, rhs, desc, opts) end

-- Core defaults ==============================================================
-- Motion
nmap("0", "^", "First non-blank character")
nmap("j", "v:count == 0 ? 'gj' : 'j'", "Move cursor down", { expr = true, silent = true })
xmap("j", "v:count == 0 ? 'gj' : 'j'", "Move cursor down", { expr = true, silent = true })
nmap("k", "v:count == 0 ? 'gk' : 'k'", "Move cursor up", { expr = true, silent = true })
xmap("k", "v:count == 0 ? 'gk' : 'k'", "Move cursor up", { expr = true, silent = true })

-- Splits
nmap("|", "<Cmd>vsplit<CR>", "Vertical Split")
nmap("\\", "<Cmd>split<CR>", "Horizontal Split")

-- Comments
nmap("gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below")
nmap("gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above")

-- Indentation
vmap("<S-Tab>", "<gv", "Unindent line")
vmap("<Tab>", ">gv", "Indent line")

-- Diagnostics
nmap("gl", function() vim.diagnostic.open_float() end, "Hover diagnostics")

-- Navigation =================================================================
-- Tabs
nmap("]t", function() vim.cmd.tabnext() end, "Next tab")
nmap("[t", function() vim.cmd.tabprevious() end, "Previous tab")

-- Leader: General ============================================================
nmap_leader("q", "<Cmd>confirm q<CR>", "Quit Window")
nmap_leader("Q", "<Cmd>confirm qall<CR>", "Exit Neovim")
nmap_leader("w", misc.save, "Save")
nmap_leader("m", function() return "mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm" end, "Remove the ^M Windows line endings")
nmap_leader("n", pickers.new_file, "New File")
nmap_leader("/", "gcc", "Toggle comment line", { remap = true })
xmap_leader("/", "gcc", "Toggle comment", { remap = true })
nmap_leader(":", function() Snacks.picker.command_history() end, "Command History")

-- Lists
nmap_leader("xq", "<Cmd>copen<CR>", "Quickfix List")
nmap_leader("xl", "<Cmd>lopen<CR>", "Location List")

-- LocalLeader ================================================================
nmap_localleader(".", function() Snacks.scratch() end, "Toggle Scratch Buffer")
nmap_localleader("S", function() Snacks.scratch.select() end, "Select Scratch Buffer")

-- Plugin: LSP ================================================================
-- Neovim defaults
nmap("gra", function() vim.lsp.buf.code_action() end, "vim.lsp.buf.code_action()")
xmap("gra", function() vim.lsp.buf.code_action() end, "vim.lsp.buf.code_action()")
nmap("grn", function() vim.lsp.buf.rename() end, "vim.lsp.buf.rename()")
nmap("grr", function() vim.lsp.buf.references() end, "vim.lsp.buf.references()")
nmap("gri", function() vim.lsp.buf.implementation() end, "vim.lsp.buf.implementation()")
nmap("gO", function() vim.lsp.buf.document_symbol() end, "vim.lsp.buf.document_symbol()")
nmap("gD", function() vim.lsp.buf.declaration() end, "Declaration of current symbol")
nmap("gd", function() vim.lsp.buf.definition() end, "Definition of current symbol")
nmap("gK", function() vim.lsp.buf.signature_help() end, "Signature help")
nmap("gy", function() vim.lsp.buf.type_definition() end, "Definition of current type")

-- Leader actions
nmap_leader("la", function() vim.lsp.buf.code_action() end, "LSP code action")
vmap("<Leader>la", function() vim.lsp.buf.code_action() end, "LSP code action")
nmap_leader(
  "lA",
  function() vim.lsp.buf.code_action { context = { only = { "source" }, diagnostics = {} } } end,
  "LSP source action"
)
nmap_leader("ld", function() vim.diagnostic.open_float() end, "Hover diagnostics")
nmap_leader("lD", function() Snacks.picker.diagnostics() end, "Search diagnostics")
nmap_leader("lf", function() vim.lsp.buf.format { async = true } end, "Format buffer")
vmap("<Leader>lf", function() vim.lsp.buf.format { async = true } end, "Format buffer")
nmap_leader("lG", function() vim.lsp.buf.workspace_symbol() end, "Search workspace symbols")
nmap_leader("lh", function() vim.lsp.buf.signature_help() end, "Signature help")
nmap_leader("li", function() vim.cmd.checkhealth "vim.lsp" end, "Lsp Information")
nmap_leader("ll", function() vim.lsp.codelens.enable(true) end, "LSP CodeLens refresh")
nmap_leader("lL", function() vim.lsp.codelens.run() end, "LSP CodeLens run")
nmap_leader("lr", function() vim.lsp.buf.rename() end, "Rename current symbol")
nmap_leader("lR", function() vim.lsp.buf.references() end, "Search references")
nmap_leader("ls", function() Snacks.picker.lsp_symbols() end, "Search symbols")

-- LSP Toggles
nmap_leader("uf", function()
  vim.b.autoformat = not vim.b.autoformat
  vim.notify("Buffer autoformat: " .. (vim.b.autoformat and "on" or "off"))
end, "Toggle autoformatting (buffer)")
nmap_leader("uF", function()
  vim.g.autoformat = not vim.g.autoformat
  vim.notify("Global autoformat: " .. (vim.g.autoformat and "on" or "off"))
end, "Toggle autoformatting (global)")
nmap_leader("uL", function()
  local enabled = vim.lsp.codelens.enable(not vim.lsp.codelens.enable())
  vim.notify("CodeLens: " .. (enabled and "on" or "off"))
end, "Toggle CodeLens")
nmap_leader(
  "uh",
  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 }) end,
  "Toggle inlay hints (buffer)"
)
nmap_leader(
  "uH",
  function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
  "Toggle inlay hints (global)"
)
nmap_leader("uY", function()
  if vim.lsp.semantic_tokens then
    vim.b.semantic_tokens = not vim.b.semantic_tokens
    vim.notify("Semantic tokens: " .. (vim.b.semantic_tokens ~= false and "on" or "off"))
  end
end, "Toggle semantic highlighting (buffer)")

-- Plugin: Snacks =============================================================
-- Dashboard
nmap_leader("h", function()
  if vim.bo.filetype == "snacks_dashboard" then
    vim.cmd "bdelete"
  else
    Snacks.dashboard()
  end
end, "Home Screen")

-- Picker: Find
nmap_leader("f<CR>", function() Snacks.picker.resume() end, "Resume previous search")
nmap_leader("f'", function() Snacks.picker.marks() end, "Find marks")
nmap_leader("fl", function() Snacks.picker.lines() end, "Find lines")
nmap_leader(
  "fa",
  function() Snacks.picker.files { dirs = { vim.fn.stdpath "config" }, desc = "Config Files" } end,
  "Find config files"
)
nmap_leader("fb", function() Snacks.picker.buffers() end, "Find buffers")
nmap_leader("fc", function() Snacks.picker.grep_word() end, "Find word under cursor")
nmap_leader("fC", function() Snacks.picker.commands() end, "Find commands")
nmap_leader(
  "ff",
  function()
    Snacks.picker.files {
      hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
    }
  end,
  "Find files"
)
nmap_leader("fF", function() Snacks.picker.files { hidden = true, ignored = true } end, "Find all files")
nmap_leader("fh", function() Snacks.picker.help() end, "Find help")
nmap_leader("fk", function() Snacks.picker.keymaps() end, "Find keymaps")
nmap_leader("fm", function() Snacks.picker.man() end, "Find man")
nmap_leader("fn", function() Snacks.picker.notifications() end, "Find notifications")
nmap_leader("fo", function() Snacks.picker.recent() end, "Find old files")
nmap_leader("fO", function() Snacks.picker.recent { filter = { cwd = true } } end, "Find old files (cwd)")
nmap_leader("fp", function() Snacks.picker.projects() end, "Find projects")
nmap_leader("fr", function() Snacks.picker.registers() end, "Find registers")
nmap_leader("fs", function() Snacks.picker.smart() end, "Find buffers/recent/files")
nmap_leader("ft", function() Snacks.picker.colorschemes() end, "Find themes")
nmap_leader("fu", function() Snacks.picker.undo() end, "Find undo history")

if vim.fn.executable "rg" == 1 then
  nmap_leader("fw", function() Snacks.picker.grep() end, "Find words")
  nmap_leader("fW", function() Snacks.picker.grep { hidden = true, ignored = true } end, "Find words in all files")
end

-- Picker: Git
if vim.fn.executable "git" == 1 then
  nmap_leader("gb", function() Snacks.picker.git_branches() end, "Git branches")
  nmap_leader("gc", function() Snacks.picker.git_log() end, "Git commits (repository)")
  nmap_leader(
    "gC",
    function() Snacks.picker.git_log { current_file = true, follow = true } end,
    "Git commits (current file)"
  )
  nmap_leader("gI", function() Snacks.picker.gh_issue() end, "GitHub Issues (open)")
  nmap_leader("go", function() Snacks.gitbrowse() end, "Git browse (open)")
  nmap_leader("gP", function() Snacks.picker.gh_pr() end, "GitHub Pull Requests (open)")
  nmap_leader("gt", function() Snacks.picker.git_status() end, "Git status")
  nmap_leader("gT", function() Snacks.picker.git_stash() end, "Git stash")
  nmap_leader("gw", pickers.worktrees, "Worktrees")
  nmap_leader("fg", function() Snacks.picker.git_files() end, "Find git files")
end

-- Toggles
nmap_leader("u|", function() Snacks.toggle.indent():toggle() end, "Toggle indent guides")
nmap_leader("uD", function() Snacks.notifier.hide() end, "Dismiss notifications")
nmap_leader("ur", function() Snacks.toggle.words():toggle() end, "Toggle reference highlighting")
nmap_leader("uZ", function() Snacks.toggle.zen():toggle() end, "Toggle zen mode")

-- Words
nmap("]r", function() Snacks.words.jump(vim.v.count1) end, "Next reference")
nmap("[r", function() Snacks.words.jump(-vim.v.count1) end, "Previous reference")

-- Terminal
local terminal = function() Snacks.terminal.toggle() end
nmap_leader("th", terminal, "Toggle terminal")
nmap("<F7>", terminal, "Toggle terminal")
tmap("<F7>", terminal, "Toggle terminal")
imap("<F7>", terminal, "Toggle terminal")

local term_nav = require("terminal").term_nav
tmap("<C-H>", term_nav "h", "Terminal left window navigation")
tmap("<C-J>", term_nav "j", "Terminal down window navigation")
tmap("<C-K>", term_nav "k", "Terminal up window navigation")
tmap("<C-L>", term_nav "l", "Terminal right window navigation")

nmap_leader("gg", function() Snacks.terminal.toggle "mise x -- lazygit" end, "Lazygit")
nmap_leader("tl", function() Snacks.terminal.toggle "mise x -- lazygit" end, "Lazygit")
nmap_leader("td", function() Snacks.terminal.toggle "mise x -- lazydocker" end, "Lazydocker")
nmap_leader("tn", function() Snacks.terminal.toggle "mise x -- node" end, "Node REPL")

local gdu = "gdu"
if vim.fn.executable(gdu) ~= 1 then
  if vim.fn.has "win32" == 1 then
    gdu = "gdu_windows_amd64.exe"
  elseif vim.fn.has "mac" == 1 then
    gdu = "gdu-go"
  end
end
if vim.fn.executable(gdu) == 1 then
  nmap_leader("tu", function() Snacks.terminal.toggle(gdu) end, "Disk usage (gdu)")
end

if vim.fn.executable "btop" == 1 then
  nmap_leader("tt", function() Snacks.terminal.toggle "btop" end, "System stats (btop)")
end

local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
if python then nmap_leader("tp", function() Snacks.terminal.toggle("mise x -- " .. python) end, "Python REPL") end

-- Plugin: Gitsigns ===========================================================
nmap("[G", function() require("gitsigns").nav_hunk "first" end, "First Git hunk")
nmap("]G", function() require("gitsigns").nav_hunk "last" end, "Last Git hunk")
nmap("]g", function() require("gitsigns").nav_hunk "next" end, "Next Git hunk")
nmap("[g", function() require("gitsigns").nav_hunk "prev" end, "Previous Git hunk")

nmap_leader("gl", function() require("gitsigns").blame_line() end, "View Git blame")
nmap_leader("gL", function() require("gitsigns").blame_line { full = true } end, "View full Git blame")
nmap_leader("gp", function() require("gitsigns").preview_hunk_inline() end, "Preview Git hunk")
nmap_leader("gr", function() require("gitsigns").reset_hunk() end, "Reset Git hunk")
vmap("<Leader>gr", function() require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" } end, "Reset Git hunk")
nmap_leader("gR", function() require("gitsigns").reset_buffer() end, "Reset Git buffer")
nmap_leader("gs", function() require("gitsigns").stage_hunk() end, "Stage/Unstage Git hunk")
vmap("<Leader>gs", function() require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" } end, "Stage Git hunk")
nmap_leader("gS", function() require("gitsigns").stage_buffer() end, "Stage Git buffer")
nmap_leader("gd", function() require("gitsigns").diffthis() end, "View Git diff")

-- Plugin: Grug-far ==========================================================
nmap_leader("ss", function() require("grug-far").open {} end, "Grug")
nmap_leader(
  "sf",
  function() require("grug-far").open { prefills = { paths = vim.fn.expand "%" } } end,
  "Grug (current file)"
)
nmap_leader(
  "sc",
  function() require("grug-far").open { prefills = { search = vim.fn.expand "<cword>" } } end,
  "Grug (current word)"
)
vmap_leader("ss", function() require("grug-far").with_visual_selection {} end, "Grug")
vmap_leader(
  "sf",
  function() require("grug-far").with_visual_selection { prefills = { paths = vim.fn.expand "%" } } end,
  "Grug (current file)"
)

-- Plugin: Neo-tree ===========================================================
nmap_leader("e", "<Cmd>Neotree toggle<CR>", "Toggle Explorer")

-- Plugin: Resession ==========================================================
nmap_leader("Sc", misc.nvim_config, "Neovim Config")
nmap_leader("Sl", function() require("resession").load "Last Session" end, "Load last session")
nmap_leader(
  "SS",
  function() require("resession").save(vim.fn.getcwd(), { dir = "dirsession" }) end,
  "Save this dirsession"
)
nmap_leader("SD", function() require("resession").delete(nil, { dir = "dirsession" }) end, "Delete a dirsession")
nmap_leader("SF", function() require("resession").load(nil, { dir = "dirsession" }) end, "Load a dirsession")
nmap_leader(
  "S.",
  function() require("resession").load(vim.fn.getcwd(), { dir = "dirsession" }) end,
  "Load current dirsession"
)

-- Plugin: Buffers ============================================================
nmap(">b", function() require("buffer").move(vim.v.count1) end, "Move buffer tab right")
nmap("<b", function() require("buffer").move(-vim.v.count1) end, "Move buffer tab left")
nmap_leader("c", function() require("buffer").close() end, "Close buffer")
nmap_leader("C", function() require("buffer").close(0, true) end, "Force close buffer")
-- Plugin: Treesitter textobjects =================================================
local xo = { "x", "o" }
local nxo = { "n", "x", "o" }
local textobj_select = function(query)
  return function() require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects") end
end
local textobj_move = function(method, query)
  return function() require("nvim-treesitter-textobjects.move")[method](query, "textobjects") end
end
local textobj_swap = function(method, query)
  return function() require("nvim-treesitter-textobjects.swap")[method](query) end
end

map(xo, "ak", textobj_select "@block.outer", { desc = "around block" })
map(xo, "ik", textobj_select "@block.inner", { desc = "inside block" })
map(xo, "ac", textobj_select "@class.outer", { desc = "around class" })
map(xo, "ic", textobj_select "@class.inner", { desc = "inside class" })
map(xo, "a?", textobj_select "@conditional.outer", { desc = "around conditional" })
map(xo, "i?", textobj_select "@conditional.inner", { desc = "inside conditional" })
map(xo, "af", textobj_select "@function.outer", { desc = "around function" })
map(xo, "if", textobj_select "@function.inner", { desc = "inside function" })
map(xo, "ao", textobj_select "@loop.outer", { desc = "around loop" })
map(xo, "io", textobj_select "@loop.inner", { desc = "inside loop" })
map(xo, "aa", textobj_select "@parameter.outer", { desc = "around argument" })
map(xo, "ia", textobj_select "@parameter.inner", { desc = "inside argument" })

map(nxo, "]k", textobj_move("goto_next_start", "@block.outer"), { desc = "Next block start" })
map(nxo, "]f", textobj_move("goto_next_start", "@function.outer"), { desc = "Next function start" })
map(nxo, "]a", textobj_move("goto_next_start", "@parameter.inner"), { desc = "Next argument start" })
map(nxo, "]K", textobj_move("goto_next_end", "@block.outer"), { desc = "Next block end" })
map(nxo, "]F", textobj_move("goto_next_end", "@function.outer"), { desc = "Next function end" })
map(nxo, "]A", textobj_move("goto_next_end", "@parameter.inner"), { desc = "Next argument end" })
map(nxo, "[k", textobj_move("goto_previous_start", "@block.outer"), { desc = "Previous block start" })
map(nxo, "[f", textobj_move("goto_previous_start", "@function.outer"), { desc = "Previous function start" })
map(nxo, "[a", textobj_move("goto_previous_start", "@parameter.inner"), { desc = "Previous argument start" })
map(nxo, "[K", textobj_move("goto_previous_end", "@block.outer"), { desc = "Previous block end" })
map(nxo, "[F", textobj_move("goto_previous_end", "@function.outer"), { desc = "Previous function end" })
map(nxo, "[A", textobj_move("goto_previous_end", "@parameter.inner"), { desc = "Previous argument end" })

nmap(">K", textobj_swap("swap_next", "@block.outer"), "Swap next block")
nmap(">F", textobj_swap("swap_next", "@function.outer"), "Swap next function")
nmap(">A", textobj_swap("swap_next", "@parameter.inner"), "Swap next argument")
nmap("<K", textobj_swap("swap_previous", "@block.outer"), "Swap previous block")
nmap("<F", textobj_swap("swap_previous", "@function.outer"), "Swap previous function")
nmap("<A", textobj_swap("swap_previous", "@parameter.inner"), "Swap previous argument")
