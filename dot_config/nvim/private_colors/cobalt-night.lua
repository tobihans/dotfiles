-- stylua: ignore start
local palette = {
  base00 = '#1d2230', base01 = '#242a39', base02 = '#30394a', base03 = '#526074',
  base04 = '#8593a7', base05 = '#c7ced9', base06 = '#dbe1e9', base07 = '#edf1f6',
  base08 = '#c77e91', base09 = '#c99868', base0A = '#b8a975', base0B = '#8eaa8b',
  base0C = '#81aca8', base0D = '#7f9fc0', base0E = '#a28fba', base0F = '#ac8578',
}
-- stylua: ignore end

require("mini.base16").setup { palette = palette, use_cterm = true }
require("base16").preferences(palette)

vim.g.colors_name = "cobalt-nightebony"
