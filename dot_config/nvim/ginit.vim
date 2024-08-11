" GUI Configuration
let g:neovide_scale_factor=1.0
let g:neovide_theme = 'auto'

function! ChangeScaleFactor(delta)
  let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
endfunction

nnoremap <expr><C-=> ChangeScaleFactor(1.125)
nnoremap <expr><C--> ChangeScaleFactor(1/1.125)
map! <C-S-V> <C-R>+

set mouse=a
