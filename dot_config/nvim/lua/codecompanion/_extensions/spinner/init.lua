--- TODO: Draw inspiration from https://github.com/olimorris/codecompanion.nvim/discussions/640

--- An extension to display a spinner when request is ongoing.
---@class CodeCompanion.Extension
---@field setup fun() Function called when extension is loaded
local Extension = {}

---Setup the extension
function Extension.setup()
  vim.api.nvim_create_autocmd("User", {
    pattern = {
      "CodeCompanionRequestStarted",
      "CodeCompanionRequestFinished",
    },
    callback = function(args)
      if args.match == "CodeCompanionRequestStarted" then
        require("external.spinner").show()
      elseif args.match == "CodeCompanionRequestFinished" then
        require("external.spinner").hide(false)
      end
    end,
  })
end

return Extension
