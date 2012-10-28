function! Mirror(command)
    let oldpath = expand('%:p')
    execute a:command
    execute 'e ' . oldpath
endfunction

com! MirrorRight      : call Mirror('wincmd l')
com! MirrorSplitRight : call Mirror('vsplit | wincmd l')
com! MirrorLeft       : call Mirror('wincmd h')
com! MirrorSplitLeft  : call Mirror('vsplit | wincmd h')
com! MirrorBelow      : call Mirror('wincmd j')
com! MirrorSplitBelow : call Mirror('split | wincmd j')
com! MirrorAbove      : call Mirror('wincmd k')
com! MirrorSplitAbove : call Mirror('split | wincmd k')

" ======================================================================== 
" Mirror keyboard maps
" ======================================================================== 
noremap <silent> ,ml :MirrorRight<CR>
noremap <silent> ,mL :MirrorSplitRight<CR>
noremap <silent> ,mh :MirrorLeft<CR>
noremap <silent> ,mH :MirrorSplitLeft<CR>
noremap <silent> ,mk :MirrorAbove<CR>
noremap <silent> ,mK :MirrorSplitAbove<CR>
noremap <silent> ,mj :MirrorBelow<CR>
noremap <silent> ,mJ :MirrorSplitBelow<CR>
" ======================================================================== 
