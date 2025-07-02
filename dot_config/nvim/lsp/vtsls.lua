---@diagnostic disable: undefined-field
local utils = require "utilities.lsp"

---@type vim.lsp.Config
---@diagnostic disable-next-line: missing-fields
return {
  workspace_required = true,
  before_init = function(_params, config)
    if config.root_dir and utils.has_vue(config.root_dir) then
      table.insert(config.settings.vtsls.tsserver.globalPlugins, {
        name = "@vue/typescript-plugin",
        location = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server",
        languages = { "vue" },
        configNamespace = "typescript",
        enableForWorkspaceTypeScriptVersions = true,
      })
    end
  end,
  settings = {
    vtsls = {
      experimental = {
        enableProjectDiagnostics = true,
        maxInlayHintLength = 40,
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
      tsserver = { globalPlugins = {} },
      typescript = {
        tsdk = "./node_modules/typescript/lib",
        preferences = {
          includePackageJsonAutoImports = "off",
          importModuleSpecifier = "relative",
        },
        inlayHints = {
          parameterTypes = { enabled = true },
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = {
            enabled = false,
            suppressWhenTypeMatchesName = true,
          },
          parameterNames = {
            enabled = "all",
            suppressWhenArgumentMatchesName = true,
          },
        },
      },
      javascript = {
        preferences = {
          includePackageJsonAutoImports = "off",
          importModuleSpecifier = "relative",
        },
        inlayHints = {
          parameterTypes = { enabled = true },
          enumMemberValues = { enabled = true },
          functionLikeReturnTypes = { enabled = true },
          propertyDeclarationTypes = { enabled = true },
          variableTypes = {
            enabled = false,
            suppressWhenTypeMatchesName = true,
          },
          parameterNames = {
            enabled = "all",
            suppressWhenArgumentMatchesName = true,
          },
        },
      },
    },
  },
}
