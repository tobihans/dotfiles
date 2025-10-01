vim.filetype.add {
  filename = {
    [".env"] = "dotenv",
    ["uv.lock"] = "toml",
    ["inventory.txt"] = "confini",
    ["docker-compose.yaml"] = "yaml.docker-compose",
  },
  extension = {
    har = "json",
    hurl = "hurl",
    mdx = "mdx",
    mjml = "html",
    meta = "json",
    tcss = "tcss",
    wsx = "xml",
    wxl = "xml",
  },
  pattern = {
    -- Chezmoi dotfiles
    ["dot_bash.*"] = "sh",
    ["dot.*%.sh"] = "sh",
    ["dot_functions.*"] = "sh",
    ["%.env%.[%w_.-]+"] = "dotenv",
    ["docker%-compose[%w_.-]*%.ya?ml"] = "yaml.docker-compose",
  },
}

-- Aliases
vim.treesitter.language.register("markdown", "mdx")
vim.treesitter.language.register("bash", "dotenv")
vim.treesitter.language.register("css", "tcss")
vim.treesitter.language.register("yaml", "eruby.yaml")
