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
-- TODO: Check back later. Disable inlay hints for now in vue files.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    if vim.bo[bufnr].filetype == "vue" then vim.lsp.inlay_hint.enable(false, { bufnr = bufnr }) end
  end,
})

--- Loads local configuration file when cwd changes
--- This is especially useful with Neovide, where I use :cd a lot.
vim.api.nvim_create_autocmd("DirChanged", {
  group = vim.api.nvim_create_augroup("LoadExrc", { clear = true }),
  pattern = "global",
  callback = function(_event) require("utilities").load_exrc() end,
})
