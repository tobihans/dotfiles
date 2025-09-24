---@type LazySpec
return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "double",
        width = 0.8,
        height = 0.8,
        icons = {
          package_installed = "✓",
          package_uninstalled = "✗",
          package_pending = "⟳",
        },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- LSPs
        "ansible-language-server",
        "astro-language-server",
        "bash-language-server",
        "biome",
        "css-lsp",
        "deno",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "gopls",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "shfmt",
        "taplo",
        "tinymist",
        "vue-language-server",
        "vtsls",
        "yaml-language-server",
        -- DAPs
        "bash-debug-adapter",
        "codelldb",
        "delve",
        "debugpy",
      },
    },
  },
}
