-- Buffer Management Autocommands
vim.api.nvim_create_augroup("BufferManagement", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter " }, { -- Read file updates when modiied externally
  group = "BufferManagement",
  pattern = "*",
  command = "checktime",
})
vim.api.nvim_create_autocmd("BufReadPost", { -- Return to last edit position when opening files
  group = "BufferManagement",
  pattern = "*",
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
})
