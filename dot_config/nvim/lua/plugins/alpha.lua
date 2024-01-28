-- TODO: Combine figlet, lolcat, and boxes to make a dynamic footer

---@type LazySpec
return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    opts.section.header.val = {
      [[███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗███╗░░░███╗]],
      [[████╗░██║██╔════╝██╔══██╗██║░░░██║██║████╗░████║]],
      [[██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██╔████╔██║]],
      [[██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║╚██╔╝██║]],
      [[██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██║░╚═╝░██║]],
      [[╚═╝░░╚══╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝╚═╝░░░░░╚═╝]],
    }
    opts.section.header.padding = 0
    opts.margin = 0

    return opts
  end,
}
