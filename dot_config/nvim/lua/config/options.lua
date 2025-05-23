vim.opt.so = 10
vim.opt.mouse = "a"
vim.opt.hid = true
vim.opt.ruler = true
vim.opt.cmdheight = 0
vim.opt.equalalways = true
vim.opt.history = 500
vim.opt.autoread = true
vim.opt.updatetime = 250
vim.opt.writebackup = false
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.opt.winblend = 30
vim.opt.pumblend = 30

vim.opt.shortmess:append "c"

vim.opt.wildmenu = true
vim.opt.wildignore:append "*.o,*~,*.pyc"
if vim.fn.has "win32" then
  vim.opt.wildignore:append ".git\\*,.hg\\*,.svn\\*"
else
  vim.opt.wildignore:append "*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store"
end

vim.opt.guicursor:append "n-v-c:blinkon500-blinkoff500"

vim.opt.backspace = "eol,start,indent"
vim.opt.whichwrap:append "<,>,h,l"

vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.timeoutlen = 500

vim.opt.switchbuf = "useopen,usetab,uselast"
vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.lbr = true
vim.opt.tw = 500
vim.opt.ai = true -- auto indentation
vim.opt.si = true -- smart indentation
vim.opt.wrap = true
vim.opt.showbreak = "↪"
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.magic = true -- magic on for regex
vim.opt.showmatch = true -- show matching brackets
vim.opt.mat = 2 -- blink for 2 thenth of a second for brackets matching
vim.opt.nrformats = "bin,hex,blank"
vim.opt.spelllang:append "fr"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.lazyredraw = false -- disabled due to noice.nvim
vim.opt.laststatus = 3

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.fillchars = { eob = " ", diff = "╱", fold = " " }

vim.opt.list = true
vim.opt.listchars = { eol = "↲", tab = " ", trail = "•", nbsp = "␣", extends = "»", precedes = "«" }

vim.opt.backup = false
vim.opt.wb = false
vim.opt.swapfile = false

-- Files
vim.opt.encoding = "utf-8"
vim.opt.ffs = "unix,dos"
vim.opt.background = "dark"

-- Local configs
vim.o.secure = true
vim.o.exrc = true

-- GLOBALS

vim.g.mapleader = ","
vim.g.maplocalleader = ";"

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

vim.g.icons_enabled = true
vim.g.autoformat_enabled = true

-- Disable mouse item in context menu
vim.api.nvim_exec2(
  [[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-1-
]],
  {}
)

if vim.fn.executable "nu" == 1 then
  vim.opt.sh = "nu"
  vim.opt.shelltemp = false
  vim.opt.shellredir = "out+err> %s"
  vim.opt.shellcmdflag = "--login --stdin --no-newline -c"
  vim.opt.shellxescape = ""
  vim.opt.shellxquote = ""
  vim.opt.shellquote = ""
  vim.opt.shellpipe =
    "| complete | update stderr { ansi strip } | tee { get stderr | save --force --raw %s } | into record"
elseif vim.fn.has "win32" == 1 then
  vim.cmd [[
  let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
  let &shellcmdflag = '-NoLogo -NoProfileLoadTime -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues[''Out-File:Encoding'']=''utf8'';Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
  let &shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
  let &shellpipe  = '2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode'
  set shellquote= shellxquote=
  ]]
end
