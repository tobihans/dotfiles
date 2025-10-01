-- Buffer Management Autocommands
vim.api.nvim_create_augroup("BufferManagement", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, { -- Read file updates when modiied externally
  group = "BufferManagement",
  pattern = "*",
  command = "checktime",
})
vim.api.nvim_create_autocmd("BufReadPost", { -- Return to last edit position when opening files
  group = "BufferManagement",
  pattern = "*",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
})
vim.api.nvim_create_autocmd("FileType", {
  group = "BufferManagement",
  pattern = "man",
  command = [[setl nobuflisted]],
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { -- Enable spell checking for certain file types
  pattern = { "*.txt", "*.md", "*.typ" },
  command = [[setlocal spell]],
})
vim.api.nvim_create_autocmd("LspAttach", { -- TODO: Check back later. Disable inlay hints for now in vue files.
  callback = function(args)
    if vim.bo[args.buf].filetype == "vue" then vim.lsp.inlay_hint.enable(false, { bufnr = args.buf }) end
  end,
})

vim.api.nvim_create_autocmd("DirChanged", { -- Loads local configuration file when cwd changes
  -- This is especially useful with Neovide, where I use :cd a lot.
  group = vim.api.nvim_create_augroup("LoadExrc", { clear = true }),
  pattern = "global",
  callback = function(_event) require("utilities").load_exrc() end,
})
