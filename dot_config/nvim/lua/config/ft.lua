local function yaml_ft(path, bufnr)
  local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")

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
    ["dot_bash.*"] = "sh",
    ["dot.*.sh"] = "sh",
    ["dot_functions.*"] = "sh",
  },
  filename = {
    ["env.example"] = "sh",
    ["env.dist"] = "sh",
    [".env.example"] = "sh",
    [".env.dist"] = "sh",
    ["docker-compose.yaml"] = "yaml.docker-compose",
  },
}
