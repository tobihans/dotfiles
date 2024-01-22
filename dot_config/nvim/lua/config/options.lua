-- luacheck: globals vim

vim.opt.so = 7
vim.opt.hid = true
vim.opt.ruler = true
vim.opt.cmdheight = 0
vim.opt.mouse = ""
vim.opt.history = 500
vim.opt.autoread = true
vim.opt.updatetime = 250
vim.opt.writebackup = false
vim.opt.relativenumber = true

vim.opt.shortmess:append "c"

vim.opt.wildmenu = true
vim.opt.wildignore:append "*.o,*~,*.pyc"
if vim.fn.has "win32" or vim.fn.has "win32" then
  vim.opt.wildignore:append ".git\\*,.hg\\*,.svn\\*"
else
  vim.opt.wildignore:append "*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
end

vim.opt.backspace = "eol,start,indent"
vim.opt.whichwrap:append "<,>,h,l"

vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.timeoutlen = 500

vim.opt.switchbuf = "useopen,usetab,uselast,vsplit"

-- line break on 500 chars
vim.opt.lbr = true
vim.opt.tw = 500
vim.opt.ai = true -- auto indentation
vim.opt.si = true -- smart indentation
vim.opt.wrap = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.magic = true -- magic on for regex
vim.opt.showmatch = true -- show matching brackets
vim.opt.mat = 2 -- blink for 2 thenth of a second for brackets matching

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.lazyredraw = false -- disabled due to noice.nvim

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.fillchars = "eob: "

vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false

-- Files
vim.opt.encoding = "utf-8"
vim.opt.ffs = "unix,dos"
vim.opt.background = "dark"

-- GLOBALS

vim.g.mapleader = ","
vim.g.maplocalleader = ";"

vim.g.loaded_python3_provider = false
vim.g.loaded_ruby_provider = false
vim.g.loaded_node_provider = false
vim.g.loaded_perl_provider = false

vim.g.auto_switch_bg = false
vim.g.autoformat_enabled = false
vim.g.copilot_enabled = true
vim.g.resession_enabled = true