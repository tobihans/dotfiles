-- General ====================================================================
vim.g.mapleader = ","
vim.g.maplocalleader = ";"

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.completion = true
vim.g.autoformat_enabled = true
vim.g.lsp_handlers_enabled = false

-- Vim Visual Multi (multi-cursor)
vim.g.VM_leader = "<Localleader>v"
vim.g.VM_default_mappings = 1
vim.g.VM_mouse_mappings = 1
vim.g.VM_quit_after_leaving_insert_mode = 0
vim.g.VM_insert_special_keys = { "c-v", "c-a", "c-e" }
vim.g.VM_reindent_filetypes = { "python", "yaml" }

vim.g.VM_maps = {
  ["Find Under"] = "<C-n>",
  ["Find Subword Under"] = "<C-n>",
  ["Select Cursor Down"] = "<C-M-j>",
  ["Select Cursor Up"] = "<C-M-k>",
  ["Reselect Last"] = "<C-M-.>",
  -- Enable undo/redo experimental feature
  ["Undo"] = "u",
  ["Redo"] = "<C-r>",
}

vim.o.mouse = "a"
vim.o.mousescroll = "ver:25,hor:6"
vim.o.switchbuf = "useopen,usetab,uselast"
vim.o.undofile = true

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"

-- Disable mouse item in context menu
vim.api.nvim_exec2(
  [[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-1-
]],
  {}
)
-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd "filetype plugin indent on"
if vim.fn.exists "syntax_on" ~= 1 then vim.cmd "syntax enable" end

vim.opt.wildmenu = true
vim.opt.wildignore:append "*.o,*~,*.pyc"
if vim.fn.has "win32" then
  vim.opt.wildignore:append ".git\\*,.hg\\*,.svn\\*"
else
  vim.opt.wildignore:append "*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
end

vim.opt.guicursor:append "n-v-c:blinkon500-blinkoff500"

-- Shell selection
vim.opt.sh = "nu"
vim.opt.shelltemp = false
vim.opt.shellredir = "out+err> %s"
vim.opt.shellcmdflag = "--login --stdin --no-newline -c"
vim.opt.shellxescape = ""
vim.opt.shellxquote = ""
vim.opt.shellquote = ""
vim.opt.shellpipe =
  "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record"

_G.qftf = require("quickfix").textfunc
vim.o.qftf = "{info -> v:lua._G.qftf(info)}"

vim.o.sessionoptions = "buffers,tabpages,globals"

-- UI =========================================================================
vim.o.background = "dark"
vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"
vim.o.colorcolumn = "+1"
vim.o.cmdheight = 0
vim.o.equalalways = true
vim.o.cursorline = true
vim.o.linebreak = true
vim.o.showbreak = "↪"
vim.o.textwidth = 500
vim.o.list = true
vim.o.number = true
vim.o.lazyredraw = false
vim.o.laststatus = 3
vim.o.relativenumber = true
vim.o.so = 10
vim.o.pumborder = "single"
vim.o.pumheight = 10
vim.o.pummaxwidth = 100
vim.o.pumblend = 30
vim.o.ruler = true
vim.o.shortmess = "CFOSWaco"
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.winborder = "single"
vim.o.winblend = 30
vim.o.wrap = true
vim.opt.whichwrap:append "<,>,h,l"
vim.o.errorbells = false
vim.o.visualbell = false
vim.o.cursorlineopt = "screenline,number"
vim.o.diffopt = "internal,filler,closeoff,indent-heuristic,algorithm:histogram,inline:char,context:3,linematch:60"

-- Special UI symbols.
vim.o.fillchars = "eob: ,fold: ,foldsep: ,foldopen:▼,foldclose:▶,diff:╱,vert:│,msgsep:‾,"
vim.o.listchars = "eol:↲,tab:▸ ,trail:•,nbsp:␣,extends:›,precedes:‹"

-- Folding. Defaults to indent. Treesitter and LSP used based on availability.
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldmethod = "indent"
vim.o.foldnestmax = 10
vim.o.foldtext = ""

-- Editing ====================================================================
vim.o.hid = true
vim.o.backspace = "eol,start,indent"
vim.o.autoread = true
vim.o.ffs = "unix,dos"
vim.o.encoding = "utf-8"
vim.o.writebackup = false
vim.o.backup = false
vim.o.swapfile = false
vim.o.updatetime = 250
vim.o.autoindent = true
vim.o.clipboard = "unnamedplus"
vim.o.history = 500
vim.o.expandtab = true
vim.o.formatoptions = "rqnl1j"
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 2
vim.o.showmatch = true
vim.o.matchtime = 2
vim.o.nrformats = "bin,hex,blank"
vim.o.smarttab = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelloptions = "camel"
vim.o.tabstop = 2
vim.o.timeoutlen = 500
vim.o.softtabstop = 2
vim.o.virtualedit = "block"
vim.o.secure = true
vim.o.exrc = true

vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

-- Built-in completion
vim.o.complete = ".,w,b,kspell" -- Use less sources
vim.o.completeopt = "menuone,noselect,fuzzy,nosort" -- Use custom behavior
vim.o.completetimeout = 100 -- Limit sources delay

-- Autocommands ===============================================================

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
-- Do on `FileType` to always override these changes from filetype plugins.
Config.new_autocmd(
  "FileType",
  nil,
  function() vim.cmd "setlocal formatoptions-=c formatoptions-=o" end,
  "Proper 'formatoptions'"
)

-- There are other autocommands created by 'mini.basics'. See 'plugin/30_mini.lua'.

-- Diagnostics ================================================================

-- Neovim has built-in support for showing diagnostic messages. This configures
-- a more conservative display while still being useful.
-- See `:h vim.diagnostic` and `:h vim.diagnostic.config()`.
local diagnostic_opts = {
  signs = {
    priority = 9999,
    severity = { min = "WARN", max = "ERROR" },
    text = { " ", " ", " ", " " },
  },
  underline = { severity = { min = "HINT", max = "ERROR" } },
  virtual_text = false,
  virtual_lines = {
    current_line = true,
    severity = { min = "ERROR", max = "ERROR" },
  },
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = "if_many",
    header = "",
    prefix = "",
  },
  jump = {
    on_jump = function(_, bufnr) vim.diagnostic.open_float { bufnr = bufnr, scope = "cursor", focus = false } end,
  },
}
-- Use `later()` to avoid sourcing `vim.diagnostic` on startup
Config.later(function() vim.diagnostic.config(diagnostic_opts) end)
