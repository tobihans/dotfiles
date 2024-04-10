local function yaml_ft(path, bufnr)
  local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  local path_regex, regex = nil, nil

  -- Docker compose
  path_regex = vim.regex "docker-compose.*\\.y[a]ml"
  if path_regex and path_regex:match_str(path) then
    return "yaml.docker-compose"
  else
    regex = vim.regex "version:\\|services:\\|volumes:\\|networks:"
    if regex and regex:match_str(content) then return "yaml.docker-compose" end
  end

  -- Ansible
  path_regex = vim.regex "(tasks\\|roles\\|handlers)/"
  if path_regex and path_regex:match_str(path) then
    return "yaml.ansible"
  else
    regex = vim.regex "hosts:\\|tasks:\\|become:"
    if regex and regex:match_str(content) then return "yaml.ansible" end
  end

  return "yaml"
end

vim.filetype.add {
  extension = {
    yml = yaml_ft,
    yaml = yaml_ft,
    hurl = "hurl",
    mdx = "markdown",
  },
  pattern = {
    -- Chezmoi dotfiles
    ["dot_bash.*"] = "sh",
    ["dot.*.sh"] = "sh",
    ["dot_functions.*"] = "sh",
    ["\\.env(\\.\\w*)?"] = "sh",
  },
}
