-- luacheck: globals vim

local function yaml_ft(path, bufnr)
  local content = vim.filetype.getlines(bufnr)
  if type(content) == "table" then content = table.concat(content, "\n") end

  -- check if file is in roles, tasks, or handlers folder
  local path_regex = vim.regex "(tasks\\|roles\\|handlers)/"
  if path_regex and path_regex:match_str(path) then return "yaml.ansible" end
  -- check for known ansible playbook text and if found, return yaml.ansible
  local regex = vim.regex "hosts:\\|tasks:"
  if regex and regex:match_str(content) then return "yaml.ansible" end

  return "yaml"
end

vim.filetype.add {
  extension = {
    yml = yaml_ft,
    yaml = yaml_ft,
    hurl = "hurl",
  },
  pattern = {
    -- Chezmoi dotfiles
    ["dot_bash.*"] = "bash",
    ["dot.*.sh"] = "bash",
    ["dot_functions.*"] = "bash",
    ["env.*"] = "bash",
    [".env.*"] = "bash",
  },
  filename = {
    ["docker-compose.yaml"] = "yaml.docker-compose",
  },
}
