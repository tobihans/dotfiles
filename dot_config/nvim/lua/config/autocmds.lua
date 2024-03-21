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

-- https://dpaste.org/rGFLg/slim#L11
-- Auto suggest to install missing Treesitter parsers
-- TODO: Improve on it
local ask_install = {}
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TSAskInstall", { clear = true }),
  pattern = "*",
  callback = function()
    local function get_char_input() return vim.fn.nr2char(vim.fn.getchar()) end
    --- clears the command prompt
    local function clear_prompt() vim.api.nvim_command "normal! :" end

    local parsers = require "nvim-treesitter.parsers"
    local lang = parsers.get_buf_lang()
    if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) and ask_install[lang] ~= false then
      vim.schedule_wrap(function()
        local is_confirmed = false
        -- TODO: implement a Y/n prompt util func
        print("Install treesitter parser for " .. lang .. " ? Y/n")
        local res = get_char_input()
        if res:match "\r" then is_confirmed = true end
        if res:match "y" then is_confirmed = true end
        if res:match "Y" then is_confirmed = true end
        clear_prompt()
        if is_confirmed then
          vim.cmd("TSInstall " .. lang)
        else
          ask_install[lang] = false
        end
      end)()
    end
  end,
})
-- Terminal Autocommands
-- vim.api.nvim_create_autocmd("TermEnter", {
--   group = vim.api.nvim_create_augroup("TerminalSetup", { clear = true }),
--   command = [[setl nonumber norelativenumber signcolumn=no statusline=]],
-- })
