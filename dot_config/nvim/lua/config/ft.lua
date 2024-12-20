local function yaml_ft(path, bufnr)
  local content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  local path_regex, regex = nil, nil

  -- Docker compose
  path_regex = vim.regex "docker-compose.*\\.y[a]ml"
  if path_regex and path_regex:match_str(path) then
    return "yaml.docker-compose"
  else
    regex = vim.regex "services:\\|volumes:\\|networks:"
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
  filename = {
    [".env"] = "dotenv",
    [".swcrc"] = "json",
    ["inventory.txt"] = "confini",
  },
  extension = {
    har = "json",
    hurl = "hurl",
    mdx = "mdx",
    meta = "json",
    tcss = "tcss",
    wsx = "xml",
    wxl = "xml",
    yaml = yaml_ft,
    yml = yaml_ft,
  },
  pattern = {
    -- Chezmoi dotfiles
    ["dot_bash.*"] = "sh",
    ["dot.*.sh"] = "sh",
    ["dot_functions.*"] = "sh",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
}

-- Aliases
vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("bash", "dotenv")
vim.treesitter.language.register("css", "tcss")
vim.treesitter.language.register("yaml", "eruby.yaml")
