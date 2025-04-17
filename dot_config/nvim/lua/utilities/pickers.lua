local M = {}

function M.new_file()
  vim.ui.select(vim.fn.getcompletion("", "filetype"), {
    prompt = "New File",
  }, function(ft)
    vim.cmd "enew"
    vim.cmd("setlocal filetype=" .. ft)
  end)
end

--- Switch between different LLMs for Avante, setting the appropriate API key.
function M.avante_switch_llm()
  local llms = {
    "copilot",
    "gemini",
    "groq",
  }
  vim.ui.select(llms, { prompt = "Select LLM" }, function(llm)
    if llm == nil then return end

    local env = string.format("%s_API_KEY", llm:upper())

    if llm ~= "copilot" and vim.env[env] == nil then require("utilities").secret(env, true) end

    require("avante.config").override {
      provider = llm,
    }
  end)
end

function M.quick_actions()
  vim.ui.select(require "utilities.quick_actions", {
    prompt = "󱘆 Quick Actions 󱘆",
    format_item = function(item) return string.format("%s %s", item.icon, item.desc) end,
  }, function(item)
    if item then pcall(item.fn) end
  end)
end

return M
