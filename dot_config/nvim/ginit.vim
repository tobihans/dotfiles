" GUI Configuration
let g:neovide_scale_factor=1.0
let g:neovide_theme = 'auto'
let g:neovide_transparency = 0.981
let g:neovide_fullscreen = v:false
let g:neovide_cursor_animate_command_line = v:false
let g:neovide_cursor_vfx_particle_lifetime = 2.1
let g:neovide_cursor_vfx_particle_density = 20.0
let g:neovide_cursor_vfx_mode = "pixiedust"
let g:neovide_padding_top = 0
let g:neovide_padding_bottom = 0
let g:neovide_padding_right = 0
let g:neovide_padding_left = 0
let g:neovide_floating_shadow = v:false

if has("win32")
  ChangeScaleFactor(1/1.125)
endif

function! ChangeScaleFactor(delta)
  let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
endfunction

nnoremap <expr><C-=> ChangeScaleFactor(1.125)
nnoremap <expr><C--> ChangeScaleFactor(1/1.125)
map! <C-S-V> <C-R>+

set mouse=a
