-- stylua: ignore start
local palette = {
  base00 = '#1b222c', base01 = '#202b36', base02 = '#293745', base03 = '#425364',
  base04 = '#8094a5', base05 = '#c5d0d4', base06 = '#d9e0dd', base07 = '#edf2ed',
  base08 = '#c77b88', base09 = '#c99a67', base0A = '#c2ac75', base0B = '#8ca88c',
  base0C = '#7faeaa', base0D = '#82a8c6', base0E = '#a593bc', base0F = '#ac8573',
}
-- stylua: ignore end

require("mini.base16").setup { palette = palette, use_cterm = true }
require("base16").preferences(palette)

vim.g.colors_name = "tideglass"
