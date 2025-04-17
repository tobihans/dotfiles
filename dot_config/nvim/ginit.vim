" GUI Configuration
let g:neovide_scale_factor=1.0
let g:neovide_theme = 'auto'
let g:neovide_transparency = 0.99
let g:neovide_position_animation_length = 0.1
let g:neovide_scroll_animation_length = 0.1
let g:neovide_cursor_animation_length = 0.1
let g:neovide_fullscreen = v:false
let g:neovide_cursor_animate_command_line = v:false
let g:neovide_cursor_animate_in_insert_mode = v:false
let g:neovide_cursor_vfx_mode = rand() % 2 == 0 ? "sonicboom" : "pixiedust"
let g:neovide_cursor_vfx_particle_lifetime = 1.1
let g:neovide_cursor_vfx_particle_density = 10.0
let g:neovide_floating_shadow = v:false
let g:neovide_padding_top = 1
let g:neovide_padding_bottom = 0
let g:neovide_padding_right = 0
let g:neovide_padding_left = 5

if has("win32")
  let g:neovide_fullscreen = v:true
  let g:neovide_scale_factor = g:neovide_scale_factor * (1/1.125)
endif

map! <C-S-V> <C-R>+
