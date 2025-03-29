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
    local env = string.format("%s_API_KEY", llm:upper())

    if llm ~= "copilot" and vim.env[env] == nil then require("utilities").secret(env, true) end

    require("avante.config").override {
      provider = llm,
    }
  end)
end

return M
