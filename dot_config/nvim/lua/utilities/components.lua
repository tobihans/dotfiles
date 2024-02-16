local M = {}
local status = require "astroui.status"

M.clock = status.component.builder {
  {
    provider = function()
      local time = os.date "%H:%M" -- show hour and minute in 24 hour format
      ---@cast time string
      return status.utils.stylize(time, {
        icon = { kind = "Clock", padding = { right = 1 } },
        padding = { left = 1, right = 1 },
      })
    end,
  },
  update = {
    "User",
    "ModeChanged",
    callback = vim.schedule_wrap(function(_, args)
      if
        (args.event == "User" and args.match == "UpdateTime")
        or (args.event == "ModeChanged" and args.match:match ".*:.*")
      then
        vim.cmd.redrawstatus()
      end
    end),
  },
  hl = status.hl.get_attributes "mode",
  surround = { separator = "right", color = status.hl.mode_bg },
}

function M.start_clock_timer()
  vim.loop.new_timer():start(
    (60 - tonumber(os.date "%S")) * 1000, -- offset timer based on current seconds past the minute
    60000, -- update every 60 seconds
    vim.schedule_wrap(function()
      vim.api.nvim_exec_autocmds( -- emit our new User event
        "User",
        { pattern = "UpdateTime", modeline = false }
      )
    end)
  )
end

return M
